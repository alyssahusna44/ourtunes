import 'package:ourtunes/features/library/domain/device_audio_file.dart';

/// Why a file was left out of the library.
enum ExclusionReason {
  systemSound('system sounds'),
  spokenWord('spoken word'),
  notMusic('not music'),
  tooShort('too short'),
  excludedFolder('excluded folders');

  const ExclusionReason(this.label);

  final String label;
}

/// Default rules for leaving out ringtones, voice notes and similar audio.
///
/// The rules are plain Dart so they are easy to change and to test. They run
/// in this order and the first match wins.
class ExclusionRules {
  const ExclusionRules({
    this.minDurationMs = defaultMinDurationMs,
    this.folderPatterns = defaultFolderPatterns,
  });

  static const int defaultMinDurationMs = 30000;

  /// Matched (lower case) against each folder name in the relative path.
  static const List<String> defaultFolderPatterns = [
    'recording',
    'recorder',
    'voice note',
    'voice memo',
    'call record',
    'whatsapp voice',
    'ringtone',
    'notification',
    'alarm',
  ];

  /// Files shorter than this are excluded. Use 0 to switch the rule off.
  final int minDurationMs;
  final List<String> folderPatterns;

  /// Returns the reason the file is excluded, or null if it should be kept.
  ExclusionReason? check(DeviceAudioFile file) {
    if (file.isRingtone || file.isNotification || file.isAlarm) {
      return ExclusionReason.systemSound;
    }
    if (file.isPodcast || file.isAudiobook || file.isRecording) {
      return ExclusionReason.spokenWord;
    }
    if (!file.isMusic) {
      return ExclusionReason.notMusic;
    }
    final duration = file.durationMs;
    if (minDurationMs > 0 &&
        duration != null &&
        duration > 0 &&
        duration < minDurationMs) {
      return ExclusionReason.tooShort;
    }
    if (_inExcludedFolder(file.relativePath)) {
      return ExclusionReason.excludedFolder;
    }
    return null;
  }

  bool _inExcludedFolder(String? relativePath) {
    if (relativePath == null) return false;
    for (final segment in relativePath.toLowerCase().split('/')) {
      for (final pattern in folderPatterns) {
        if (segment.contains(pattern)) return true;
      }
    }
    return false;
  }
}
