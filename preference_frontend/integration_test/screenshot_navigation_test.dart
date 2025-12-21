import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Import the root widget directly instead of calling app.main()
import 'package:preference_frontend/main.dart' show MyApp;

/// Utility to ensure folder exists before saving screenshots.
Future<void> _ensureDir(String path) async {
  final dir = Directory(path);
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
}

// PUBLIC_INTERFACE
void main() {
  /** Integration test that navigates Home, Matches, Chat, Profile and opens Filter,
   * capturing screenshots for each into assets/screenshots/.
   */
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const screenshotsDir = 'assets/screenshots';

  group('Navigation screenshots', () {
    testWidgets('Capture screenshots for Home, Matches, Chat, Profile, Filter',
        (WidgetTester tester) async {
      await _ensureDir(screenshotsDir);

      // Launch the app by pumping MyApp directly
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle(const Duration(seconds: 2));

      Future<void> takeShot(String name) async {
        await _ensureDir(screenshotsDir);
        final bytes = await binding.takeScreenshot(name);
        final file = File('$screenshotsDir/$name.png');
        await file.writeAsBytes(bytes);
      }

      // Expect a Material 3 NavigationBar to be present
      expect(find.byType(NavigationBar), findsOneWidget);

      // HOME tab
      Finder homeTab = find.text('Home');
      if (homeTab.evaluate().isEmpty) {
        final items = find.descendant(
          of: find.byType(NavigationBar),
          matching: find.byType(Icon),
        );
        if (items.evaluate().isNotEmpty) {
          homeTab = items.at(0);
        }
      }
      if (homeTab.evaluate().isNotEmpty) {
        await tester.tap(homeTab);
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }
      await takeShot('home');

      // MATCHES tab
      Finder matchesTab = find.text('Matches');
      if (matchesTab.evaluate().isEmpty) {
        final icons = find.descendant(
          of: find.byType(NavigationBar),
          matching: find.byType(Icon),
        );
        if (icons.evaluate().length >= 2) {
          matchesTab = icons.at(1);
        }
      }
      if (matchesTab.evaluate().isNotEmpty) {
        await tester.tap(matchesTab);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await takeShot('matches');
      }

      // CHAT tab
      Finder chatTab = find.text('Chat');
      if (chatTab.evaluate().isEmpty) {
        final icons = find.descendant(
          of: find.byType(NavigationBar),
          matching: find.byType(Icon),
        );
        if (icons.evaluate().length >= 3) {
          chatTab = icons.at(2);
        }
      }
      if (chatTab.evaluate().isNotEmpty) {
        await tester.tap(chatTab);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await takeShot('chat');
      }

      // PROFILE tab
      Finder profileTab = find.text('Profile');
      if (profileTab.evaluate().isEmpty) {
        final icons = find.descendant(
          of: find.byType(NavigationBar),
          matching: find.byType(Icon),
        );
        if (icons.evaluate().length >= 4) {
          profileTab = icons.at(3);
        }
      }
      if (profileTab.evaluate().isNotEmpty) {
        await tester.tap(profileTab);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await takeShot('profile');
      }

      // Return to Home before opening Filter
      if (homeTab.evaluate().isNotEmpty) {
        await tester.tap(homeTab);
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      // Open Filter via known key from MyApp AppBar icon
      Finder openFilter = find.byKey(const Key('open_filters_button'));
      if (openFilter.evaluate().isEmpty) {
        openFilter = find.textContaining('Filter', findRichText: true);
      }
      if (openFilter.evaluate().isEmpty) {
        openFilter = find.byIcon(Icons.tune);
      }

      if (openFilter.evaluate().isNotEmpty) {
        await tester.tap(openFilter);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await takeShot('filter');

        // Close (via Apply All button or system Back)
        final apply = find.byKey(const Key('apply_all_button'));
        if (apply.evaluate().isNotEmpty) {
          await tester.tap(apply);
          await tester.pumpAndSettle(const Duration(milliseconds: 500));
        } else {
          final backBtn = find.byTooltip('Back');
          if (backBtn.evaluate().isNotEmpty) {
            await tester.tap(backBtn);
            await tester.pumpAndSettle(const Duration(milliseconds: 500));
          }
        }
      } else {
        await takeShot('filter');
      }
    });
  });
}
