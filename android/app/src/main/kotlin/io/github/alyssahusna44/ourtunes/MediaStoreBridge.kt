package io.github.alyssahusna44.ourtunes

import android.Manifest
import android.content.ContentUris
import android.content.Context
import android.content.pm.PackageManager
import android.database.Cursor
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.provider.MediaStore
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executors

/**
 * Reads audio files from Android MediaStore and returns them to Dart.
 *
 * Methods:
 *  - sdkInt: the Android API level (Dart uses it to pick the permission)
 *  - queryAudio: one map per audio file, including MediaStore flags such as
 *    is-music and is-ringtone. Filtering is decided on the Dart side.
 *
 * The query runs on a background thread. If the audio permission is missing,
 * the call fails with the error code "permission_denied".
 */
class MediaStoreBridge(private val context: Context) : MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL = "io.github.alyssahusna44.ourtunes/media_store"
        private const val UNKNOWN = "<unknown>"
    }

    private val executor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())

    fun register(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "sdkInt" -> result.success(Build.VERSION.SDK_INT)
            "queryAudio" -> queryAudioAsync(result)
            else -> result.notImplemented()
        }
    }

    private fun queryAudioAsync(result: MethodChannel.Result) {
        if (!hasAudioPermission()) {
            result.error("permission_denied", "Audio permission is not granted.", null)
            return
        }
        executor.execute {
            try {
                val rows = queryAudio()
                mainHandler.post { result.success(rows) }
            } catch (e: Exception) {
                mainHandler.post { result.error("query_failed", e.message, null) }
            }
        }
    }

    private fun hasAudioPermission(): Boolean {
        val permission = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            Manifest.permission.READ_MEDIA_AUDIO
        } else {
            Manifest.permission.READ_EXTERNAL_STORAGE
        }
        return context.checkSelfPermission(permission) == PackageManager.PERMISSION_GRANTED
    }

    @Suppress("DEPRECATION")
    private fun queryAudio(): List<Map<String, Any?>> {
        val sdk = Build.VERSION.SDK_INT
        val collection: Uri = if (sdk >= Build.VERSION_CODES.Q) {
            MediaStore.Audio.Media.getContentUri(MediaStore.VOLUME_EXTERNAL)
        } else {
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
        }

        // Only ask for columns that exist on this Android version.
        val columns = mutableListOf(
            MediaStore.Audio.Media._ID,
            MediaStore.Audio.Media.DISPLAY_NAME,
            MediaStore.Audio.Media.SIZE,
            MediaStore.Audio.Media.DATE_MODIFIED,
            MediaStore.Audio.Media.DURATION,
            MediaStore.Audio.Media.TITLE,
            MediaStore.Audio.Media.ARTIST,
            MediaStore.Audio.Media.ALBUM,
            MediaStore.Audio.Media.YEAR,
            MediaStore.Audio.Media.TRACK,
            MediaStore.Audio.Media.IS_MUSIC,
            MediaStore.Audio.Media.IS_RINGTONE,
            MediaStore.Audio.Media.IS_NOTIFICATION,
            MediaStore.Audio.Media.IS_ALARM,
            MediaStore.Audio.Media.IS_PODCAST,
        )
        if (sdk >= Build.VERSION_CODES.Q) {
            columns.add(MediaStore.Audio.Media.RELATIVE_PATH)
            columns.add(MediaStore.Audio.Media.IS_AUDIOBOOK)
        } else {
            columns.add(MediaStore.Audio.Media.DATA)
        }
        if (sdk >= Build.VERSION_CODES.R) {
            columns.add(MediaStore.Audio.Media.ALBUM_ARTIST)
        }
        if (sdk >= Build.VERSION_CODES.S) {
            columns.add(MediaStore.Audio.Media.IS_RECORDING)
        }

        val rows = ArrayList<Map<String, Any?>>()
        context.contentResolver.query(collection, columns.toTypedArray(), null, null, null)
            ?.use { cursor ->
                val idColumn = cursor.getColumnIndexOrThrow(MediaStore.Audio.Media._ID)
                while (cursor.moveToNext()) {
                    val id = cursor.getLong(idColumn)
                    val relativePath = if (sdk >= Build.VERSION_CODES.Q) {
                        cursor.stringOrNull(MediaStore.Audio.Media.RELATIVE_PATH)
                    } else {
                        legacyRelativePath(cursor.stringOrNull(MediaStore.Audio.Media.DATA))
                    }
                    rows.add(
                        mapOf(
                            "id" to id,
                            "uri" to ContentUris.withAppendedId(collection, id).toString(),
                            "displayName" to cursor.stringOrNull(MediaStore.Audio.Media.DISPLAY_NAME),
                            "relativePath" to relativePath,
                            "sizeBytes" to (cursor.longOrNull(MediaStore.Audio.Media.SIZE) ?: 0L),
                            "dateModified" to (cursor.longOrNull(MediaStore.Audio.Media.DATE_MODIFIED) ?: 0L),
                            "durationMs" to cursor.longOrNull(MediaStore.Audio.Media.DURATION)?.takeIf { it > 0 },
                            "title" to cursor.stringOrNull(MediaStore.Audio.Media.TITLE),
                            "artist" to cursor.stringOrNull(MediaStore.Audio.Media.ARTIST),
                            "album" to cursor.stringOrNull(MediaStore.Audio.Media.ALBUM),
                            "albumArtist" to cursor.stringOrNull(MediaStore.Audio.Media.ALBUM_ARTIST),
                            "year" to cursor.longOrNull(MediaStore.Audio.Media.YEAR)?.takeIf { it > 0 },
                            // MediaStore stores disc number * 1000 + track number.
                            "trackNo" to cursor.longOrNull(MediaStore.Audio.Media.TRACK)
                                ?.let { it % 1000 }
                                ?.takeIf { it > 0 },
                            "isMusic" to cursor.flag(MediaStore.Audio.Media.IS_MUSIC),
                            "isRingtone" to cursor.flag(MediaStore.Audio.Media.IS_RINGTONE),
                            "isNotification" to cursor.flag(MediaStore.Audio.Media.IS_NOTIFICATION),
                            "isAlarm" to cursor.flag(MediaStore.Audio.Media.IS_ALARM),
                            "isPodcast" to cursor.flag(MediaStore.Audio.Media.IS_PODCAST),
                            "isAudiobook" to cursor.flag(MediaStore.Audio.Media.IS_AUDIOBOOK),
                            "isRecording" to cursor.flag(MediaStore.Audio.Media.IS_RECORDING),
                        )
                    )
                }
            }
        return rows
    }

    /** Android 9 and below have no RELATIVE_PATH, so derive it from the file path. */
    @Suppress("DEPRECATION")
    private fun legacyRelativePath(dataPath: String?): String? {
        if (dataPath == null) return null
        val root = Environment.getExternalStorageDirectory().absolutePath
        val parent = dataPath.substringBeforeLast('/', "")
        if (!parent.startsWith(root)) return null
        val relative = parent.removePrefix(root).trim('/')
        return if (relative.isEmpty()) "" else "$relative/"
    }

    /** MediaStore uses "<unknown>" for missing artist and album; map it to null. */
    private fun Cursor.stringOrNull(column: String): String? {
        val index = getColumnIndex(column)
        if (index < 0 || isNull(index)) return null
        val value = getString(index)?.trim()
        return if (value.isNullOrEmpty() || value == UNKNOWN) null else value
    }

    private fun Cursor.longOrNull(column: String): Long? {
        val index = getColumnIndex(column)
        return if (index < 0 || isNull(index)) null else getLong(index)
    }

    private fun Cursor.flag(column: String): Boolean {
        val index = getColumnIndex(column)
        return index >= 0 && !isNull(index) && getInt(index) != 0
    }
}
