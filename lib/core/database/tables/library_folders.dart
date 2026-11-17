import 'package:drift/drift.dart';

/// Folders (relative paths in MediaStore) included in the library scan.
class LibraryFolders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get relativePath => text().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
