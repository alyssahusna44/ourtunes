<#
  create_structure.ps1
  Creates the OurTunes folder structure from doc/ARCHITECTURE.md with
  placeholder Dart files, adds flutter_riverpod and go_router, and replaces
  the default counter app with a bottom-navigation shell.

  Run from the project root (the folder that contains pubspec.yaml):
    powershell -ExecutionPolicy Bypass -File .\create_structure.ps1

  Existing files are skipped, except lib/main.dart and
  test/widget_test.dart, which are replaced on purpose.
#>

$ErrorActionPreference = 'Stop'
$root = (Get-Location).Path

if (-not (Test-Path (Join-Path $root 'pubspec.yaml'))) {
    Write-Host 'pubspec.yaml not found. Run this script from the project root.' -ForegroundColor Red
    exit 1
}

# ---------- helpers ----------

function Add-Keep {
    param([string]$RelativeDir)
    $dir = Join-Path $root $RelativeDir
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    $keep = Join-Path $dir '.gitkeep'
    if (-not (Test-Path $keep)) {
        New-Item -ItemType File -Path $keep -Force | Out-Null
    }
    Write-Host "folder $RelativeDir"
}

function Write-DartFile {
    param(
        [string]$RelativePath,
        [string]$Content,
        [switch]$Overwrite
    )
    $full = Join-Path $root $RelativePath
    $dir = Split-Path $full -Parent
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    if ((Test-Path $full) -and (-not $Overwrite)) {
        Write-Host "skip   $RelativePath (already exists)"
        return
    }
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($full, ($Content + "`n"), $utf8NoBom)
    Write-Host "write  $RelativePath"
}

# ---------- empty folders (kept in Git with .gitkeep) ----------

$emptyFolders = @(
    'lib/core/database',
    'lib/core/errors',
    'lib/core/utils',
    'lib/features/library/data',
    'lib/features/library/domain',
    'lib/features/player/data',
    'lib/features/player/domain',
    'lib/features/player/presentation',
    'lib/features/playlists/data',
    'lib/features/playlists/domain',
    'lib/features/tags/data',
    'lib/features/tags/domain',
    'lib/features/tags/presentation',
    'lib/features/auth/data',
    'lib/features/auth/domain',
    'lib/features/auth/presentation',
    'lib/features/sync/data',
    'lib/features/sync/domain',
    'lib/features/sources/internet_archive/data',
    'lib/features/sources/internet_archive/domain'
)
foreach ($folder in $emptyFolders) { Add-Keep $folder }

# ---------- lib/main.dart ----------

Write-DartFile -Overwrite 'lib/main.dart' @'
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ourtunes/app/app.dart';

void main() {
  runApp(const ProviderScope(child: OurTunesApp()));
}
'@

# ---------- lib/app ----------

Write-DartFile 'lib/app/app.dart' @'
import 'package:flutter/material.dart';

import 'package:ourtunes/app/router.dart';
import 'package:ourtunes/app/theme.dart';

class OurTunesApp extends StatelessWidget {
  const OurTunesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'OurTunes',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
'@

Write-DartFile 'lib/app/theme.dart' @'
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const Color _seed = Color(0xFF6750A4);

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _seed),
      );

  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.dark,
        ),
      );
}
'@

Write-DartFile 'lib/app/router.dart' @'
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
'@

Write-DartFile 'lib/app/app_shell.dart' @'
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hosts the bottom navigation bar. A mini player will later sit above it.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.library_music_outlined),
            selectedIcon: Icon(Icons.library_music),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.queue_music_outlined),
            selectedIcon: Icon(Icons.queue_music),
            label: 'Playlists',
          ),
          NavigationDestination(
            icon: Icon(Icons.download_outlined),
            selectedIcon: Icon(Icons.download),
            label: 'Downloads',
          ),
        ],
      ),
    );
  }
}
'@

# ---------- lib/core ----------

Write-DartFile 'lib/core/widgets/placeholder_screen.dart' @'
import 'package:flutter/material.dart';

/// Temporary screen body used until a feature is built.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  final String title;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 64),
              const SizedBox(height: 16),
              Text(
                message,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
'@

# ---------- feature screens (placeholders) ----------

Write-DartFile 'lib/features/library/presentation/library_screen.dart' @'
import 'package:flutter/material.dart';

import 'package:ourtunes/core/widgets/placeholder_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Library',
      icon: Icons.library_music,
      message: 'Your music will appear here.',
    );
  }
}
'@

Write-DartFile 'lib/features/playlists/presentation/playlists_screen.dart' @'
import 'package:flutter/material.dart';

import 'package:ourtunes/core/widgets/placeholder_screen.dart';

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Playlists',
      icon: Icons.queue_music,
      message: 'Your playlists will appear here.',
    );
  }
}
'@

Write-DartFile 'lib/features/sources/internet_archive/presentation/search_screen.dart' @'
import 'package:flutter/material.dart';

import 'package:ourtunes/core/widgets/placeholder_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Search',
      icon: Icons.search,
      message: 'Search for legally downloadable music (coming in phase 3).',
    );
  }
}
'@

Write-DartFile 'lib/features/sources/internet_archive/presentation/downloads_screen.dart' @'
import 'package:flutter/material.dart';

import 'package:ourtunes/core/widgets/placeholder_screen.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Downloads',
      icon: Icons.download,
      message: 'Your downloads will appear here (coming in phase 3).',
    );
  }
}
'@

# ---------- test ----------

Write-DartFile -Overwrite 'test/widget_test.dart' @'
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/app/app.dart';

void main() {
  testWidgets('shows the bottom navigation with four tabs', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: OurTunesApp()));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));
  });
}
'@

# ---------- packages ----------

Write-Host ''
Write-Host 'Adding packages...'
flutter pub add flutter_riverpod go_router
if ($LASTEXITCODE -ne 0) {
    Write-Host 'flutter pub add failed. Check your internet connection and run it again.' -ForegroundColor Red
    exit 1
}

Write-Host ''
Write-Host 'Done. Next steps:' -ForegroundColor Green
Write-Host '  flutter analyze'
Write-Host '  flutter test'
Write-Host '  flutter run'
