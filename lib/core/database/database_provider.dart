import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ourtunes/core/database/app_database.dart';

/// The single app-wide database, closed when the provider scope is disposed.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});
