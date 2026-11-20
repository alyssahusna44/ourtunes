import 'package:ourtunes/features/library/data/library_scan_store.dart';
import 'package:ourtunes/features/library/domain/device_audio_file.dart';
import 'package:ourtunes/features/library/domain/exclusion_rules.dart';
import 'package:ourtunes/features/library/domain/media_store_source.dart';
import 'package:ourtunes/features/library/domain/scan_result.dart';

/// Compares the device with the database and applies the differences.
///
/// - New files are added, changed files (size or date modified) are updated.
/// - Files that disappear (or no longer match the rules) are marked missing,
///   not deleted, and restored if they come back.
/// - Only one scan runs at a time. A request that arrives during a scan
///   queues exactly one more scan, which makes repeated calls safe (for
///   example from a future live observer).
class LibraryScanner {
  LibraryScanner({
    required MediaStoreSource source,
    required LibraryScanStore store,
    ExclusionRules rules = const ExclusionRules(),
  })  : _source = source,
        _store = store,
        _rules = rules;

  final MediaStoreSource _source;
  final LibraryScanStore _store;
  final ExclusionRules _rules;

  Future<ScanResult>? _running;
  bool _rescanQueued = false;

  Future<ScanResult> scan() {
    final running = _running;
    if (running != null) {
      _rescanQueued = true;
      return running;
    }
    final future = _runUntilIdle().whenComplete(() {
      _running = null;
    });
    _running = future;
    return future;
  }

  Future<ScanResult> _runUntilIdle() async {
    var result = await _scanOnce();
    while (_rescanQueued) {
      _rescanQueued = false;
      result = await _scanOnce();
    }
    return result;
  }

  Future<ScanResult> _scanOnce() async {
    // A permission error is thrown here, before anything is changed, so a
    // revoked permission can never make the whole library look missing.
    final files = await _source.queryAudio();
    final folders = _normalise(await _store.includedFolders());
    final snapshot = await _store.snapshot();

    final excluded = <ExclusionReason, int>{};
    var outsideFolders = 0;
    final kept = <DeviceAudioFile>[];
    for (final file in files) {
      if (!_isInIncludedFolder(file, folders)) {
        outsideFolders++;
        continue;
      }
      final reason = _rules.check(file);
      if (reason != null) {
        excluded[reason] = (excluded[reason] ?? 0) + 1;
        continue;
      }
      kept.add(file);
    }

    final keptIds = <int>{};
    final toAdd = <DeviceAudioFile>[];
    final toUpdate = <DeviceAudioFile>[];
    final restoreIds = <int>{};
    var restored = 0;
    for (final file in kept) {
      keptIds.add(file.mediaStoreId);
      final existing = snapshot[file.mediaStoreId];
      if (existing == null) {
        toAdd.add(file);
      } else if (existing.dateModified != file.dateModified ||
          existing.sizeBytes != file.sizeBytes) {
        toUpdate.add(file);
        if (existing.isMissing) restored++;
      } else if (existing.isMissing) {
        restoreIds.add(file.mediaStoreId);
        restored++;
      }
    }

    final missingIds = <int>{
      for (final entry in snapshot.values)
        if (!entry.isMissing && !keptIds.contains(entry.mediaStoreId))
          entry.mediaStoreId,
    };

    await _store.apply(
      toAdd: toAdd,
      toUpdate: toUpdate,
      restoreIds: restoreIds,
      missingIds: missingIds,
    );

    return ScanResult(
      filesOnDevice: files.length,
      added: toAdd.length,
      updated: toUpdate.length,
      restored: restored,
      markedMissing: missingIds.length,
      outsideFolders: outsideFolders,
      excluded: excluded,
    );
  }

  /// Folder names end with a slash so "Music" does not match "MusicOld/".
  List<String> _normalise(List<String> folders) {
    return [
      for (final folder in folders)
        if (folder.trim().isNotEmpty)
          folder.endsWith('/') ? folder : '$folder/',
    ];
  }

  bool _isInIncludedFolder(DeviceAudioFile file, List<String> folders) {
    if (folders.isEmpty) return true;
    final path = file.relativePath;
    if (path == null) return false;
    return folders.any(path.startsWith);
  }
}
