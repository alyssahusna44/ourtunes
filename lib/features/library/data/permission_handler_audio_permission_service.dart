import 'package:permission_handler/permission_handler.dart' as ph;

import 'package:ourtunes/features/library/domain/audio_permission_service.dart';
import 'package:ourtunes/features/library/domain/media_store_source.dart';

/// Android 13 (API 33) and above use the audio permission. Older versions
/// still need the storage permission, so the choice depends on the API level.
class PermissionHandlerAudioPermissionService implements AudioPermissionService {
  PermissionHandlerAudioPermissionService(this._source);

  final MediaStoreSource _source;

  Future<ph.Permission> _permission() async {
    final sdk = await _source.sdkInt();
    return sdk >= 33 ? ph.Permission.audio : ph.Permission.storage;
  }

  @override
  Future<AudioPermissionStatus> status() async {
    return _map(await (await _permission()).status);
  }

  @override
  Future<AudioPermissionStatus> request() async {
    return _map(await (await _permission()).request());
  }

  @override
  Future<void> openSettings() async {
    await ph.openAppSettings();
  }

  AudioPermissionStatus _map(ph.PermissionStatus status) {
    if (status.isGranted || status.isLimited) {
      return AudioPermissionStatus.granted;
    }
    if (status.isPermanentlyDenied) {
      return AudioPermissionStatus.permanentlyDenied;
    }
    return AudioPermissionStatus.denied;
  }
}
