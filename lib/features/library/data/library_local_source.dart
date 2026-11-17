import 'package:drift/drift.dart';

import 'package:ourtunes/core/database/app_database.dart';
import 'package:ourtunes/core/utils/sort_key.dart';
import 'package:ourtunes/features/library/domain/library_track.dart';

/// Reads and writes the local library in the drift database.
class LibraryLocalSource {
  LibraryLocalSource(this._db);

  final AppDatabase _db;

  /// Adds a track and builds its sort keys. Returns the new track id.
  Future<int> addTrack({
    required int mediaStoreId,
    required String uri,
    required int sizeBytes,
    required int dateModified,
    String? relativePath,
    int? durationMs,
    String? title,
    String? artist,
    String? album,
    String? albumArtist,
    int? year,
    int? trackNo,
  }) {
    return _db.into(_db.tracks).insert(
          TracksCompanion.insert(
            mediaStoreId: mediaStoreId,
            uri: uri,
            sizeBytes: sizeBytes,
            dateModified: dateModified,
            relativePath: Value(relativePath),
            durationMs: Value(durationMs),
            title: Value(title),
            artist: Value(artist),
            album: Value(album),
            albumArtist: Value(albumArtist),
            year: Value(year),
            trackNo: Value(trackNo),
            titleSort: Value(buildSortKey(title)),
            artistSort: Value(buildSortKey(artist)),
            albumSort: Value(buildSortKey(album)),
          ),
        );
  }

  /// Saves the user's edits for a track and rebuilds the edit sort keys.
  /// A null value means "no override" for that field.
  Future<void> saveEdit(
    int trackId, {
    String? title,
    String? artist,
    String? album,
    int? year,
  }) {
    return _db.into(_db.trackEdits).insertOnConflictUpdate(
          TrackEditsCompanion(
            trackId: Value(trackId),
            title: Value(title),
            artist: Value(artist),
            album: Value(album),
            year: Value(year),
            titleSort: Value(buildSortKey(title)),
            artistSort: Value(buildSortKey(artist)),
            albumSort: Value(buildSortKey(album)),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  /// Marks a track as missing (file no longer found) without deleting it.
  Future<void> markMissing(int trackId, {bool missing = true}) async {
    await (_db.update(_db.tracks)..where((t) => t.id.equals(trackId)))
        .write(TracksCompanion(isMissing: Value(missing)));
  }

  /// Watches the library sorted by [sortBy]. Edits are applied, missing
  /// values sort last, and text sorts case-insensitively ignoring a leading
  /// "the", "a" or "an".
  Stream<List<LibraryTrack>> watchTracks(TrackSortField sortBy) {
    final t = _db.tracks;
    final e = _db.trackEdits;

    final query = _db.select(t).join([
      leftOuterJoin(e, e.trackId.equalsExp(t.id)),
    ]);
    query.where(t.isMissing.equals(false));
    query.orderBy(_orderBy(sortBy, t, e));

    return query.watch().map(
          (rows) => rows
              .map(
                (row) => _toLibraryTrack(row.readTable(t), row.readTableOrNull(e)),
              )
              .toList(),
        );
  }

  List<OrderingTerm> _orderBy(
    TrackSortField sortBy,
    $TracksTable t,
    $TrackEditsTable e,
  ) {
    final title = coalesce([e.titleSort, t.titleSort]);
    final artist = coalesce([e.artistSort, t.artistSort]);
    final album = coalesce([e.albumSort, t.albumSort]);
    final year = coalesce([e.year, t.year]);

    OrderingTerm nullsLast(Expression expression) => OrderingTerm(
          expression: expression,
          mode: OrderingMode.asc,
          nulls: NullsOrder.last,
        );

    switch (sortBy) {
      case TrackSortField.title:
        return [nullsLast(title), nullsLast(artist)];
      case TrackSortField.artist:
        return [
          nullsLast(artist),
          nullsLast(album),
          nullsLast(t.trackNo),
          nullsLast(title),
        ];
      case TrackSortField.album:
        return [
          nullsLast(album),
          nullsLast(t.trackNo),
          nullsLast(title),
        ];
      case TrackSortField.year:
        return [
          nullsLast(year),
          nullsLast(artist),
          nullsLast(album),
          nullsLast(t.trackNo),
          nullsLast(title),
        ];
    }
  }

  LibraryTrack _toLibraryTrack(Track track, TrackEdit? edit) {
    return LibraryTrack(
      id: track.id,
      uri: track.uri,
      title: edit?.title ?? track.title,
      artist: edit?.artist ?? track.artist,
      album: edit?.album ?? track.album,
      albumArtist: track.albumArtist,
      year: edit?.year ?? track.year,
      trackNo: track.trackNo,
      durationMs: track.durationMs,
      isEdited: edit != null,
    );
  }
}
