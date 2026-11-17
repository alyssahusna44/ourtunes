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
