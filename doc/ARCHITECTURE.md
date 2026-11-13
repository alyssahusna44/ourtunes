# OurTunes Architecture

Status: draft v0.1 (OurTunes)

OurTunes is a private Android music app for two people. It plays music already on the phone, lets the two users share playlists, and later adds search and download from legal sources such as the Internet Archive.

## 1. Principles

1. **Legal sources only.** The app plays the user's own files and downloads only from sources that permit it. It never downloads from YouTube or similar services.
2. **Metadata, never audio, in the cloud.** Shared playlists contain track metadata only. Audio files stay on each device.
3. **Offline-first.** The local database is the source of truth. The cloud only syncs playlists.
4. **Privacy by default.** Collect the minimum personal data (email and display name) and support account deletion.
5. **Keep it simple.** Add structure only when it solves a real problem.

## 2. Phases

| Phase | Scope | Version |
|---|---|---|
| 1 | Local library (MediaStore scan), playback, local playlists, sorting by artist, album, year, tag editing | v0.1.x |
| 2 | Sign-in, invite code, shared playlists, track matching | v0.2.x |
| 3 | Internet Archive search, preview, download, license display | v0.3.x |
| 4 | MusicBrainz tag suggestions, album art, polish, release APK | v0.4.x |

## 3. Tech stack

| Concern | Choice |
|---|---|
| Framework | Flutter (Dart) |
| State management and DI | Riverpod |
| Navigation | go_router |
| Local database | drift (SQLite) |
| Playback | just_audio with just_audio_background (move to audio_service if custom controls are needed) |
| Permissions | permission_handler |
| Backend (phase 2) | Supabase: Postgres, Auth, row-level security |
| CI | GitHub Actions: `flutter analyze` and `flutter test` |

Package choices should be rechecked on pub.dev for maintenance status before they are added.

## 4. Folder layout

```
lib/
  main.dart
  app/                  # router, theme, app-wide providers
  core/                 # database, error types, utilities, shared widgets
  features/
    library/
      data/             # MediaStore source, DB access, repository implementation
      domain/           # Track, Album, Artist models, repository interface
      presentation/     # screens, widgets, state
    player/
    playlists/
    tags/               # tag editing, MusicBrainz lookup
    auth/               # phase 2
    sync/               # phase 2
    sources/
      internet_archive/ # phase 3
```

## 5. Layer rules

- Presentation never calls the database, MediaStore or network directly. It talks to repository interfaces.
- Domain holds plain models and repository interfaces. It has no Flutter or platform imports.
- Data implements the interfaces. Local and remote data sources live here.
- A feature may use another feature only through its domain interfaces.
- Do not add use-case classes until logic is shared by more than one screen.

## 6. Data model (local SQLite)

All ids that may be synced are UUIDs generated on the device.

**tracks**
- id (uuid), media_store_id, uri, relative_path, size_bytes, date_modified, duration_ms
- title, artist, album, album_artist, year, track_no (original tags, nullable)
- musicbrainz_recording_id (nullable)
- source (`local` or `internet_archive`), license (nullable)
- is_missing, created_at, updated_at, deleted_at

**track_edits** (user overrides, one row per edited track)
- track_id, title, artist, album, year (all nullable)
- updated_at

The app displays `COALESCE(edit value, original value)`. Rescans never touch `track_edits`.

**library_folders** (included folders for the scan)
- id, relative_path, created_at

**playlists**
- id (uuid), name, created_at, updated_at, deleted_at
- owner_user_id (nullable until phase 2)

**playlist_entries**
- id (uuid), playlist_id, position (real number), added_at, updated_at, deleted_at
- local_track_id (nullable, resolved per device)
- title, artist, album, duration_ms, musicbrainz_recording_id (snapshot used for matching)

Display rule: store missing values as null and show "Unknown Artist" (or similar) in the UI only.

## 7. Library scan and rescan

- Source: Android MediaStore, filtered to the folders in `library_folders`.
- Permissions: `READ_MEDIA_AUDIO` on Android 13 and above, `READ_EXTERNAL_STORAGE` (maxSdkVersion 32) on Android 12 and below. No all-files access.
- Rescan: compare MediaStore id, size and date modified with the database. Add new files, update changed ones, mark missing ones with `is_missing` instead of deleting them.
- Storage Access Framework (SAF) is a possible later option behind the same repository interface.

## 8. Tag handling

1. Show original tags, with "Unknown Artist" and similar fallbacks for nulls.
2. Users can edit tags in the app. Edits are saved in `track_edits`, not written into the audio file.
3. MusicBrainz lookups (title, artist, duration) produce suggestions that the user accepts or rejects. Respect the rate limit of about one request per second, send a descriptive User-Agent, and cache results.
4. Album art can come from the Cover Art Archive.

## 9. Playback

- just_audio plays local content URIs.
- Background playback, notification and lock screen controls use just_audio_background, with a MediaItem (title, artist, art) attached to each track.
- Android needs a foreground service declaration, the foreground service and wake lock permissions, and the `POST_NOTIFICATIONS` runtime permission on Android 13 and above.

## 10. Sharing and sync (phase 2)

- Two users join a playlist through an invite code. Supabase row-level security limits each playlist to its members.
- The cloud stores playlists, members and entry metadata only. Audio is never uploaded.
- Each device matches shared entries against its own library: first by MusicBrainz id, then by normalised title, artist and album with duration within a small tolerance. Unmatched entries show as "not in your library".
- Sync uses `updated_at` and soft deletes (`deleted_at`). Entry order uses fractional positions so reordering does not rewrite every row.
- Secrets: only the public Supabase anon key may appear in the app. The service role key never goes in the repository.

## 11. Internet Archive (phase 3)

- Use the public search and metadata APIs, cache responses, and send a descriptive User-Agent.
- Store and display each item's license. Offer download only when the license permits it.

## 12. Repository practices

- Commits use `feat:`, `fix:`, `docs:`, `test:`, `chore:`.
- `main` always builds. Work happens on short feature branches merged by pull request.
- Releases use semantic version tags (v0.1.0, ...) with a `CHANGELOG.md` and the APK attached to each GitHub Release.
- No keys, `.env` files or signing keystores in the repository.
- The repository carries a `LICENSE` file, and dependency licenses are reviewed before release.

## 13. Decision log

| # | Decision | Reason |
|---|---|---|
| 1 | Flutter | One codebase, prior experience |
| 2 | Supabase | Postgres suits relational playlist data, built-in auth and row-level security |
| 3 | MediaStore for scanning (SAF later) | Fast and simple, no folder-picker complexity in phase 1 |
| 4 | Tag edits stored in the database | Avoids per-file write permission on modern Android and survives rescans |
| 5 | Shared playlists hold metadata only | Avoids distributing copyrighted audio |
| 6 | Legal sources only, starting with the Internet Archive | Matches the project's values and avoids terms-of-service violations |
| 7 | No Play Store release for now | Private APK for two users, store requirements postponed |
