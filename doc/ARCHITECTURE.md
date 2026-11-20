# OurTunes Architecture

Status: draft v0.3 (placeholder app name: OurTunes)

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
| Local database | drift and drift_flutter (SQLite), with drift_dev and build_runner for code generation |
| Playback | just_audio with just_audio_background (move to audio_service if custom controls are needed) |
| Reading music from the phone | Own Kotlin MethodChannel bridge to Android MediaStore (`MediaStoreBridge.kt`) |
| Permissions | permission_handler (permission chosen by Android version) |
| Backend (phase 2) | Supabase: Postgres, Auth, row-level security |
| CI | GitHub Actions: `flutter analyze` and `flutter test` |

Package choices should be rechecked on pub.dev for maintenance status before they are added.

## 4. Folder layout

```
lib/
  main.dart
  app/                  # router, theme, app-wide providers
  core/                 # database (tables, migrations), error types, utilities (sort keys), shared widgets
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

Native Android code lives in `android/app/src/main/kotlin/<package>/`: `MainActivity.kt` registers `MediaStoreBridge.kt`.

## 5. Layer rules

- Presentation never calls the database, MediaStore or network directly. It talks to repository interfaces.
- Domain holds plain models and repository interfaces. It has no Flutter or platform imports.
- Data implements the interfaces. Local and remote data sources live here.
- A feature may use another feature only through its domain interfaces.
- Do not add use-case classes until logic is shared by more than one screen.

## 6. Data model (local SQLite)

Id rules:

- **tracks** and **library_folders** use local auto-increment integer ids. Tracks never sync, because each phone has its own files and shared playlists match tracks by metadata (see section 10).
- **playlists** and **playlist_entries** use UUIDs generated on the device, because they are synced.

**tracks**
- id (integer, auto-increment), media_store_id (unique), uri, relative_path, size_bytes, date_modified, duration_ms
- title, artist, album, album_artist, year, track_no (original tags, nullable)
- title_sort, artist_sort, album_sort (sort keys built from the original tags, nullable)
- musicbrainz_recording_id (nullable)
- source (`local` or `internet_archive`), license (nullable)
- is_missing, created_at, updated_at

There is no `deleted_at` on tracks. A file that disappears is marked `is_missing`, and tracks are never synced.

**track_edits** (user overrides, one row per edited track)
- track_id (primary key, references tracks, deleted with its track)
- title, artist, album, year (all nullable)
- title_sort, artist_sort, album_sort (sort keys built from the edited values)
- updated_at

The app displays the edited value when it exists and the original tag otherwise. Rescans never touch `track_edits`. A null edit column means "no override", so an edit cannot blank out a field.

**library_folders** (included folders for the scan)
- id (integer, auto-increment), relative_path (unique), created_at

**playlists** (next step)
- id (uuid), name, created_at, updated_at, deleted_at
- owner_user_id (nullable until phase 2)

**playlist_entries** (next step)
- id (uuid), playlist_id, position (real number), added_at, updated_at, deleted_at
- local_track_id (nullable integer, resolved per device)
- title, artist, album, duration_ms, musicbrainz_recording_id (snapshot used for matching)

Display rule: store missing values as null and show "Unknown Artist" (or similar) in the UI only.

### Sorting rules

- Sorting uses the sort-key columns, never the raw tags.
- A sort key is lower case, has whitespace collapsed, and ignores a leading "the", "a" or "an" ("The Beatles" sorts under B). A blank value has no key.
- The query sorts by `COALESCE(edit sort key, original sort key)`, with missing values last ("Unknown Artist" at the bottom).
- Whenever a tag or an edit is saved, its sort key is rebuilt with the shared `buildSortKey` function in `core/utils`.
- Tie-breakers for the artist view: artist, album, track number, title.

### Schema versions and migrations

- The schema starts at version 1.
- From the first change after that, every schema change bumps the version and adds a migration step, so an installed copy never loses its library.
- Generated drift files (`*.g.dart`) are committed so CI does not need a code generation step.

### Database tests

- Unit tests run against an in-memory drift database (`NativeDatabase.memory()`), so sorting, edits and rescan logic are tested on a laptop without a phone.
- The same tests run in GitHub Actions.

## 7. Library scan and rescan

### Reading the device (Kotlin bridge)

- A small Kotlin class, `MediaStoreBridge`, queries Android MediaStore over a MethodChannel and returns one record per audio file. It runs on a background thread.
- Why own code instead of a package: the popular MediaStore plugin has not had a release in about three years, forks have unclear maintenance, and a bridge gives full control over the columns, with no dependency risk.
- Each record has the MediaStore id, content URI, relative path, size, date modified, duration, tags (missing values and "<unknown>" become null) and MediaStore flags (music, ringtone, notification, alarm, podcast, audiobook, recording).
- Columns that do not exist on an older Android version are left out of the query.
- The Dart side sees only the `MediaStoreSource` interface, so tests use a fake and the bridge can be replaced (for example by a Storage Access Framework version) without touching the scanner.

### Permissions

- Android 13 (API 33) and above: `READ_MEDIA_AUDIO`.
- Android 12 and below: `READ_EXTERNAL_STORAGE` (declared with maxSdkVersion 32), because the audio permission does nothing there.
- `permission_handler` shows the prompt. The bridge reports the Android version so Dart picks the right permission.
- If the permission is missing, the bridge fails with `permission_denied` and the scan stops before changing anything, so a revoked permission can never make the library look empty.
- No all-files access.

### What is excluded by default

Decided in Dart (`ExclusionRules`), in this order, first match wins:

| Rule | Excludes |
|---|---|
| Ringtone, notification or alarm flag | System sounds |
| Podcast, audiobook or recording flag | Spoken word |
| Not flagged as music | Non-music audio |
| Shorter than 30 seconds | Voice notes, clips (a duration of null or 0 is treated as unknown and kept) |
| Folder name contains recording, recorder, voice note, voice memo, call record, whatsapp voice, ringtone, notification or alarm | Recordings and voice notes that are not flagged |

The 30-second limit and the folder list are settings of `ExclusionRules`, so they can later be edited from a settings screen. Each scan reports how many files each rule excluded.

### Included folders

`library_folders` holds folders to include. If it is empty, all device music is scanned (after exclusions). Folder names are compared with a trailing slash so "Music" does not match "MusicOld/".

### Scan and rescan

1. Query the device, then drop files outside the included folders and files the exclusion rules reject.
2. Compare with the database by MediaStore id: new files are added, files whose size or date modified changed are updated, and files that are no longer present (or no longer allowed by the rules) are marked `is_missing` instead of being deleted.
3. A missing file that comes back is restored.
4. All changes are applied in one database transaction. `track_edits` is never touched, so a rescan cannot overwrite the user's edits.
5. Only one scan runs at a time. A request during a scan queues exactly one more scan, so repeated calls are safe.

### When scans run

- On app start (once the permission is granted) and from a refresh button.
- Live change observer: not built yet. `MediaStoreSource.changes` is an empty stream today. The observer will be a `ContentObserver` in the bridge that sends "something changed" events over an EventChannel, with the Dart side waiting a few seconds after the last event before scanning. Only the bridge and one provider change.

### Known limits

- MediaStore only knows files Android has indexed, so a freshly copied file can take a moment to appear.
- The flags are Android's best guess, so a few files may be classified wrongly. The scan summary shows the counts so the rules can be tuned.
- The observer only works while the app is running.
- Storage Access Framework scanning stays a later option behind the same interface.

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
| 8 | Integer ids for tracks, UUIDs for playlists and entries | Tracks never sync, so integers are simpler and faster; only synced data needs UUIDs |
| 9 | Sort keys built from the start (ignore case and leading articles, missing values last) | Correct ordering from day one; adding it later would need a migration and a backfill |
| 10 | Schema version 1 with real migrations from the first change | An installed copy keeps its library |
| 11 | In-memory database tests | Fast, no phone needed, runs in CI |
| 12 | Own Kotlin MediaStore bridge instead of a plugin | The popular plugin is unmaintained, the bridge is small and fully controlled |
| 13 | Exclusion rules decided in Dart (30 second minimum, flags, folder names) | Easy to change and test, and a settings screen can edit them later |
| 14 | Scan on app start plus refresh button, one scan at a time | Simple and safe; repeated calls are queued |
| 15 | Live observer prepared (`changes` stream) but built later | Verify the basic scan on a phone first |
| 16 | Permission picked by Android version | The audio permission does nothing on Android 12 and below |
| 17 | Pin permission_handler to 12.x for now | Version 13 needs Android SDK 37, which failed to build with the SDK naming on this setup; revisit later |