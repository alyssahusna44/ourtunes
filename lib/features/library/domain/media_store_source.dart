import 'package:ourtunes/features/library/domain/device_audio_file.dart';

/// Thrown when the audio permission is missing, so callers can ask for it
/// instead of treating the library as empty.
class MediaStorePermissionException implements Exception {
  const MediaStorePermissionException();

  @override
  String toString() => 'Audio permission has not been granted.';
}

/// Reads audio files from the device. The real implementation talks to
/// Android MediaStore; tests use a fake.
abstract class MediaStoreSource {
  /// The Android API level.
  Future<int> sdkInt();

  /// Every audio file MediaStore knows about, without any filtering.
  /// Throws [MediaStorePermissionException] if access is not granted.
  Future<List<DeviceAudioFile>> queryAudio();

  /// Emits when MediaStore reports a change. Empty for now; a live observer
  /// can be added later without changing the scanner.
  Stream<void> get changes;
}
