import 'package:ourtunes/features/library/data/library_local_source.dart';
import 'package:ourtunes/features/library/data/library_scanner.dart';
import 'package:ourtunes/features/library/domain/audio_permission_service.dart';
import 'package:ourtunes/features/library/domain/library_repository.dart';
import 'package:ourtunes/features/library/domain/library_track.dart';
import 'package:ourtunes/features/library/domain/scan_result.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  LibraryRepositoryImpl({
    required LibraryLocalSource localSource,
    required LibraryScanner scanner,
    required AudioPermissionService permissions,
  })  : _localSource = localSource,
        _scanner = scanner,
        _permissions = permissions;

  final LibraryLocalSource _localSource;
  final LibraryScanner _scanner;
  final AudioPermissionService _permissions;

  @override
  Stream<List<LibraryTrack>> watchTracks(TrackSortField sortBy) {
    return _localSource.watchTracks(sortBy);
  }

  @override
  Future<ScanResult> rescan() => _scanner.scan();

  @override
  Future<AudioPermissionStatus> permissionStatus() => _permissions.status();

  @override
  Future<AudioPermissionStatus> requestPermission() => _permissions.request();

  @override
  Future<void> openPermissionSettings() => _permissions.openSettings();
}
