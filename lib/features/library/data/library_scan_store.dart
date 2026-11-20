import 'package:drift/drift.dart';

import 'package:ourtunes/core/database/app_database.dart';
import 'package:ourtunes/core/utils/sort_key.dart';
import 'package:ourtunes/features/library/domain/device_audio_file.dart';

/// What the database already knows about a track, used to detect changes.
class ScanSnapshot {
  const ScanSnapshot({
    required this.mediaStoreId,
    required this.dateModified,
    required this.sizeBytes,
    required this.isMissing,
  });

  final int mediaStoreId;
  final int dateModified;
  final int sizeBytes;
  final bool isMissing;
}

/// Database operations used by the scanner. Edits in track_edits are never
/// touched here, so a rescan cannot overwrite what the user changed.
class LibraryScanStore {
  LibraryScanStore(this._db);

  final AppDatabase _db;

  Future<List<String>> includedFolders() async {
    final rows = await _db.select(_db.libraryFolders).get();
    return rows.map((row) => row.relativePath).toList();
  }

  Future<Map<int, ScanSnapshot>> snapshot() async {
    final rows = await _db.select(_db.tracks).get();
    return {
      for (final row in rows)
        row.mediaStoreId: ScanSnapshot(
          mediaStoreId: row.mediaStoreId,
          dateModified: row.dateModified,
          sizeBytes: row.sizeBytes,
          isMissing: row.isMissing,
        ),
    };
  }

  /// Applies one scan in a single transaction.
  Future<void> apply({
    required List<DeviceAudioFile> toAdd,
    required List<DeviceAudioFile> toUpdate,
    required Set<int> restoreIds,
    required Set<int> missingIds,
  }) {
    return _db.transaction(() async {
      await _db.batch((batch) {
        batch.insertAll(_db.tracks, toAdd.map(_insertCompanion).toList());
        for (final file in toUpdate) {
          batch.update(
            _db.tracks,
            _updateCompanion(file),
            where: (t) => t.mediaStoreId.equals(file.mediaStoreId),
          );
        }
      });

      for (final ids in _chunks(restoreIds.toList(), 500)) {
        await (_db.update(_db.tracks)
              ..where((t) => t.mediaStoreId.isIn(ids)))
            .write(
          TracksCompanion(
            isMissing: const Value(false),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
      for (final ids in _chunks(missingIds.toList(), 500)) {
        await (_db.update(_db.tracks)
              ..where((t) => t.mediaStoreId.isIn(ids)))
            .write(
          TracksCompanion(
            isMissing: const Value(true),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });
  }

  TracksCompanion _insertCompanion(DeviceAudioFile file) {
    return TracksCompanion.insert(
      mediaStoreId: file.mediaStoreId,
      uri: file.uri,
      sizeBytes: file.sizeBytes,
      dateModified: file.dateModified,
      relativePath: Value(file.relativePath),
      durationMs: Value(file.durationMs),
      title: Value(file.title),
      artist: Value(file.artist),
      album: Value(file.album),
      albumArtist: Value(file.albumArtist),
      year: Value(file.year),
      trackNo: Value(file.trackNo),
      titleSort: Value(buildSortKey(file.title)),
      artistSort: Value(buildSortKey(file.artist)),
      albumSort: Value(buildSortKey(file.album)),
    );
  }

  TracksCompanion _updateCompanion(DeviceAudioFile file) {
    return TracksCompanion(
      uri: Value(file.uri),
      sizeBytes: Value(file.sizeBytes),
      dateModified: Value(file.dateModified),
      relativePath: Value(file.relativePath),
      durationMs: Value(file.durationMs),
      title: Value(file.title),
      artist: Value(file.artist),
      album: Value(file.album),
      albumArtist: Value(file.albumArtist),
      year: Value(file.year),
      trackNo: Value(file.trackNo),
      titleSort: Value(buildSortKey(file.title)),
      artistSort: Value(buildSortKey(file.artist)),
      albumSort: Value(buildSortKey(file.album)),
      isMissing: const Value(false),
      updatedAt: Value(DateTime.now()),
    );
  }

  Iterable<List<int>> _chunks(List<int> items, int size) sync* {
    for (var start = 0; start < items.length; start += size) {
      final end = start + size > items.length ? items.length : start + size;
      yield items.sublist(start, end);
    }
  }
}
