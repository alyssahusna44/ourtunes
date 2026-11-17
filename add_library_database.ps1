<#
  add_library_database.ps1
  Adds the local library database to OurTunes:
    - drift tables: tracks, track_edits, library_folders (schema version 1)
    - sort-key helper (case-insensitive, ignores leading "the", "a", "an")
    - a LibraryTrack model and a local data source with a sorted query
    - in-memory database tests
  Then adds the packages and runs code generation.

  Run from the project root (the folder that contains pubspec.yaml):
    powershell -ExecutionPolicy Bypass -File .\add_library_database.ps1

  Existing files are skipped so nothing you edited is overwritten.
#>

$ErrorActionPreference = 'Stop'
$root = (Get-Location).Path

if (-not (Test-Path (Join-Path $root 'pubspec.yaml'))) {
    Write-Host 'pubspec.yaml not found. Run this script from the project root.' -ForegroundColor Red
    exit 1
}

# ---------- helper ----------

function Write-DartFile {
    param(
        [string]$RelativePath,
        [string]$Content
    )
    $full = Join-Path $root $RelativePath
    $dir = Split-Path $full -Parent
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    if (Test-Path $full) {
        Write-Host "skip   $RelativePath (already exists)"
        return
    }
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($full, ($Content + "`n"), $utf8NoBom)
    Write-Host "write  $RelativePath"
}

# ---------- core/utils ----------

Write-DartFile 'lib/core/utils/sort_key.dart' @'
/// Builds a normalised key used to sort text the way people expect.
///
/// The key is lower case, has collapsed whitespace and ignores a leading
/// English article ("the", "a", "an"), so "The Beatles" sorts under B.
/// Returns null for null or blank input, so missing values can be sorted last.
String? buildSortKey(String? value) {
  if (value == null) return null;

  var key = value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  if (key.isEmpty) return null;

  for (final article in const ['the ', 'an ', 'a ']) {
    if (key.startsWith(article) && key.length > article.length) {
      key = key.substring(article.length);
      break;
    }
  }
  return key;
}
'@

# ---------- core/database: tables ----------

Write-DartFile 'lib/core/database/tables/tracks.dart' @'
import 'package:drift/drift.dart';

/// Music files found on the device. Tracks are local to each phone and are
/// never synced, so they use a plain auto-increment integer id.
class Tracks extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mediaStoreId => integer().unique()();
  TextColumn get uri => text()();
  TextColumn get relativePath => text().nullable()();
  IntColumn get sizeBytes => integer()();

  /// Seconds since the epoch, as reported by MediaStore.
  IntColumn get dateModified => integer()();
  IntColumn get durationMs => integer().nullable()();

  // Original tags (null when missing).
  TextColumn get title => text().nullable()();
  TextColumn get artist => text().nullable()();
  TextColumn get album => text().nullable()();
  TextColumn get albumArtist => text().nullable()();
  IntColumn get year => integer().nullable()();
  IntColumn get trackNo => integer().nullable()();

  // Sort keys built from the original tags with buildSortKey.
  TextColumn get titleSort => text().nullable()();
  TextColumn get artistSort => text().nullable()();
  TextColumn get albumSort => text().nullable()();

  TextColumn get musicbrainzRecordingId => text().nullable()();

  /// 'local' or 'internet_archive'.
  TextColumn get source => text().withDefault(const Constant('local'))();
  TextColumn get license => text().nullable()();

  BoolColumn get isMissing => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
'@

Write-DartFile 'lib/core/database/tables/track_edits.dart' @'
import 'package:drift/drift.dart';

import 'package:ourtunes/core/database/tables/tracks.dart';

