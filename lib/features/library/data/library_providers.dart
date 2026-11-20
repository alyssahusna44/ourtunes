import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ourtunes/core/database/database_provider.dart';
import 'package:ourtunes/features/library/data/library_local_source.dart';
import 'package:ourtunes/features/library/data/library_repository_impl.dart';
import 'package:ourtunes/features/library/data/library_scan_store.dart';
import 'package:ourtunes/features/library/data/library_scanner.dart';
import 'package:ourtunes/features/library/data/method_channel_media_store_source.dart';
import 'package:ourtunes/features/library/data/permission_handler_audio_permission_service.dart';
import 'package:ourtunes/features/library/domain/audio_permission_service.dart';
import 'package:ourtunes/features/library/domain/library_repository.dart';
import 'package:ourtunes/features/library/domain/media_store_source.dart';

final mediaStoreSourceProvider = Provider<MediaStoreSource>(
  (ref) => MethodChannelMediaStoreSource(),
);

final audioPermissionServiceProvider = Provider<AudioPermissionService>(
  (ref) => PermissionHandlerAudioPermissionService(
    ref.watch(mediaStoreSourceProvider),
  ),
);

/// The one provider screens should use.
final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return LibraryRepositoryImpl(
    localSource: LibraryLocalSource(database),
    scanner: LibraryScanner(
      source: ref.watch(mediaStoreSourceProvider),
      store: LibraryScanStore(database),
    ),
    permissions: ref.watch(audioPermissionServiceProvider),
  );
});
