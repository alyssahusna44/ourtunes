import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/core/database/app_database.dart';
import 'package:ourtunes/features/library/data/library_local_source.dart';
import 'package:ourtunes/features/library/domain/library_track.dart';

void main() {
  late AppDatabase db;
  late LibraryLocalSource source;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    source = LibraryLocalSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> add(
    int id, {
    String? title,
    String? artist,
    String? album,
    int? year,
  }) {
    return source.addTrack(
      mediaStoreId: id,
      uri: 'content://media/external/audio/media/$id',
      sizeBytes: 1000,
      dateModified: 1,
      title: title,
      artist: artist,
      album: album,
      year: year,
    );
  }

  Future<List<LibraryTrack>> sorted(TrackSortField field) {
    return source.watchTracks(field).first;
  }

  test('schema starts at version 1', () {
    expect(db.schemaVersion, 1);
  });

  test('sorts by artist ignoring case and leading "The", missing last', () async {
    await add(1, title: 'z', artist: 'Zebra');
    await add(2, title: 'b', artist: 'the beatles');
    await add(3, title: 'a', artist: 'Adele');
    await add(4, title: 'n');

    final result = await sorted(TrackSortField.artist);

    expect(result.map((t) => t.artist), ['Adele', 'the beatles', 'Zebra', null]);
  });

  test('sorts by year with missing years last', () async {
    await add(1, title: 'a', year: 2010);
    await add(2, title: 'b');
    await add(3, title: 'c', year: 1999);

    final result = await sorted(TrackSortField.year);

    expect(result.map((t) => t.year), [1999, 2010, null]);
  });

  test('sorts by album with tie-breaker on title', () async {
    await add(1, title: 'second', album: 'Same Album');
    await add(2, title: 'first', album: 'Same Album');
    await add(3, title: 'other', album: 'A Different Album');

    final result = await sorted(TrackSortField.album);

    expect(result.map((t) => t.title), ['other', 'first', 'second']);
  });

  test('edits override the original tags and the sort order', () async {
    final id = await add(1, title: 'song', artist: 'Zed');
    await add(2, title: 'other', artist: 'Mike');

    await source.saveEdit(id, artist: 'Abba');
    final result = await sorted(TrackSortField.artist);

    expect(result.map((t) => t.artist), ['Abba', 'Mike']);
    expect(result.first.isEdited, isTrue);
    expect(result.last.isEdited, isFalse);
  });

  test('a null edit field keeps the original value', () async {
    final id = await add(1, title: 'original title', artist: 'Someone');

    await source.saveEdit(id, artist: 'Other');
    final result = await sorted(TrackSortField.title);

    expect(result.single.title, 'original title');
    expect(result.single.artist, 'Other');
  });

  test('missing tracks are hidden from the library', () async {
    final id = await add(1, title: 'gone', artist: 'A');
    await add(2, title: 'here', artist: 'B');

    await source.markMissing(id);
    final result = await sorted(TrackSortField.artist);

    expect(result.map((t) => t.title), ['here']);
  });

  test('deleting a track removes its edit (foreign key cascade)', () async {
    final id = await add(1, title: 'x', artist: 'A');
    await source.saveEdit(id, artist: 'B');

    await (db.delete(db.tracks)..where((t) => t.id.equals(id))).go();

    final edits = await db.select(db.trackEdits).get();
    expect(edits, isEmpty);
  });

  test('inserting a duplicate MediaStore id is rejected', () async {
    await add(1, title: 'one');

    expect(() => add(1, title: 'again'), throwsA(anything));
  });
}
