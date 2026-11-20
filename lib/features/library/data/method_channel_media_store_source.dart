import 'package:flutter/services.dart';

import 'package:ourtunes/features/library/domain/device_audio_file.dart';
import 'package:ourtunes/features/library/domain/media_store_source.dart';

/// Talks to the Kotlin MediaStoreBridge over a MethodChannel.
class MethodChannelMediaStoreSource implements MediaStoreSource {
  MethodChannelMediaStoreSource({MethodChannel? channel})
      : _channel = channel ?? const MethodChannel(channelName);

  static const String channelName =
      'io.github.alyssahusna44.ourtunes/media_store';

  final MethodChannel _channel;

  @override
  Future<int> sdkInt() async {
    return await _channel.invokeMethod<int>('sdkInt') ?? 0;
  }

  @override
  Future<List<DeviceAudioFile>> queryAudio() async {
    try {
      final rows =
          await _channel.invokeListMethod<Map<Object?, Object?>>('queryAudio');
      return (rows ?? const <Map<Object?, Object?>>[]).map(_fromMap).toList();
    } on PlatformException catch (error) {
      if (error.code == 'permission_denied') {
        throw const MediaStorePermissionException();
      }
      rethrow;
    }
  }

  @override
  Stream<void> get changes => const Stream<void>.empty();

  DeviceAudioFile _fromMap(Map<Object?, Object?> map) {
    int? asInt(String key) => (map[key] as num?)?.toInt();
    String? asString(String key) => map[key] as String?;
    bool asBool(String key) => map[key] == true;

    return DeviceAudioFile(
      mediaStoreId: asInt('id')!,
      uri: asString('uri')!,
      sizeBytes: asInt('sizeBytes') ?? 0,
      dateModified: asInt('dateModified') ?? 0,
      relativePath: asString('relativePath'),
      displayName: asString('displayName'),
      durationMs: asInt('durationMs'),
      title: asString('title'),
      artist: asString('artist'),
      album: asString('album'),
      albumArtist: asString('albumArtist'),
      year: asInt('year'),
      trackNo: asInt('trackNo'),
      isMusic: asBool('isMusic'),
      isRingtone: asBool('isRingtone'),
      isNotification: asBool('isNotification'),
      isAlarm: asBool('isAlarm'),
      isPodcast: asBool('isPodcast'),
      isAudiobook: asBool('isAudiobook'),
      isRecording: asBool('isRecording'),
    );
  }
}
