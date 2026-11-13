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
