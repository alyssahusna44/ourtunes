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
