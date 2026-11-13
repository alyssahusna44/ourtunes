import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ourtunes/app/app.dart';

void main() {
  testWidgets('shows the bottom navigation with four tabs', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: OurTunesApp()));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));
  });
}
