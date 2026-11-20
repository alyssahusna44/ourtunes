import 'package:ourtunes/features/library/domain/audio_permission_service.dart';
import 'package:ourtunes/features/library/domain/library_track.dart';
import 'package:ourtunes/features/library/domain/scan_result.dart';

/// What the UI needs from the library. Screens talk to this interface and
/// never to the database, MediaStore or permission plugins directly.
abstract class LibraryRepository {
  Stream<List<LibraryTrack>> watchTracks(TrackSortField sortBy);

  /// Scans the device and updates the library. Safe to call repeatedly.
  Future<ScanResult> rescan();

  Future<AudioPermissionStatus> permissionStatus();
  Future<AudioPermissionStatus> requestPermission();
  Future<void> openPermissionSettings();
}
