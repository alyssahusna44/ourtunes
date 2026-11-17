/// Fields the library can be sorted by.
enum TrackSortField { title, artist, album, year }

/// A track as the UI sees it: user edits are already applied.
/// Missing values are null; the UI shows "Unknown Artist" and similar.
class LibraryTrack {
  const LibraryTrack({
    required this.id,
    required this.uri,
    this.title,
    this.artist,
    this.album,
    this.albumArtist,
    this.year,
    this.trackNo,
    this.durationMs,
    this.isEdited = false,
  });

  final int id;
  final String uri;
  final String? title;
  final String? artist;
  final String? album;
  final String? albumArtist;
  final int? year;
  final int? trackNo;
  final int? durationMs;
  final bool isEdited;
}
