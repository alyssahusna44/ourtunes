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
