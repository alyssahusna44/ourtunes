// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TracksTable extends Tracks with TableInfo<$TracksTable, Track> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TracksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mediaStoreIdMeta = const VerificationMeta(
    'mediaStoreId',
  );
  @override
  late final GeneratedColumn<int> mediaStoreId = GeneratedColumn<int>(
    'media_store_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _uriMeta = const VerificationMeta('uri');
  @override
  late final GeneratedColumn<String> uri = GeneratedColumn<String>(
    'uri',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateModifiedMeta = const VerificationMeta(
    'dateModified',
  );
  @override
  late final GeneratedColumn<int> dateModified = GeneratedColumn<int>(
    'date_modified',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
    'album',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumArtistMeta = const VerificationMeta(
    'albumArtist',
  );
  @override
  late final GeneratedColumn<String> albumArtist = GeneratedColumn<String>(
    'album_artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackNoMeta = const VerificationMeta(
    'trackNo',
  );
  @override
  late final GeneratedColumn<int> trackNo = GeneratedColumn<int>(
    'track_no',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleSortMeta = const VerificationMeta(
    'titleSort',
  );
  @override
  late final GeneratedColumn<String> titleSort = GeneratedColumn<String>(
    'title_sort',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistSortMeta = const VerificationMeta(
    'artistSort',
  );
  @override
  late final GeneratedColumn<String> artistSort = GeneratedColumn<String>(
    'artist_sort',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumSortMeta = const VerificationMeta(
    'albumSort',
  );
  @override
  late final GeneratedColumn<String> albumSort = GeneratedColumn<String>(
    'album_sort',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _musicbrainzRecordingIdMeta =
      const VerificationMeta('musicbrainzRecordingId');
  @override
  late final GeneratedColumn<String> musicbrainzRecordingId =
      GeneratedColumn<String>(
        'musicbrainz_recording_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _licenseMeta = const VerificationMeta(
    'license',
  );
  @override
  late final GeneratedColumn<String> license = GeneratedColumn<String>(
    'license',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isMissingMeta = const VerificationMeta(
    'isMissing',
  );
  @override
  late final GeneratedColumn<bool> isMissing = GeneratedColumn<bool>(
    'is_missing',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_missing" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mediaStoreId,
    uri,
    relativePath,
    sizeBytes,
    dateModified,
    durationMs,
    title,
    artist,
    album,
    albumArtist,
    year,
    trackNo,
    titleSort,
    artistSort,
    albumSort,
    musicbrainzRecordingId,
    source,
    license,
    isMissing,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tracks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Track> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('media_store_id')) {
      context.handle(
        _mediaStoreIdMeta,
        mediaStoreId.isAcceptableOrUnknown(
          data['media_store_id']!,
          _mediaStoreIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediaStoreIdMeta);
    }
    if (data.containsKey('uri')) {
      context.handle(
        _uriMeta,
        uri.isAcceptableOrUnknown(data['uri']!, _uriMeta),
      );
    } else if (isInserting) {
      context.missing(_uriMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('date_modified')) {
      context.handle(
        _dateModifiedMeta,
        dateModified.isAcceptableOrUnknown(
          data['date_modified']!,
          _dateModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateModifiedMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    }
    if (data.containsKey('album')) {
      context.handle(
        _albumMeta,
        album.isAcceptableOrUnknown(data['album']!, _albumMeta),
      );
    }
    if (data.containsKey('album_artist')) {
      context.handle(
        _albumArtistMeta,
        albumArtist.isAcceptableOrUnknown(
          data['album_artist']!,
          _albumArtistMeta,
        ),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('track_no')) {
      context.handle(
        _trackNoMeta,
        trackNo.isAcceptableOrUnknown(data['track_no']!, _trackNoMeta),
      );
    }
    if (data.containsKey('title_sort')) {
      context.handle(
        _titleSortMeta,
        titleSort.isAcceptableOrUnknown(data['title_sort']!, _titleSortMeta),
      );
    }
    if (data.containsKey('artist_sort')) {
      context.handle(
        _artistSortMeta,
        artistSort.isAcceptableOrUnknown(data['artist_sort']!, _artistSortMeta),
      );
    }
    if (data.containsKey('album_sort')) {
      context.handle(
        _albumSortMeta,
        albumSort.isAcceptableOrUnknown(data['album_sort']!, _albumSortMeta),
      );
    }
    if (data.containsKey('musicbrainz_recording_id')) {
      context.handle(
        _musicbrainzRecordingIdMeta,
        musicbrainzRecordingId.isAcceptableOrUnknown(
          data['musicbrainz_recording_id']!,
          _musicbrainzRecordingIdMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('license')) {
      context.handle(
        _licenseMeta,
        license.isAcceptableOrUnknown(data['license']!, _licenseMeta),
      );
    }
    if (data.containsKey('is_missing')) {
      context.handle(
        _isMissingMeta,
        isMissing.isAcceptableOrUnknown(data['is_missing']!, _isMissingMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Track map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Track(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mediaStoreId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}media_store_id'],
      )!,
      uri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uri'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      ),
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      dateModified: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_modified'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      ),
      album: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album'],
      ),
      albumArtist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album_artist'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
      trackNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_no'],
      ),
      titleSort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_sort'],
      ),
      artistSort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist_sort'],
      ),
      albumSort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album_sort'],
      ),
      musicbrainzRecordingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}musicbrainz_recording_id'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      license: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license'],
      ),
      isMissing: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_missing'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TracksTable createAlias(String alias) {
    return $TracksTable(attachedDatabase, alias);
  }
}

class Track extends DataClass implements Insertable<Track> {
  final int id;
  final int mediaStoreId;
  final String uri;
  final String? relativePath;
  final int sizeBytes;

  /// Seconds since the epoch, as reported by MediaStore.
  final int dateModified;
  final int? durationMs;
  final String? title;
  final String? artist;
  final String? album;
  final String? albumArtist;
  final int? year;
  final int? trackNo;
  final String? titleSort;
  final String? artistSort;
  final String? albumSort;
  final String? musicbrainzRecordingId;

  /// 'local' or 'internet_archive'.
  final String source;
  final String? license;
  final bool isMissing;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Track({
    required this.id,
    required this.mediaStoreId,
    required this.uri,
    this.relativePath,
    required this.sizeBytes,
    required this.dateModified,
    this.durationMs,
    this.title,
    this.artist,
    this.album,
    this.albumArtist,
    this.year,
    this.trackNo,
    this.titleSort,
    this.artistSort,
    this.albumSort,
    this.musicbrainzRecordingId,
    required this.source,
    this.license,
    required this.isMissing,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['media_store_id'] = Variable<int>(mediaStoreId);
    map['uri'] = Variable<String>(uri);
    if (!nullToAbsent || relativePath != null) {
      map['relative_path'] = Variable<String>(relativePath);
    }
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['date_modified'] = Variable<int>(dateModified);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || album != null) {
      map['album'] = Variable<String>(album);
    }
    if (!nullToAbsent || albumArtist != null) {
      map['album_artist'] = Variable<String>(albumArtist);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || trackNo != null) {
      map['track_no'] = Variable<int>(trackNo);
    }
    if (!nullToAbsent || titleSort != null) {
      map['title_sort'] = Variable<String>(titleSort);
    }
    if (!nullToAbsent || artistSort != null) {
      map['artist_sort'] = Variable<String>(artistSort);
    }
    if (!nullToAbsent || albumSort != null) {
      map['album_sort'] = Variable<String>(albumSort);
    }
    if (!nullToAbsent || musicbrainzRecordingId != null) {
      map['musicbrainz_recording_id'] = Variable<String>(
        musicbrainzRecordingId,
      );
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || license != null) {
      map['license'] = Variable<String>(license);
    }
    map['is_missing'] = Variable<bool>(isMissing);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TracksCompanion toCompanion(bool nullToAbsent) {
    return TracksCompanion(
      id: Value(id),
      mediaStoreId: Value(mediaStoreId),
      uri: Value(uri),
      relativePath: relativePath == null && nullToAbsent
          ? const Value.absent()
          : Value(relativePath),
      sizeBytes: Value(sizeBytes),
      dateModified: Value(dateModified),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      artist: artist == null && nullToAbsent
          ? const Value.absent()
          : Value(artist),
      album: album == null && nullToAbsent
          ? const Value.absent()
          : Value(album),
      albumArtist: albumArtist == null && nullToAbsent
          ? const Value.absent()
          : Value(albumArtist),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      trackNo: trackNo == null && nullToAbsent
          ? const Value.absent()
          : Value(trackNo),
      titleSort: titleSort == null && nullToAbsent
          ? const Value.absent()
          : Value(titleSort),
      artistSort: artistSort == null && nullToAbsent
          ? const Value.absent()
          : Value(artistSort),
      albumSort: albumSort == null && nullToAbsent
          ? const Value.absent()
          : Value(albumSort),
      musicbrainzRecordingId: musicbrainzRecordingId == null && nullToAbsent
          ? const Value.absent()
          : Value(musicbrainzRecordingId),
      source: Value(source),
      license: license == null && nullToAbsent
          ? const Value.absent()
          : Value(license),
      isMissing: Value(isMissing),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Track.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Track(
      id: serializer.fromJson<int>(json['id']),
      mediaStoreId: serializer.fromJson<int>(json['mediaStoreId']),
      uri: serializer.fromJson<String>(json['uri']),
      relativePath: serializer.fromJson<String?>(json['relativePath']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      dateModified: serializer.fromJson<int>(json['dateModified']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      title: serializer.fromJson<String?>(json['title']),
      artist: serializer.fromJson<String?>(json['artist']),
      album: serializer.fromJson<String?>(json['album']),
      albumArtist: serializer.fromJson<String?>(json['albumArtist']),
      year: serializer.fromJson<int?>(json['year']),
      trackNo: serializer.fromJson<int?>(json['trackNo']),
      titleSort: serializer.fromJson<String?>(json['titleSort']),
      artistSort: serializer.fromJson<String?>(json['artistSort']),
      albumSort: serializer.fromJson<String?>(json['albumSort']),
      musicbrainzRecordingId: serializer.fromJson<String?>(
        json['musicbrainzRecordingId'],
      ),
      source: serializer.fromJson<String>(json['source']),
      license: serializer.fromJson<String?>(json['license']),
      isMissing: serializer.fromJson<bool>(json['isMissing']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mediaStoreId': serializer.toJson<int>(mediaStoreId),
      'uri': serializer.toJson<String>(uri),
      'relativePath': serializer.toJson<String?>(relativePath),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'dateModified': serializer.toJson<int>(dateModified),
      'durationMs': serializer.toJson<int?>(durationMs),
      'title': serializer.toJson<String?>(title),
      'artist': serializer.toJson<String?>(artist),
      'album': serializer.toJson<String?>(album),
      'albumArtist': serializer.toJson<String?>(albumArtist),
      'year': serializer.toJson<int?>(year),
      'trackNo': serializer.toJson<int?>(trackNo),
      'titleSort': serializer.toJson<String?>(titleSort),
      'artistSort': serializer.toJson<String?>(artistSort),
      'albumSort': serializer.toJson<String?>(albumSort),
      'musicbrainzRecordingId': serializer.toJson<String?>(
        musicbrainzRecordingId,
      ),
      'source': serializer.toJson<String>(source),
      'license': serializer.toJson<String?>(license),
      'isMissing': serializer.toJson<bool>(isMissing),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Track copyWith({
    int? id,
    int? mediaStoreId,
    String? uri,
    Value<String?> relativePath = const Value.absent(),
    int? sizeBytes,
    int? dateModified,
    Value<int?> durationMs = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<String?> artist = const Value.absent(),
    Value<String?> album = const Value.absent(),
    Value<String?> albumArtist = const Value.absent(),
    Value<int?> year = const Value.absent(),
    Value<int?> trackNo = const Value.absent(),
    Value<String?> titleSort = const Value.absent(),
    Value<String?> artistSort = const Value.absent(),
    Value<String?> albumSort = const Value.absent(),
    Value<String?> musicbrainzRecordingId = const Value.absent(),
    String? source,
    Value<String?> license = const Value.absent(),
    bool? isMissing,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Track(
    id: id ?? this.id,
    mediaStoreId: mediaStoreId ?? this.mediaStoreId,
    uri: uri ?? this.uri,
    relativePath: relativePath.present ? relativePath.value : this.relativePath,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    dateModified: dateModified ?? this.dateModified,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    title: title.present ? title.value : this.title,
    artist: artist.present ? artist.value : this.artist,
    album: album.present ? album.value : this.album,
    albumArtist: albumArtist.present ? albumArtist.value : this.albumArtist,
    year: year.present ? year.value : this.year,
    trackNo: trackNo.present ? trackNo.value : this.trackNo,
    titleSort: titleSort.present ? titleSort.value : this.titleSort,
    artistSort: artistSort.present ? artistSort.value : this.artistSort,
    albumSort: albumSort.present ? albumSort.value : this.albumSort,
    musicbrainzRecordingId: musicbrainzRecordingId.present
        ? musicbrainzRecordingId.value
        : this.musicbrainzRecordingId,
    source: source ?? this.source,
    license: license.present ? license.value : this.license,
    isMissing: isMissing ?? this.isMissing,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Track copyWithCompanion(TracksCompanion data) {
    return Track(
      id: data.id.present ? data.id.value : this.id,
      mediaStoreId: data.mediaStoreId.present
          ? data.mediaStoreId.value
          : this.mediaStoreId,
      uri: data.uri.present ? data.uri.value : this.uri,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      dateModified: data.dateModified.present
          ? data.dateModified.value
          : this.dateModified,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      album: data.album.present ? data.album.value : this.album,
      albumArtist: data.albumArtist.present
          ? data.albumArtist.value
          : this.albumArtist,
      year: data.year.present ? data.year.value : this.year,
      trackNo: data.trackNo.present ? data.trackNo.value : this.trackNo,
      titleSort: data.titleSort.present ? data.titleSort.value : this.titleSort,
      artistSort: data.artistSort.present
          ? data.artistSort.value
          : this.artistSort,
      albumSort: data.albumSort.present ? data.albumSort.value : this.albumSort,
      musicbrainzRecordingId: data.musicbrainzRecordingId.present
          ? data.musicbrainzRecordingId.value
          : this.musicbrainzRecordingId,
      source: data.source.present ? data.source.value : this.source,
      license: data.license.present ? data.license.value : this.license,
      isMissing: data.isMissing.present ? data.isMissing.value : this.isMissing,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Track(')
          ..write('id: $id, ')
          ..write('mediaStoreId: $mediaStoreId, ')
          ..write('uri: $uri, ')
          ..write('relativePath: $relativePath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('dateModified: $dateModified, ')
          ..write('durationMs: $durationMs, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('albumArtist: $albumArtist, ')
          ..write('year: $year, ')
          ..write('trackNo: $trackNo, ')
          ..write('titleSort: $titleSort, ')
          ..write('artistSort: $artistSort, ')
          ..write('albumSort: $albumSort, ')
          ..write('musicbrainzRecordingId: $musicbrainzRecordingId, ')
          ..write('source: $source, ')
          ..write('license: $license, ')
          ..write('isMissing: $isMissing, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    mediaStoreId,
    uri,
    relativePath,
    sizeBytes,
    dateModified,
    durationMs,
    title,
    artist,
    album,
    albumArtist,
    year,
    trackNo,
    titleSort,
    artistSort,
    albumSort,
    musicbrainzRecordingId,
    source,
    license,
    isMissing,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Track &&
          other.id == this.id &&
          other.mediaStoreId == this.mediaStoreId &&
          other.uri == this.uri &&
          other.relativePath == this.relativePath &&
          other.sizeBytes == this.sizeBytes &&
          other.dateModified == this.dateModified &&
          other.durationMs == this.durationMs &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.albumArtist == this.albumArtist &&
          other.year == this.year &&
          other.trackNo == this.trackNo &&
          other.titleSort == this.titleSort &&
          other.artistSort == this.artistSort &&
          other.albumSort == this.albumSort &&
          other.musicbrainzRecordingId == this.musicbrainzRecordingId &&
          other.source == this.source &&
          other.license == this.license &&
          other.isMissing == this.isMissing &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TracksCompanion extends UpdateCompanion<Track> {
  final Value<int> id;
  final Value<int> mediaStoreId;
  final Value<String> uri;
  final Value<String?> relativePath;
  final Value<int> sizeBytes;
  final Value<int> dateModified;
  final Value<int?> durationMs;
  final Value<String?> title;
  final Value<String?> artist;
  final Value<String?> album;
  final Value<String?> albumArtist;
  final Value<int?> year;
  final Value<int?> trackNo;
  final Value<String?> titleSort;
  final Value<String?> artistSort;
  final Value<String?> albumSort;
  final Value<String?> musicbrainzRecordingId;
  final Value<String> source;
  final Value<String?> license;
  final Value<bool> isMissing;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TracksCompanion({
    this.id = const Value.absent(),
    this.mediaStoreId = const Value.absent(),
    this.uri = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.dateModified = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.albumArtist = const Value.absent(),
    this.year = const Value.absent(),
    this.trackNo = const Value.absent(),
    this.titleSort = const Value.absent(),
    this.artistSort = const Value.absent(),
    this.albumSort = const Value.absent(),
    this.musicbrainzRecordingId = const Value.absent(),
    this.source = const Value.absent(),
    this.license = const Value.absent(),
    this.isMissing = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TracksCompanion.insert({
    this.id = const Value.absent(),
    required int mediaStoreId,
    required String uri,
    this.relativePath = const Value.absent(),
    required int sizeBytes,
    required int dateModified,
    this.durationMs = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.albumArtist = const Value.absent(),
    this.year = const Value.absent(),
    this.trackNo = const Value.absent(),
    this.titleSort = const Value.absent(),
    this.artistSort = const Value.absent(),
    this.albumSort = const Value.absent(),
    this.musicbrainzRecordingId = const Value.absent(),
    this.source = const Value.absent(),
    this.license = const Value.absent(),
    this.isMissing = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : mediaStoreId = Value(mediaStoreId),
       uri = Value(uri),
       sizeBytes = Value(sizeBytes),
       dateModified = Value(dateModified);
  static Insertable<Track> custom({
    Expression<int>? id,
    Expression<int>? mediaStoreId,
    Expression<String>? uri,
    Expression<String>? relativePath,
    Expression<int>? sizeBytes,
    Expression<int>? dateModified,
    Expression<int>? durationMs,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<String>? albumArtist,
    Expression<int>? year,
    Expression<int>? trackNo,
    Expression<String>? titleSort,
    Expression<String>? artistSort,
    Expression<String>? albumSort,
    Expression<String>? musicbrainzRecordingId,
    Expression<String>? source,
    Expression<String>? license,
    Expression<bool>? isMissing,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mediaStoreId != null) 'media_store_id': mediaStoreId,
      if (uri != null) 'uri': uri,
      if (relativePath != null) 'relative_path': relativePath,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (dateModified != null) 'date_modified': dateModified,
      if (durationMs != null) 'duration_ms': durationMs,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (albumArtist != null) 'album_artist': albumArtist,
      if (year != null) 'year': year,
      if (trackNo != null) 'track_no': trackNo,
      if (titleSort != null) 'title_sort': titleSort,
      if (artistSort != null) 'artist_sort': artistSort,
      if (albumSort != null) 'album_sort': albumSort,
      if (musicbrainzRecordingId != null)
        'musicbrainz_recording_id': musicbrainzRecordingId,
      if (source != null) 'source': source,
      if (license != null) 'license': license,
      if (isMissing != null) 'is_missing': isMissing,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TracksCompanion copyWith({
    Value<int>? id,
    Value<int>? mediaStoreId,
    Value<String>? uri,
    Value<String?>? relativePath,
    Value<int>? sizeBytes,
    Value<int>? dateModified,
    Value<int?>? durationMs,
    Value<String?>? title,
    Value<String?>? artist,
    Value<String?>? album,
    Value<String?>? albumArtist,
    Value<int?>? year,
    Value<int?>? trackNo,
    Value<String?>? titleSort,
    Value<String?>? artistSort,
    Value<String?>? albumSort,
    Value<String?>? musicbrainzRecordingId,
    Value<String>? source,
    Value<String?>? license,
    Value<bool>? isMissing,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TracksCompanion(
      id: id ?? this.id,
      mediaStoreId: mediaStoreId ?? this.mediaStoreId,
      uri: uri ?? this.uri,
      relativePath: relativePath ?? this.relativePath,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      dateModified: dateModified ?? this.dateModified,
      durationMs: durationMs ?? this.durationMs,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArtist: albumArtist ?? this.albumArtist,
      year: year ?? this.year,
      trackNo: trackNo ?? this.trackNo,
      titleSort: titleSort ?? this.titleSort,
      artistSort: artistSort ?? this.artistSort,
      albumSort: albumSort ?? this.albumSort,
      musicbrainzRecordingId:
          musicbrainzRecordingId ?? this.musicbrainzRecordingId,
      source: source ?? this.source,
      license: license ?? this.license,
      isMissing: isMissing ?? this.isMissing,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mediaStoreId.present) {
      map['media_store_id'] = Variable<int>(mediaStoreId.value);
    }
    if (uri.present) {
      map['uri'] = Variable<String>(uri.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (dateModified.present) {
      map['date_modified'] = Variable<int>(dateModified.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (albumArtist.present) {
      map['album_artist'] = Variable<String>(albumArtist.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (trackNo.present) {
      map['track_no'] = Variable<int>(trackNo.value);
    }
    if (titleSort.present) {
      map['title_sort'] = Variable<String>(titleSort.value);
    }
    if (artistSort.present) {
      map['artist_sort'] = Variable<String>(artistSort.value);
    }
    if (albumSort.present) {
      map['album_sort'] = Variable<String>(albumSort.value);
    }
    if (musicbrainzRecordingId.present) {
      map['musicbrainz_recording_id'] = Variable<String>(
        musicbrainzRecordingId.value,
      );
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (license.present) {
      map['license'] = Variable<String>(license.value);
    }
    if (isMissing.present) {
      map['is_missing'] = Variable<bool>(isMissing.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TracksCompanion(')
          ..write('id: $id, ')
          ..write('mediaStoreId: $mediaStoreId, ')
          ..write('uri: $uri, ')
          ..write('relativePath: $relativePath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('dateModified: $dateModified, ')
          ..write('durationMs: $durationMs, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('albumArtist: $albumArtist, ')
          ..write('year: $year, ')
          ..write('trackNo: $trackNo, ')
          ..write('titleSort: $titleSort, ')
          ..write('artistSort: $artistSort, ')
          ..write('albumSort: $albumSort, ')
          ..write('musicbrainzRecordingId: $musicbrainzRecordingId, ')
          ..write('source: $source, ')
          ..write('license: $license, ')
          ..write('isMissing: $isMissing, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TrackEditsTable extends TrackEdits
    with TableInfo<$TrackEditsTable, TrackEdit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackEditsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tracks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
    'album',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleSortMeta = const VerificationMeta(
    'titleSort',
  );
  @override
  late final GeneratedColumn<String> titleSort = GeneratedColumn<String>(
    'title_sort',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistSortMeta = const VerificationMeta(
    'artistSort',
  );
  @override
  late final GeneratedColumn<String> artistSort = GeneratedColumn<String>(
    'artist_sort',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _albumSortMeta = const VerificationMeta(
    'albumSort',
  );
  @override
  late final GeneratedColumn<String> albumSort = GeneratedColumn<String>(
    'album_sort',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    trackId,
    title,
    artist,
    album,
    year,
    titleSort,
    artistSort,
    albumSort,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_edits';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackEdit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    }
    if (data.containsKey('album')) {
      context.handle(
        _albumMeta,
        album.isAcceptableOrUnknown(data['album']!, _albumMeta),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('title_sort')) {
      context.handle(
        _titleSortMeta,
        titleSort.isAcceptableOrUnknown(data['title_sort']!, _titleSortMeta),
      );
    }
    if (data.containsKey('artist_sort')) {
      context.handle(
        _artistSortMeta,
        artistSort.isAcceptableOrUnknown(data['artist_sort']!, _artistSortMeta),
      );
    }
    if (data.containsKey('album_sort')) {
      context.handle(
        _albumSortMeta,
        albumSort.isAcceptableOrUnknown(data['album_sort']!, _albumSortMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {trackId};
  @override
  TrackEdit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackEdit(
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      ),
      album: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      ),
      titleSort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_sort'],
      ),
      artistSort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist_sort'],
      ),
      albumSort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}album_sort'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TrackEditsTable createAlias(String alias) {
    return $TrackEditsTable(attachedDatabase, alias);
  }
}

class TrackEdit extends DataClass implements Insertable<TrackEdit> {
  final int trackId;
  final String? title;
  final String? artist;
  final String? album;
  final int? year;
  final String? titleSort;
  final String? artistSort;
  final String? albumSort;
  final DateTime updatedAt;
  const TrackEdit({
    required this.trackId,
    this.title,
    this.artist,
    this.album,
    this.year,
    this.titleSort,
    this.artistSort,
    this.albumSort,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['track_id'] = Variable<int>(trackId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || album != null) {
      map['album'] = Variable<String>(album);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || titleSort != null) {
      map['title_sort'] = Variable<String>(titleSort);
    }
    if (!nullToAbsent || artistSort != null) {
      map['artist_sort'] = Variable<String>(artistSort);
    }
    if (!nullToAbsent || albumSort != null) {
      map['album_sort'] = Variable<String>(albumSort);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TrackEditsCompanion toCompanion(bool nullToAbsent) {
    return TrackEditsCompanion(
      trackId: Value(trackId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      artist: artist == null && nullToAbsent
          ? const Value.absent()
          : Value(artist),
      album: album == null && nullToAbsent
          ? const Value.absent()
          : Value(album),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      titleSort: titleSort == null && nullToAbsent
          ? const Value.absent()
          : Value(titleSort),
      artistSort: artistSort == null && nullToAbsent
          ? const Value.absent()
          : Value(artistSort),
      albumSort: albumSort == null && nullToAbsent
          ? const Value.absent()
          : Value(albumSort),
      updatedAt: Value(updatedAt),
    );
  }

  factory TrackEdit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackEdit(
      trackId: serializer.fromJson<int>(json['trackId']),
      title: serializer.fromJson<String?>(json['title']),
      artist: serializer.fromJson<String?>(json['artist']),
      album: serializer.fromJson<String?>(json['album']),
      year: serializer.fromJson<int?>(json['year']),
      titleSort: serializer.fromJson<String?>(json['titleSort']),
      artistSort: serializer.fromJson<String?>(json['artistSort']),
      albumSort: serializer.fromJson<String?>(json['albumSort']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'trackId': serializer.toJson<int>(trackId),
      'title': serializer.toJson<String?>(title),
      'artist': serializer.toJson<String?>(artist),
      'album': serializer.toJson<String?>(album),
      'year': serializer.toJson<int?>(year),
      'titleSort': serializer.toJson<String?>(titleSort),
      'artistSort': serializer.toJson<String?>(artistSort),
      'albumSort': serializer.toJson<String?>(albumSort),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TrackEdit copyWith({
    int? trackId,
    Value<String?> title = const Value.absent(),
    Value<String?> artist = const Value.absent(),
    Value<String?> album = const Value.absent(),
    Value<int?> year = const Value.absent(),
    Value<String?> titleSort = const Value.absent(),
    Value<String?> artistSort = const Value.absent(),
    Value<String?> albumSort = const Value.absent(),
    DateTime? updatedAt,
  }) => TrackEdit(
    trackId: trackId ?? this.trackId,
    title: title.present ? title.value : this.title,
    artist: artist.present ? artist.value : this.artist,
    album: album.present ? album.value : this.album,
    year: year.present ? year.value : this.year,
    titleSort: titleSort.present ? titleSort.value : this.titleSort,
    artistSort: artistSort.present ? artistSort.value : this.artistSort,
    albumSort: albumSort.present ? albumSort.value : this.albumSort,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TrackEdit copyWithCompanion(TrackEditsCompanion data) {
    return TrackEdit(
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      album: data.album.present ? data.album.value : this.album,
      year: data.year.present ? data.year.value : this.year,
      titleSort: data.titleSort.present ? data.titleSort.value : this.titleSort,
      artistSort: data.artistSort.present
          ? data.artistSort.value
          : this.artistSort,
      albumSort: data.albumSort.present ? data.albumSort.value : this.albumSort,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackEdit(')
          ..write('trackId: $trackId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('year: $year, ')
          ..write('titleSort: $titleSort, ')
          ..write('artistSort: $artistSort, ')
          ..write('albumSort: $albumSort, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    trackId,
    title,
    artist,
    album,
    year,
    titleSort,
    artistSort,
    albumSort,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackEdit &&
          other.trackId == this.trackId &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.year == this.year &&
          other.titleSort == this.titleSort &&
          other.artistSort == this.artistSort &&
          other.albumSort == this.albumSort &&
          other.updatedAt == this.updatedAt);
}

class TrackEditsCompanion extends UpdateCompanion<TrackEdit> {
  final Value<int> trackId;
  final Value<String?> title;
  final Value<String?> artist;
  final Value<String?> album;
  final Value<int?> year;
  final Value<String?> titleSort;
  final Value<String?> artistSort;
  final Value<String?> albumSort;
  final Value<DateTime> updatedAt;
  const TrackEditsCompanion({
    this.trackId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.year = const Value.absent(),
    this.titleSort = const Value.absent(),
    this.artistSort = const Value.absent(),
    this.albumSort = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TrackEditsCompanion.insert({
    this.trackId = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.year = const Value.absent(),
    this.titleSort = const Value.absent(),
    this.artistSort = const Value.absent(),
    this.albumSort = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<TrackEdit> custom({
    Expression<int>? trackId,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<int>? year,
    Expression<String>? titleSort,
    Expression<String>? artistSort,
    Expression<String>? albumSort,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (trackId != null) 'track_id': trackId,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (year != null) 'year': year,
      if (titleSort != null) 'title_sort': titleSort,
      if (artistSort != null) 'artist_sort': artistSort,
      if (albumSort != null) 'album_sort': albumSort,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TrackEditsCompanion copyWith({
    Value<int>? trackId,
    Value<String?>? title,
    Value<String?>? artist,
    Value<String?>? album,
    Value<int?>? year,
    Value<String?>? titleSort,
    Value<String?>? artistSort,
    Value<String?>? albumSort,
    Value<DateTime>? updatedAt,
  }) {
    return TrackEditsCompanion(
      trackId: trackId ?? this.trackId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      year: year ?? this.year,
      titleSort: titleSort ?? this.titleSort,
      artistSort: artistSort ?? this.artistSort,
      albumSort: albumSort ?? this.albumSort,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (titleSort.present) {
      map['title_sort'] = Variable<String>(titleSort.value);
    }
    if (artistSort.present) {
      map['artist_sort'] = Variable<String>(artistSort.value);
    }
    if (albumSort.present) {
      map['album_sort'] = Variable<String>(albumSort.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackEditsCompanion(')
          ..write('trackId: $trackId, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('year: $year, ')
          ..write('titleSort: $titleSort, ')
          ..write('artistSort: $artistSort, ')
          ..write('albumSort: $albumSort, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LibraryFoldersTable extends LibraryFolders
    with TableInfo<$LibraryFoldersTable, LibraryFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibraryFoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, relativePath, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'library_folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<LibraryFolder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LibraryFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LibraryFolder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LibraryFoldersTable createAlias(String alias) {
    return $LibraryFoldersTable(attachedDatabase, alias);
  }
}

class LibraryFolder extends DataClass implements Insertable<LibraryFolder> {
  final int id;
  final String relativePath;
  final DateTime createdAt;
  const LibraryFolder({
    required this.id,
    required this.relativePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['relative_path'] = Variable<String>(relativePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LibraryFoldersCompanion toCompanion(bool nullToAbsent) {
    return LibraryFoldersCompanion(
      id: Value(id),
      relativePath: Value(relativePath),
      createdAt: Value(createdAt),
    );
  }

  factory LibraryFolder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LibraryFolder(
      id: serializer.fromJson<int>(json['id']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'relativePath': serializer.toJson<String>(relativePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LibraryFolder copyWith({
    int? id,
    String? relativePath,
    DateTime? createdAt,
  }) => LibraryFolder(
    id: id ?? this.id,
    relativePath: relativePath ?? this.relativePath,
    createdAt: createdAt ?? this.createdAt,
  );
  LibraryFolder copyWithCompanion(LibraryFoldersCompanion data) {
    return LibraryFolder(
      id: data.id.present ? data.id.value : this.id,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LibraryFolder(')
          ..write('id: $id, ')
          ..write('relativePath: $relativePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, relativePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryFolder &&
          other.id == this.id &&
          other.relativePath == this.relativePath &&
          other.createdAt == this.createdAt);
}

class LibraryFoldersCompanion extends UpdateCompanion<LibraryFolder> {
  final Value<int> id;
  final Value<String> relativePath;
  final Value<DateTime> createdAt;
  const LibraryFoldersCompanion({
    this.id = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LibraryFoldersCompanion.insert({
    this.id = const Value.absent(),
    required String relativePath,
    this.createdAt = const Value.absent(),
  }) : relativePath = Value(relativePath);
  static Insertable<LibraryFolder> custom({
    Expression<int>? id,
    Expression<String>? relativePath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (relativePath != null) 'relative_path': relativePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LibraryFoldersCompanion copyWith({
    Value<int>? id,
    Value<String>? relativePath,
    Value<DateTime>? createdAt,
  }) {
    return LibraryFoldersCompanion(
      id: id ?? this.id,
      relativePath: relativePath ?? this.relativePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryFoldersCompanion(')
          ..write('id: $id, ')
          ..write('relativePath: $relativePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TracksTable tracks = $TracksTable(this);
  late final $TrackEditsTable trackEdits = $TrackEditsTable(this);
  late final $LibraryFoldersTable libraryFolders = $LibraryFoldersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tracks,
    trackEdits,
    libraryFolders,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('track_edits', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TracksTableCreateCompanionBuilder =
    TracksCompanion Function({
      Value<int> id,
      required int mediaStoreId,
      required String uri,
      Value<String?> relativePath,
      required int sizeBytes,
      required int dateModified,
      Value<int?> durationMs,
      Value<String?> title,
      Value<String?> artist,
      Value<String?> album,
      Value<String?> albumArtist,
      Value<int?> year,
      Value<int?> trackNo,
      Value<String?> titleSort,
      Value<String?> artistSort,
      Value<String?> albumSort,
      Value<String?> musicbrainzRecordingId,
      Value<String> source,
      Value<String?> license,
      Value<bool> isMissing,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TracksTableUpdateCompanionBuilder =
    TracksCompanion Function({
      Value<int> id,
      Value<int> mediaStoreId,
      Value<String> uri,
      Value<String?> relativePath,
      Value<int> sizeBytes,
      Value<int> dateModified,
      Value<int?> durationMs,
      Value<String?> title,
      Value<String?> artist,
      Value<String?> album,
      Value<String?> albumArtist,
      Value<int?> year,
      Value<int?> trackNo,
      Value<String?> titleSort,
      Value<String?> artistSort,
      Value<String?> albumSort,
      Value<String?> musicbrainzRecordingId,
      Value<String> source,
      Value<String?> license,
      Value<bool> isMissing,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TracksTableReferences
    extends BaseReferences<_$AppDatabase, $TracksTable, Track> {
  $$TracksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrackEditsTable, List<TrackEdit>>
  _trackEditsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trackEdits,
    aliasName: 'tracks__id__track_edits__track_id',
  );

  $$TrackEditsTableProcessedTableManager get trackEditsRefs {
    final manager = $$TrackEditsTableTableManager(
      $_db,
      $_db.trackEdits,
    ).filter((f) => f.trackId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trackEditsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TracksTableFilterComposer
    extends Composer<_$AppDatabase, $TracksTable> {
  $$TracksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mediaStoreId => $composableBuilder(
    column: $table.mediaStoreId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateModified => $composableBuilder(
    column: $table.dateModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get albumArtist => $composableBuilder(
    column: $table.albumArtist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackNo => $composableBuilder(
    column: $table.trackNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleSort => $composableBuilder(
    column: $table.titleSort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artistSort => $composableBuilder(
    column: $table.artistSort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get albumSort => $composableBuilder(
    column: $table.albumSort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get musicbrainzRecordingId => $composableBuilder(
    column: $table.musicbrainzRecordingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get license => $composableBuilder(
    column: $table.license,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMissing => $composableBuilder(
    column: $table.isMissing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> trackEditsRefs(
    Expression<bool> Function($$TrackEditsTableFilterComposer f) f,
  ) {
    final $$TrackEditsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackEdits,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackEditsTableFilterComposer(
            $db: $db,
            $table: $db.trackEdits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TracksTableOrderingComposer
    extends Composer<_$AppDatabase, $TracksTable> {
  $$TracksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mediaStoreId => $composableBuilder(
    column: $table.mediaStoreId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateModified => $composableBuilder(
    column: $table.dateModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get albumArtist => $composableBuilder(
    column: $table.albumArtist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackNo => $composableBuilder(
    column: $table.trackNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleSort => $composableBuilder(
    column: $table.titleSort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artistSort => $composableBuilder(
    column: $table.artistSort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get albumSort => $composableBuilder(
    column: $table.albumSort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get musicbrainzRecordingId => $composableBuilder(
    column: $table.musicbrainzRecordingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get license => $composableBuilder(
    column: $table.license,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMissing => $composableBuilder(
    column: $table.isMissing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TracksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TracksTable> {
  $$TracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get mediaStoreId => $composableBuilder(
    column: $table.mediaStoreId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uri =>
      $composableBuilder(column: $table.uri, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<int> get dateModified => $composableBuilder(
    column: $table.dateModified,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get album =>
      $composableBuilder(column: $table.album, builder: (column) => column);

  GeneratedColumn<String> get albumArtist => $composableBuilder(
    column: $table.albumArtist,
    builder: (column) => column,
  );

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get trackNo =>
      $composableBuilder(column: $table.trackNo, builder: (column) => column);

  GeneratedColumn<String> get titleSort =>
      $composableBuilder(column: $table.titleSort, builder: (column) => column);

  GeneratedColumn<String> get artistSort => $composableBuilder(
    column: $table.artistSort,
    builder: (column) => column,
  );

  GeneratedColumn<String> get albumSort =>
      $composableBuilder(column: $table.albumSort, builder: (column) => column);

  GeneratedColumn<String> get musicbrainzRecordingId => $composableBuilder(
    column: $table.musicbrainzRecordingId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get license =>
      $composableBuilder(column: $table.license, builder: (column) => column);

  GeneratedColumn<bool> get isMissing =>
      $composableBuilder(column: $table.isMissing, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> trackEditsRefs<T extends Object>(
    Expression<T> Function($$TrackEditsTableAnnotationComposer a) f,
  ) {
    final $$TrackEditsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackEdits,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackEditsTableAnnotationComposer(
            $db: $db,
            $table: $db.trackEdits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TracksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TracksTable,
          Track,
          $$TracksTableFilterComposer,
          $$TracksTableOrderingComposer,
          $$TracksTableAnnotationComposer,
          $$TracksTableCreateCompanionBuilder,
          $$TracksTableUpdateCompanionBuilder,
          (Track, $$TracksTableReferences),
          Track,
          PrefetchHooks Function({bool trackEditsRefs})
        > {
  $$TracksTableTableManager(_$AppDatabase db, $TracksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TracksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mediaStoreId = const Value.absent(),
                Value<String> uri = const Value.absent(),
                Value<String?> relativePath = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<int> dateModified = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<String?> albumArtist = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<int?> trackNo = const Value.absent(),
                Value<String?> titleSort = const Value.absent(),
                Value<String?> artistSort = const Value.absent(),
                Value<String?> albumSort = const Value.absent(),
                Value<String?> musicbrainzRecordingId = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> license = const Value.absent(),
                Value<bool> isMissing = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TracksCompanion(
                id: id,
                mediaStoreId: mediaStoreId,
                uri: uri,
                relativePath: relativePath,
                sizeBytes: sizeBytes,
                dateModified: dateModified,
                durationMs: durationMs,
                title: title,
                artist: artist,
                album: album,
                albumArtist: albumArtist,
                year: year,
                trackNo: trackNo,
                titleSort: titleSort,
                artistSort: artistSort,
                albumSort: albumSort,
                musicbrainzRecordingId: musicbrainzRecordingId,
                source: source,
                license: license,
                isMissing: isMissing,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mediaStoreId,
                required String uri,
                Value<String?> relativePath = const Value.absent(),
                required int sizeBytes,
                required int dateModified,
                Value<int?> durationMs = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<String?> albumArtist = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<int?> trackNo = const Value.absent(),
                Value<String?> titleSort = const Value.absent(),
                Value<String?> artistSort = const Value.absent(),
                Value<String?> albumSort = const Value.absent(),
                Value<String?> musicbrainzRecordingId = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> license = const Value.absent(),
                Value<bool> isMissing = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TracksCompanion.insert(
                id: id,
                mediaStoreId: mediaStoreId,
                uri: uri,
                relativePath: relativePath,
                sizeBytes: sizeBytes,
                dateModified: dateModified,
                durationMs: durationMs,
                title: title,
                artist: artist,
                album: album,
                albumArtist: albumArtist,
                year: year,
                trackNo: trackNo,
                titleSort: titleSort,
                artistSort: artistSort,
                albumSort: albumSort,
                musicbrainzRecordingId: musicbrainzRecordingId,
                source: source,
                license: license,
                isMissing: isMissing,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TracksTable, Track>(table),
                  $$TracksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackEditsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (trackEditsRefs) db.trackEdits],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackEditsRefs)
                    await $_getPrefetchedDataByColumns<
                      Track,
                      $TracksTable,
                      TrackEdit,
                      $TrackEditsTable
                    >(
                      currentTable: table,
                      referencedTable: $$TracksTableReferences
                          ._trackEditsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TracksTableReferences(db, table, p0).trackEditsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'track_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TracksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TracksTable,
      Track,
      $$TracksTableFilterComposer,
      $$TracksTableOrderingComposer,
      $$TracksTableAnnotationComposer,
      $$TracksTableCreateCompanionBuilder,
      $$TracksTableUpdateCompanionBuilder,
      (Track, $$TracksTableReferences),
      Track,
      PrefetchHooks Function({bool trackEditsRefs})
    >;
typedef $$TrackEditsTableCreateCompanionBuilder =
    TrackEditsCompanion Function({
      Value<int> trackId,
      Value<String?> title,
      Value<String?> artist,
      Value<String?> album,
      Value<int?> year,
      Value<String?> titleSort,
      Value<String?> artistSort,
      Value<String?> albumSort,
      Value<DateTime> updatedAt,
    });
typedef $$TrackEditsTableUpdateCompanionBuilder =
    TrackEditsCompanion Function({
      Value<int> trackId,
      Value<String?> title,
      Value<String?> artist,
      Value<String?> album,
      Value<int?> year,
      Value<String?> titleSort,
      Value<String?> artistSort,
      Value<String?> albumSort,
      Value<DateTime> updatedAt,
    });

final class $$TrackEditsTableReferences
    extends BaseReferences<_$AppDatabase, $TrackEditsTable, TrackEdit> {
  $$TrackEditsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TracksTable _trackIdTable(_$AppDatabase db) =>
      db.tracks.createAlias('track_edits__track_id__tracks__id');

  $$TracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$TracksTableTableManager(
      $_db,
      $_db.tracks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrackEditsTableFilterComposer
    extends Composer<_$AppDatabase, $TrackEditsTable> {
  $$TrackEditsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleSort => $composableBuilder(
    column: $table.titleSort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artistSort => $composableBuilder(
    column: $table.artistSort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get albumSort => $composableBuilder(
    column: $table.albumSort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TracksTableFilterComposer get trackId {
    final $$TracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableFilterComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackEditsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackEditsTable> {
  $$TrackEditsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get album => $composableBuilder(
    column: $table.album,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleSort => $composableBuilder(
    column: $table.titleSort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artistSort => $composableBuilder(
    column: $table.artistSort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get albumSort => $composableBuilder(
    column: $table.albumSort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TracksTableOrderingComposer get trackId {
    final $$TracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableOrderingComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackEditsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackEditsTable> {
  $$TrackEditsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get album =>
      $composableBuilder(column: $table.album, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get titleSort =>
      $composableBuilder(column: $table.titleSort, builder: (column) => column);

  GeneratedColumn<String> get artistSort => $composableBuilder(
    column: $table.artistSort,
    builder: (column) => column,
  );

  GeneratedColumn<String> get albumSort =>
      $composableBuilder(column: $table.albumSort, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TracksTableAnnotationComposer get trackId {
    final $$TracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.tracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TracksTableAnnotationComposer(
            $db: $db,
            $table: $db.tracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackEditsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackEditsTable,
          TrackEdit,
          $$TrackEditsTableFilterComposer,
          $$TrackEditsTableOrderingComposer,
          $$TrackEditsTableAnnotationComposer,
          $$TrackEditsTableCreateCompanionBuilder,
          $$TrackEditsTableUpdateCompanionBuilder,
          (TrackEdit, $$TrackEditsTableReferences),
          TrackEdit,
          PrefetchHooks Function({bool trackId})
        > {
  $$TrackEditsTableTableManager(_$AppDatabase db, $TrackEditsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackEditsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackEditsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackEditsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> trackId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<String?> titleSort = const Value.absent(),
                Value<String?> artistSort = const Value.absent(),
                Value<String?> albumSort = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TrackEditsCompanion(
                trackId: trackId,
                title: title,
                artist: artist,
                album: album,
                year: year,
                titleSort: titleSort,
                artistSort: artistSort,
                albumSort: albumSort,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> trackId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> album = const Value.absent(),
                Value<int?> year = const Value.absent(),
                Value<String?> titleSort = const Value.absent(),
                Value<String?> artistSort = const Value.absent(),
                Value<String?> albumSort = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TrackEditsCompanion.insert(
                trackId: trackId,
                title: title,
                artist: artist,
                album: album,
                year: year,
                titleSort: titleSort,
                artistSort: artistSort,
                albumSort: albumSort,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrackEditsTable, TrackEdit>(table),
                  $$TrackEditsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackId,
                                referencedTable: $$TrackEditsTableReferences
                                    ._trackIdTable(db),
                                referencedColumn: $$TrackEditsTableReferences
                                    ._trackIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrackEditsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackEditsTable,
      TrackEdit,
      $$TrackEditsTableFilterComposer,
      $$TrackEditsTableOrderingComposer,
      $$TrackEditsTableAnnotationComposer,
      $$TrackEditsTableCreateCompanionBuilder,
      $$TrackEditsTableUpdateCompanionBuilder,
      (TrackEdit, $$TrackEditsTableReferences),
      TrackEdit,
      PrefetchHooks Function({bool trackId})
    >;
typedef $$LibraryFoldersTableCreateCompanionBuilder =
    LibraryFoldersCompanion Function({
      Value<int> id,
      required String relativePath,
      Value<DateTime> createdAt,
    });
typedef $$LibraryFoldersTableUpdateCompanionBuilder =
    LibraryFoldersCompanion Function({
      Value<int> id,
      Value<String> relativePath,
      Value<DateTime> createdAt,
    });

class $$LibraryFoldersTableFilterComposer
    extends Composer<_$AppDatabase, $LibraryFoldersTable> {
  $$LibraryFoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LibraryFoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $LibraryFoldersTable> {
  $$LibraryFoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LibraryFoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LibraryFoldersTable> {
  $$LibraryFoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LibraryFoldersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LibraryFoldersTable,
          LibraryFolder,
          $$LibraryFoldersTableFilterComposer,
          $$LibraryFoldersTableOrderingComposer,
          $$LibraryFoldersTableAnnotationComposer,
          $$LibraryFoldersTableCreateCompanionBuilder,
          $$LibraryFoldersTableUpdateCompanionBuilder,
          (
            LibraryFolder,
            BaseReferences<_$AppDatabase, $LibraryFoldersTable, LibraryFolder>,
          ),
          LibraryFolder,
          PrefetchHooks Function()
        > {
  $$LibraryFoldersTableTableManager(
    _$AppDatabase db,
    $LibraryFoldersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibraryFoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibraryFoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LibraryFoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LibraryFoldersCompanion(
                id: id,
                relativePath: relativePath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String relativePath,
                Value<DateTime> createdAt = const Value.absent(),
              }) => LibraryFoldersCompanion.insert(
                id: id,
                relativePath: relativePath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LibraryFoldersTable, LibraryFolder>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LibraryFoldersTable,
                    LibraryFolder
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LibraryFoldersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LibraryFoldersTable,
      LibraryFolder,
      $$LibraryFoldersTableFilterComposer,
      $$LibraryFoldersTableOrderingComposer,
      $$LibraryFoldersTableAnnotationComposer,
      $$LibraryFoldersTableCreateCompanionBuilder,
      $$LibraryFoldersTableUpdateCompanionBuilder,
      (
        LibraryFolder,
        BaseReferences<_$AppDatabase, $LibraryFoldersTable, LibraryFolder>,
      ),
      LibraryFolder,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TracksTableTableManager get tracks =>
      $$TracksTableTableManager(_db, _db.tracks);
  $$TrackEditsTableTableManager get trackEdits =>
      $$TrackEditsTableTableManager(_db, _db.trackEdits);
  $$LibraryFoldersTableTableManager get libraryFolders =>
      $$LibraryFoldersTableTableManager(_db, _db.libraryFolders);
}
