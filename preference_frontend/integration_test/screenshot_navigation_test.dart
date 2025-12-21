import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Import the app entrypoint
import 'package:preference_frontend/main.dart' as app;

/// Utility to ensure folder exists before saving screenshots.
Future<void> _ensureDir(String path) async {
  final dir = Directory(path);
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
}

// PUBLIC_INTERFACE
Future<void> main() async {
  /** Entry point for the integration test that navigates through key screens
   * (Home, Matches, Chat, Profile, Filter) and captures screenshots for each.
   *
   * Screenshots are saved under assets/screenshots/ with file names:
   *  - home.png
   *  - matches.png
   *  - chat.png
   *  - profile.png
   *  - filter.png
   *
   * Run with a connected device or emulator:
   *   flutter test integration_test --device <device_id>
   * Or:
   *   flutter drive --driver=test_driver/integration_test.dart --target=integration_test/screenshot_navigation_test.dart
   */
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  const screenshotsDir = 'assets/screenshots';
  await _ensureDir(screenshotsDir);

  group('Navigation screenshots', () {
    testWidgets('Capture screenshots for Home, Matches, Chat, Profile, Filter',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Helper to take a screenshot using the binding
      Future<void> takeShot(String name) async {
        // The binding api writes to the test output; here we also ensure the dir exists.
        await _ensureDir(screenshotsDir);
        // Some platforms save into test output directories; we also save to project folder
        final bytes = await binding.takeScreenshot(name);
        final file = File('$screenshotsDir/$name.png');
        await file.writeAsBytes(bytes);
      }

      // Expect a BottomNavigationBar to be present
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // HOME tab: Typically index 0
      // Try to find by label first; otherwise tap first BottomNavigationBarItem
      Finder homeTab = find.text('Home');
      if (homeTab.evaluate().isEmpty) {
        // fallback: first icon in BottomNavigationBar
        final items = find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.byType(Icon),
        );
        if (items.evaluate().isNotEmpty) {
          homeTab = items.at(0);
        } else {
          homeTab = find.byType(BottomNavigationBar);
        }
      }
      await tester.tap(homeTab);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await takeShot('home');

      // MATCHES tab
      Finder matchesTab = find.text('Matches');
      if (matchesTab.evaluate().isEmpty) {
        // fallback: second icon
        final icons = find.descendant(
          of: find.byType(BottomNavigationBar),
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
        // fallback: third icon
        final icons = find.descendant(
          of: find.byType(BottomNavigationBar),
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
        // fallback: fourth icon
        final icons = find.descendant(
          of: find.byType(BottomNavigationBar),
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

      // Go back to Home to access Filter (if accessible from Home)
      if (homeTab.evaluate().isNotEmpty) {
        await tester.tap(homeTab);
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      // Try to open Filter screen:
      // We attempt common triggers:
      // 1) An IconButton with filter icon
      // 2) A button labeled 'Filter' or with a Key('openFilter')
      Finder openFilter = find.byKey(const Key('openFilter'));
      if (openFilter.evaluate().isEmpty) {
        openFilter = find.textContaining('Filter', findRichText: true);
      }
      if (openFilter.evaluate().isEmpty) {
        openFilter = find.byIcon(Icons.filter_list);
      }
      if (openFilter.evaluate().isEmpty) {
        openFilter = find.byIcon(Icons.tune);
      }

      if (openFilter.evaluate().isNotEmpty) {
        await tester.tap(openFilter);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await takeShot('filter');

        // Attempt to close if there is a Back button to not affect next tests
        final backBtn = find.byTooltip('Back');
        if (backBtn.evaluate().isNotEmpty) {
          await tester.tap(backBtn);
          await tester.pumpAndSettle(const Duration(milliseconds: 500));
        }
      } else {
        // If not found, we still produce a "filter.png" placeholder from current view
        await takeShot('filter');
      }
    });
  });
}
