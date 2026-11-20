import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/core/database/app_database.dart';
import 'package:ourtunes/features/library/data/library_local_source.dart';
import 'package:ourtunes/features/library/data/library_scan_store.dart';
import 'package:ourtunes/features/library/data/library_scanner.dart';
import 'package:ourtunes/features/library/domain/device_audio_file.dart';
import 'package:ourtunes/features/library/domain/exclusion_rules.dart';
import 'package:ourtunes/features/library/domain/library_track.dart';
import 'package:ourtunes/features/library/domain/media_store_source.dart';

class FakeMediaStoreSource implements MediaStoreSource {
  List<DeviceAudioFile> files = [];
  int queryCount = 0;
  bool denyPermission = false;

  /// When set, the next query waits for this completer.
  Completer<void>? gate;

  @override
  Future<int> sdkInt() async => 34;

  @override
  Stream<void> get changes => const Stream<void>.empty();

  @override
  Future<List<DeviceAudioFile>> queryAudio() async {
    queryCount++;
    if (denyPermission) throw const MediaStorePermissionException();
    final currentGate = gate;
    if (currentGate != null) {
      gate = null;
      await currentGate.future;
    }
    return List.of(files);
  }
}

DeviceAudioFile song(
  int id, {
  String? title,
  String? artist,
  String? album,
  int dateModified = 100,
  int sizeBytes = 1000,
  int? durationMs = 180000,
  String? path = 'Music/',
}) {
  return DeviceAudioFile(
    mediaStoreId: id,
    uri: 'content://media/external/audio/media/$id',
    sizeBytes: sizeBytes,
    dateModified: dateModified,
    relativePath: path,
    durationMs: durationMs,
    title: title ?? 'Song $id',
    artist: artist,
    album: album,
  );
}

void main() {
  late AppDatabase db;
  late FakeMediaStoreSource source;
  late LibraryScanner scanner;
  late LibraryLocalSource library;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    source = FakeMediaStoreSource();
    scanner = LibraryScanner(source: source, store: LibraryScanStore(db));
    library = LibraryLocalSource(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<List<LibraryTrack>> visibleTracks() {
    return library.watchTracks(TrackSortField.title).first;
  }

  test('adds music and counts what the rules exclude', () async {
    source.files = [
      song(1),
      song(2),
      const DeviceAudioFile(
        mediaStoreId: 3,
        uri: 'content://media/external/audio/media/3',
        sizeBytes: 10,
        dateModified: 1,
        relativePath: 'Ringtones/',
        isRingtone: true,
      ),
      song(4, durationMs: 5000),
      song(5, path: 'Recordings/Voice/'),
      const DeviceAudioFile(
        mediaStoreId: 6,
        uri: 'content://media/external/audio/media/6',
        sizeBytes: 10,
        dateModified: 1,
        isMusic: false,
      ),
    ];

    final result = await scanner.scan();

    expect(result.filesOnDevice, 6);
    expect(result.added, 2);
    expect(result.excluded[ExclusionReason.systemSound], 1);
    expect(result.excluded[ExclusionReason.tooShort], 1);
    expect(result.excluded[ExclusionReason.excludedFolder], 1);
    expect(result.excluded[ExclusionReason.notMusic], 1);
    expect(await db.select(db.tracks).get(), hasLength(2));
  });

  test('a second scan with no changes changes nothing', () async {
    source.files = [song(1), song(2)];
    await scanner.scan();

    final result = await scanner.scan();

    expect(result.added, 0);
    expect(result.updated, 0);
    expect(result.markedMissing, 0);
    expect(result.restored, 0);
  });

  test('changed files are updated and the user edits are kept', () async {
    source.files = [song(1, title: 'Old Title', artist: 'Original')];
    await scanner.scan();
    final track = await db.select(db.tracks).getSingle();
    await library.saveEdit(track.id, artist: 'My Artist');

    source.files = [
      song(1, title: 'New Title', artist: 'Original', dateModified: 200),
    ];
    final result = await scanner.scan();

    expect(result.updated, 1);
    final tracks = await visibleTracks();
    expect(tracks.single.title, 'New Title');
    expect(tracks.single.artist, 'My Artist');
    expect(tracks.single.isEdited, isTrue);
  });

  test('vanished files are marked missing and restored when they return',
      () async {
    source.files = [song(1), song(2)];
    await scanner.scan();

    source.files = [song(1)];
    final gone = await scanner.scan();
    expect(gone.markedMissing, 1);
    expect(await visibleTracks(), hasLength(1));
    expect(await db.select(db.tracks).get(), hasLength(2));

    source.files = [song(1), song(2)];
    final back = await scanner.scan();
    expect(back.restored, 1);
    expect(back.added, 0);
    expect(await visibleTracks(), hasLength(2));
  });

  test('only scans the included folders when some are set', () async {
    await db
        .into(db.libraryFolders)
        .insert(LibraryFoldersCompanion.insert(relativePath: 'Music'));
    source.files = [
      song(1, path: 'Music/Rock/'),
      song(2, path: 'MusicOld/'),
      song(3, path: 'Download/'),
    ];

    final result = await scanner.scan();

    expect(result.added, 1);
    expect(result.outsideFolders, 2);
  });

  test('a permission error leaves the library untouched', () async {
    source.files = [song(1)];
    await scanner.scan();

    source.denyPermission = true;
    await expectLater(
      scanner.scan(),
      throwsA(isA<MediaStorePermissionException>()),
    );

    expect(await visibleTracks(), hasLength(1));
  });

  test('overlapping scan requests run one after another', () async {
    source.files = [song(1)];
    source.gate = Completer<void>();
    final gate = source.gate!;

    final first = scanner.scan();
    final second = scanner.scan();
    expect(source.queryCount, 1);

    gate.complete();
    await first;
    await second;

    expect(source.queryCount, 2);
  });
}
