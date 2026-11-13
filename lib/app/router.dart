import 'package:go_router/go_router.dart';

import 'package:ourtunes/app/app_shell.dart';
import 'package:ourtunes/features/library/presentation/library_screen.dart';
import 'package:ourtunes/features/playlists/presentation/playlists_screen.dart';
import 'package:ourtunes/features/sources/internet_archive/presentation/downloads_screen.dart';
import 'package:ourtunes/features/sources/internet_archive/presentation/search_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/library',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/library',
              builder: (context, state) => const LibraryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/playlists',
              builder: (context, state) => const PlaylistsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/downloads',
              builder: (context, state) => const DownloadsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
