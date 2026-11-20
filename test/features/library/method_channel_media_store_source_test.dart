import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/features/library/data/method_channel_media_store_source.dart';
import 'package:ourtunes/features/library/domain/media_store_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel(MethodChannelMediaStoreSource.channelName);
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('parses the rows sent by the Kotlin bridge', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'queryAudio');
      return [
        {
          'id': 7,
          'uri': 'content://media/external/audio/media/7',
          'sizeBytes': 2048,
          'dateModified': 1700000000,
          'relativePath': 'Music/Rock/',
          'durationMs': 200000,
          'title': 'Song',
          'artist': null,
          'year': 1999,
          'trackNo': 3,
          'isMusic': true,
          'isRingtone': false,
        },
      ];
    });

    final files = await MethodChannelMediaStoreSource().queryAudio();

    expect(files, hasLength(1));
    final file = files.single;
    expect(file.mediaStoreId, 7);
    expect(file.relativePath, 'Music/Rock/');
    expect(file.durationMs, 200000);
    expect(file.artist, isNull);
    expect(file.year, 1999);
    expect(file.trackNo, 3);
    expect(file.isMusic, isTrue);
    expect(file.isRingtone, isFalse);
    expect(file.isPodcast, isFalse);
  });

  test('maps the permission_denied error to a typed exception', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      throw PlatformException(code: 'permission_denied');
    });

    await expectLater(
      MethodChannelMediaStoreSource().queryAudio(),
      throwsA(isA<MediaStorePermissionException>()),
    );
  });

  test('reads the Android API level', () async {
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'sdkInt');
      return 34;
    });

    expect(await MethodChannelMediaStoreSource().sdkInt(), 34);
  });
}
