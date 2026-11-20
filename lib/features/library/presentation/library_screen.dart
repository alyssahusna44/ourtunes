import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ourtunes/features/library/data/library_providers.dart';
import 'package:ourtunes/features/library/domain/audio_permission_service.dart';
import 'package:ourtunes/features/library/domain/library_track.dart';
import 'package:ourtunes/features/library/domain/media_store_source.dart';
import 'package:ourtunes/features/library/domain/scan_result.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen>
    with WidgetsBindingObserver {
  AudioPermissionStatus? _permission;
  bool _scanning = false;
  ScanResult? _lastScan;
  String? _error;
  TrackSortField _sortBy = TrackSortField.artist;
  late Stream<List<LibraryTrack>> _tracks;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tracks = ref.read(libraryRepositoryProvider).watchTracks(_sortBy);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // The user may have granted access in the system settings.
    if (state == AppLifecycleState.resumed &&
        _permission != AudioPermissionStatus.granted) {
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    final status = await ref.read(libraryRepositoryProvider).permissionStatus();
    if (!mounted) return;
    setState(() => _permission = status);
    if (status == AudioPermissionStatus.granted) {
      await _scan();
    }
  }

  Future<void> _requestPermission() async {
    final repository = ref.read(libraryRepositoryProvider);
    if (_permission == AudioPermissionStatus.permanentlyDenied) {
      await repository.openPermissionSettings();
      return;
    }
    final status = await repository.requestPermission();
    if (!mounted) return;
    setState(() => _permission = status);
    if (status == AudioPermissionStatus.granted) {
      await _scan();
    }
  }

  Future<void> _scan() async {
    if (_scanning) return;
    setState(() {
      _scanning = true;
      _error = null;
    });
    try {
      final result = await ref.read(libraryRepositoryProvider).rescan();
      if (!mounted) return;
      setState(() => _lastScan = result);
    } on MediaStorePermissionException {
      if (!mounted) return;
      setState(() => _permission = AudioPermissionStatus.denied);
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = 'Scan failed: $error');
    } finally {
      if (mounted) {
        setState(() => _scanning = false);
      }
    }
  }

  void _changeSort(TrackSortField field) {
    setState(() {
      _sortBy = field;
      _tracks = ref.read(libraryRepositoryProvider).watchTracks(field);
    });
  }

  @override
  Widget build(BuildContext context) {
    final granted = _permission == AudioPermissionStatus.granted;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        actions: [
          PopupMenuButton<TrackSortField>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort by',
            initialValue: _sortBy,
            onSelected: _changeSort,
            itemBuilder: (context) => [
              for (final field in TrackSortField.values)
                PopupMenuItem(value: field, child: Text(_sortLabel(field))),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Rescan',
            onPressed: granted && !_scanning ? _scan : null,
          ),
        ],
      ),
      body: _permission == null
          ? const Center(child: CircularProgressIndicator())
          : granted
              ? _buildLibrary()
              : _buildPermissionRequest(),
    );
  }

  Widget _buildPermissionRequest() {
    final blocked = _permission == AudioPermissionStatus.permanentlyDenied;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.library_music, size: 64),
            const SizedBox(height: 16),
            Text(
              blocked
                  ? 'Audio access is turned off. Enable it in the app settings '
                      'to see your music.'
                  : 'OurTunes needs access to the audio files on your phone '
                      'to build your library.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _requestPermission,
              child: Text(blocked ? 'Open settings' : 'Allow access'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibrary() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        if (_scanning) const LinearProgressIndicator(),
        if (_lastScan != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(_lastScan!.summary, style: textTheme.bodySmall),
          ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              _error!,
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        Expanded(
          child: StreamBuilder<List<LibraryTrack>>(
            stream: _tracks,
            builder: (context, snapshot) {
              final tracks = snapshot.data ?? const <LibraryTrack>[];
              if (tracks.isEmpty) {
                return Center(
                  child: Text(
                    _scanning ? 'Scanning...' : 'No music found yet.',
                  ),
                );
              }
              return ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (context, index) => _TrackTile(track: tracks[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  String _sortLabel(TrackSortField field) {
    switch (field) {
      case TrackSortField.title:
        return 'Title';
      case TrackSortField.artist:
        return 'Artist';
      case TrackSortField.album:
        return 'Album';
      case TrackSortField.year:
        return 'Year';
    }
  }
}

class _TrackTile extends StatelessWidget {
  const _TrackTile({required this.track});

  final LibraryTrack track;

  @override
  Widget build(BuildContext context) {
    final artist = track.artist ?? 'Unknown Artist';
    final album = track.album ?? 'Unknown Album';
    return ListTile(
      leading: const Icon(Icons.music_note),
      title: Text(track.title ?? 'Unknown Title', maxLines: 1),
      subtitle: Text('$artist | $album', maxLines: 1),
      trailing: Text(_formatDuration(track.durationMs)),
    );
  }

  String _formatDuration(int? durationMs) {
    if (durationMs == null) return '';
    final totalSeconds = durationMs ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
