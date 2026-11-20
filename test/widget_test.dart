import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/app/app.dart';
import 'package:ourtunes/features/library/data/library_providers.dart';
import 'package:ourtunes/features/library/domain/audio_permission_service.dart';
import 'package:ourtunes/features/library/domain/library_repository.dart';
import 'package:ourtunes/features/library/domain/library_track.dart';
import 'package:ourtunes/features/library/domain/scan_result.dart';

/// Keeps the widget test away from the database and Android plugins.
class _FakeLibraryRepository implements LibraryRepository {
  @override
  Stream<List<LibraryTrack>> watchTracks(TrackSortField sortBy) {
    return Stream.value(const <LibraryTrack>[]);
  }

  @override
  Future<ScanResult> rescan() async => ScanResult.empty;

  @override
  Future<AudioPermissionStatus> permissionStatus() async {
    return AudioPermissionStatus.denied;
  }

  @override
  Future<AudioPermissionStatus> requestPermission() async {
    return AudioPermissionStatus.denied;
  }

  @override
  Future<void> openPermissionSettings() async {}
}

void main() {
  testWidgets('shows the bottom navigation with four tabs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          libraryRepositoryProvider.overrideWithValue(_FakeLibraryRepository()),
        ],
        child: const OurTunesApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));
  });
}
