/// An audio file as reported by Android MediaStore, before any filtering.
///
/// Missing values are null. The flags come from MediaStore and are used by
/// the exclusion rules to leave out ringtones, voice notes and similar files.
class DeviceAudioFile {
  const DeviceAudioFile({
    required this.mediaStoreId,
    required this.uri,
    required this.sizeBytes,
    required this.dateModified,
    this.relativePath,
    this.displayName,
    this.durationMs,
    this.title,
    this.artist,
    this.album,
    this.albumArtist,
    this.year,
    this.trackNo,
    this.isMusic = true,
    this.isRingtone = false,
    this.isNotification = false,
    this.isAlarm = false,
    this.isPodcast = false,
    this.isAudiobook = false,
    this.isRecording = false,
  });

  final int mediaStoreId;
  final String uri;
  final int sizeBytes;

  /// Seconds since the epoch, as reported by MediaStore.
  final int dateModified;

  /// Folder of the file inside shared storage, for example "Music/Rock/".
  final String? relativePath;
  final String? displayName;
  final int? durationMs;
  final String? title;
  final String? artist;
  final String? album;
  final String? albumArtist;
  final int? year;
  final int? trackNo;

  final bool isMusic;
  final bool isRingtone;
  final bool isNotification;
  final bool isAlarm;
  final bool isPodcast;
  final bool isAudiobook;
  final bool isRecording;
}
