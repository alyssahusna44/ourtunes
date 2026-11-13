# OurTunes

A private Android music app for two people. It plays music already on the phone, lets two users share playlists, and will later search and download from legal sources such as the Internet Archive.

OurTunes is a work in progress and the name is a placeholder.

## Status

Phase 1 in progress (local library and playback), can check full plan in the next section.

## Planned features

| Phase | Scope |
|---|---|
| 1 | Local library scan, playback with notification and lock screen controls, local playlists, sorting by artist, album and year, tag editing |
| 2 | Sign-in, invite code, shared playlists between two users |
| 3 | Internet Archive search, preview and download, with license shown per track |
| 4 | MusicBrainz tag suggestions, album art, polish, release APK |

## Design and architecture

The design decisions, folder layout, data model and sync rules are documented in [doc/ARCHITECTURE.md](doc/ARCHITECTURE.md). Please read it before contributing code or changing the structure.

## Principles

- **Legal sources only.** The app plays the user's own files and downloads only from sources that permit it.
- **Metadata, not audio, in the cloud.** Shared playlists contain track information only. Audio files stay on each device.
- **Offline-first.** The local database is the source of truth.
- **Privacy by default.** Only the minimum personal data is collected.

## Tech stack

- Flutter (Dart), Android only
- Riverpod, go_router and drift (planned)
- just_audio for playback (planned)
- Supabase for accounts and shared playlists in phase 2 (planned)

## Getting started

Prerequisites:

- Flutter stable (developed with 3.47.9) with the Android toolchain set up
- JDK 21 (newer JDK versions may not work with the project's Gradle version)
- An Android phone with USB debugging enabled, or an emulator

Run the app:

```
flutter pub get
flutter run
```

Run the checks:

```
flutter analyze
flutter test
```

## Versioning

Releases follow semantic versioning and are tagged in Git (for example `v0.0.1`).

## License

No license has been chosen yet, so all rights are reserved for now.