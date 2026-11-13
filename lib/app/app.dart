import 'package:flutter/material.dart';

import 'package:ourtunes/app/router.dart';
import 'package:ourtunes/app/theme.dart';

class OurTunesApp extends StatelessWidget {
  const OurTunesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'OurTunes',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
