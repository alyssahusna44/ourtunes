import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/features/library/domain/device_audio_file.dart';
import 'package:ourtunes/features/library/domain/exclusion_rules.dart';

DeviceAudioFile _file({
  bool isMusic = true,
  bool isRingtone = false,
  bool isNotification = false,
  bool isAlarm = false,
  bool isPodcast = false,
  bool isAudiobook = false,
  bool isRecording = false,
  int? durationMs = 180000,
  String? relativePath = 'Music/',
}) {
  return DeviceAudioFile(
    mediaStoreId: 1,
    uri: 'content://media/external/audio/media/1',
    sizeBytes: 1000,
    dateModified: 1,
    relativePath: relativePath,
    durationMs: durationMs,
    isMusic: isMusic,
    isRingtone: isRingtone,
    isNotification: isNotification,
    isAlarm: isAlarm,
    isPodcast: isPodcast,
    isAudiobook: isAudiobook,
    isRecording: isRecording,
  );
}

void main() {
  const rules = ExclusionRules();

  test('keeps an ordinary music file', () {
    expect(rules.check(_file()), isNull);
  });

  test('excludes system sounds', () {
    expect(rules.check(_file(isRingtone: true)), ExclusionReason.systemSound);
    expect(
      rules.check(_file(isNotification: true)),
      ExclusionReason.systemSound,
    );
    expect(rules.check(_file(isAlarm: true)), ExclusionReason.systemSound);
  });

  test('excludes spoken word', () {
    expect(rules.check(_file(isPodcast: true)), ExclusionReason.spokenWord);
    expect(rules.check(_file(isAudiobook: true)), ExclusionReason.spokenWord);
    expect(rules.check(_file(isRecording: true)), ExclusionReason.spokenWord);
  });

  test('excludes files not flagged as music', () {
    expect(rules.check(_file(isMusic: false)), ExclusionReason.notMusic);
  });

  test('excludes files shorter than 30 seconds but keeps exactly 30', () {
    expect(rules.check(_file(durationMs: 29999)), ExclusionReason.tooShort);
    expect(rules.check(_file(durationMs: 30000)), isNull);
  });

  test('does not exclude when the duration is unknown', () {
    expect(rules.check(_file(durationMs: null)), isNull);
    expect(rules.check(_file(durationMs: 0)), isNull);
  });

  test('the duration rule can be switched off', () {
    const noDuration = ExclusionRules(minDurationMs: 0);
    expect(noDuration.check(_file(durationMs: 5000)), isNull);
  });

  test('excludes recording and voice note folders', () {
    expect(
      rules.check(_file(relativePath: 'Recordings/Call/')),
      ExclusionReason.excludedFolder,
    );
    expect(
      rules.check(_file(relativePath: 'WhatsApp/Media/WhatsApp Voice Notes/')),
      ExclusionReason.excludedFolder,
    );
    expect(
      rules.check(_file(relativePath: 'Music/Voice Memos/')),
      ExclusionReason.excludedFolder,
    );
  });

  test('keeps ordinary folders, including ones with similar words', () {
    expect(rules.check(_file(relativePath: 'Music/Rock/')), isNull);
    expect(rules.check(_file(relativePath: 'Music/Voices of the Wild/')), isNull);
    expect(rules.check(_file(relativePath: null)), isNull);
  });

  test('system sound flags win over other rules', () {
    expect(
      rules.check(_file(isRingtone: true, isMusic: false, durationMs: 1000)),
      ExclusionReason.systemSound,
    );
  });
}
