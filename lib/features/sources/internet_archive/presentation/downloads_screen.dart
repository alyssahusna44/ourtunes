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
