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
