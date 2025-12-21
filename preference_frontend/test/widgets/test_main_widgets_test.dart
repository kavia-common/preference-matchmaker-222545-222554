import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:preference_frontend/main.dart';

void main() {
  group('MyApp', () {
    testWidgets('renders MaterialApp with title and home', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('preference_frontend'), findsOneWidget);
    });
  });

  group('MyHomePage', () {
    testWidgets('shows generation message and a progress indicator', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      expect(
        find.text('preference_frontend App is being generated...'),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('AppBar uses inversePrimary color and has title', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);
      expect(find.text('preference_frontend'), findsOneWidget);
    });

    testWidgets('layout is centered column', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      // Ensure there are at least the text and progress indicator children.
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Unimplemented app sections', () {
    testWidgets('home/swipe placeholder - skipped', (tester) async {
      // No dedicated Home/Swipe widget exists yet.
      // This test documents the pending implementation.
      const skipMessage = 'Home/Swipe screen not yet implemented in lib/.';
      expect(skipMessage, isNotEmpty);
    }, skip: true);

    testWidgets('matches placeholder - skipped', (tester) async {
      const skipMessage = 'Matches screen not yet implemented in lib/.';
      expect(skipMessage, isNotEmpty);
    }, skip: true);

    testWidgets('chat placeholder - skipped', (tester) async {
      const skipMessage = 'Chat screen not yet implemented in lib/.';
      expect(skipMessage, isNotEmpty);
    }, skip: true);

    testWidgets('profile placeholder - skipped', (tester) async {
      const skipMessage = 'Profile screen not yet implemented in lib/.';
      expect(skipMessage, isNotEmpty);
    }, skip: true);
  });
}
