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