/// User edits that override the original tags. A null column means
/// "no override". Rescans never touch this table.
class TrackEdits extends Table {
  IntColumn get trackId =>
      integer().references(Tracks, #id, onDelete: KeyAction.cascade)();

  TextColumn get title => text().nullable()();
  TextColumn get artist => text().nullable()();
  TextColumn get album => text().nullable()();
  IntColumn get year => integer().nullable()();

  // Sort keys built from the edited values with buildSortKey.
  TextColumn get titleSort => text().nullable()();
  TextColumn get artistSort => text().nullable()();
  TextColumn get albumSort => text().nullable()();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {trackId};
}
'@

Write-DartFile 'lib/core/database/tables/library_folders.dart' @'
import 'package:drift/drift.dart';

/// Folders (relative paths in MediaStore) included in the library scan.
class LibraryFolders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get relativePath => text().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
'@

# ---------- core/database: database and provider ----------

Write-DartFile 'lib/core/database/app_database.dart' @'
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:ourtunes/core/database/tables/library_folders.dart';
import 'package:ourtunes/core/database/tables/track_edits.dart';
import 'package:ourtunes/core/database/tables/tracks.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Tracks, TrackEdits, LibraryFolders])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'ourtunes'));

  /// Used by tests, for example with NativeDatabase.memory().
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // From the first schema change onwards, add one step per version.
          // Example for version 2:
          //   if (from < 2) {
          //     await m.addColumn(tracks, tracks.someNewColumn);
          //   }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
'@

Write-DartFile 'lib/core/database/database_provider.dart' @'
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ourtunes/core/database/app_database.dart';

/// The single app-wide database, closed when the provider scope is disposed.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});
'@

# ---------- features/library ----------

Write-DartFile 'lib/features/library/domain/library_track.dart' @'
/// Fields the library can be sorted by.
enum TrackSortField { title, artist, album, year }

/// A track as the UI sees it: user edits are already applied.
/// Missing values are null; the UI shows "Unknown Artist" and similar.
class LibraryTrack {
  const LibraryTrack({
    required this.id,
    required this.uri,
    this.title,
    this.artist,
    this.album,
    this.albumArtist,
    this.year,
    this.trackNo,
    this.durationMs,
    this.isEdited = false,
  });

  final int id;
  final String uri;
  final String? title;
  final String? artist;
  final String? album;
  final String? albumArtist;
  final int? year;
  final int? trackNo;
  final int? durationMs;
  final bool isEdited;
}
'@

Write-DartFile 'lib/features/library/data/library_local_source.dart' @'
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
'@

# ---------- tests ----------

Write-DartFile 'test/core/utils/sort_key_test.dart' @'
import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/core/utils/sort_key.dart';

void main() {
  group('buildSortKey', () {
    test('returns null for null, empty and blank input', () {
      expect(buildSortKey(null), isNull);
      expect(buildSortKey(''), isNull);
      expect(buildSortKey('   '), isNull);
    });

    test('is case-insensitive and trims whitespace', () {
      expect(buildSortKey('  ADELE  '), 'adele');
      expect(buildSortKey('Daft   Punk'), 'daft punk');
    });

    test('ignores a leading article', () {
      expect(buildSortKey('The Beatles'), 'beatles');
      expect(buildSortKey('A Tribe Called Quest'), 'tribe called quest');
      expect(buildSortKey('An Example'), 'example');
    });

    test('keeps articles that are not leading or are the whole value', () {
      expect(buildSortKey('Hotel California'), 'hotel california');
      expect(buildSortKey('Another One'), 'another one');
      expect(buildSortKey('The'), 'the');
      expect(buildSortKey('A'), 'a');
    });
  });
}
'@

Write-DartFile 'test/features/library/library_local_source_test.dart' @'
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
'@

# ---------- packages and code generation ----------

Write-Host ''
Write-Host 'Adding packages...'
flutter pub add drift drift_flutter
if ($LASTEXITCODE -ne 0) {
    Write-Host 'flutter pub add (drift, drift_flutter) failed.' -ForegroundColor Red
    exit 1
}
flutter pub add --dev drift_dev build_runner
if ($LASTEXITCODE -ne 0) {
    Write-Host 'flutter pub add --dev (drift_dev, build_runner) failed.' -ForegroundColor Red
    exit 1
}

Write-Host ''
Write-Host 'Generating drift code (this can take a minute)...'
dart run build_runner build --delete-conflicting-outputs
if ($LASTEXITCODE -ne 0) {
    Write-Host 'Code generation failed. Copy the error and share it.' -ForegroundColor Red
    exit 1
}

Write-Host ''
Write-Host 'Done. Next steps:' -ForegroundColor Green
Write-Host '  flutter analyze'
Write-Host '  flutter test'