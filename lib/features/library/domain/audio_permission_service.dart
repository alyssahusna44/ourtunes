enum AudioPermissionStatus { granted, denied, permanentlyDenied }

/// Asks for permission to read the user's audio files.
abstract class AudioPermissionService {
  Future<AudioPermissionStatus> status();
  Future<AudioPermissionStatus> request();
  Future<void> openSettings();
}
