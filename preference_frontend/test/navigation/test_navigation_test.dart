import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:preference_frontend/main.dart';

/// A minimal second screen used in tests to validate navigation flows.
class _TestSecondScreen extends StatelessWidget {
  const _TestSecondScreen({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(label, key: const Key('second_screen_text')),
            const SizedBox(height: 8),
            ElevatedButton(
              key: const Key('pop_button'),
              onPressed: () => Navigator.of(context).pop('popped'),
              child: const Text('Pop'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  group('Navigation - imperative push/pop', () {
    testWidgets('Navigator.push to a new screen and pop with result', (tester) async {
      // Start the real app entrypoint.
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify we are on MyHomePage.
      expect(find.text('preference_frontend'), findsOneWidget);
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);

      // Add a floating action button for test-only push by using a Navigator action
      // via the Overlay. Since app does not include trigger controls, we push programmatically.
      final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
      // Push a test screen.
      Future<String?> routeFuture = navigatorState.push<String>(
        MaterialPageRoute<String>(
          builder: (context) => const _TestSecondScreen(
            key: Key('second_screen_route'),
            label: 'Second',
          ),
          settings: const RouteSettings(name: '/second'),
        ),
      );

      await tester.pumpAndSettle();

      // On second screen.
      expect(find.text('Second'), findsWidgets); // title and body text

      // Pop with a result.
      await tester.tap(find.byKey(const Key('pop_button')));
      await tester.pumpAndSettle();

      // We should be back on MyHomePage.
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);

      // Assert the result from the popped route.
      final result = await routeFuture;
      expect(result, 'popped');
    });
  });

  group('Navigation - named routes (local test scaffold)', () {
    testWidgets('Navigator.pushNamed and pop works using local routes map', (tester) async {
      // Build a local MaterialApp that uses named routes only for this test.
      final localApp = MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (_) => const MyHomePage(title: 'preference_frontend'),
          '/second': (_) => const _TestSecondScreen(
                key: Key('named_second_screen_route'),
                label: 'Named Second',
              ),
        },
      );

      await tester.pumpWidget(localApp);
      await tester.pumpAndSettle();

      // Confirm home.
      expect(find.text('preference_frontend'), findsOneWidget);
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);

      // Navigate to named route.
      final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
      Future<String?> routeFuture = navigatorState.pushNamed<String>('/second');
      await tester.pumpAndSettle();

      // Assert on named second screen.
      expect(find.text('Named Second'), findsWidgets);

      // Pop back using the button.
      await tester.tap(find.byKey(const Key('pop_button')));
      await tester.pumpAndSettle();

      // Back on home.
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);

      final result = await routeFuture;
      expect(result, 'popped');
    });
  });

  group('Navigation - back button behavior', () {
    testWidgets('Android back button (escape) pops the route', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Push second screen.
      final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
      navigatorState.push(
        MaterialPageRoute<void>(
          builder: (_) => const _TestSecondScreen(
            key: Key('back_second_screen_route'),
            label: 'Back Second',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify on second screen.
      expect(find.text('Back Second'), findsWidgets);

      // Simulate back navigation via back button/escape.
      // This sends a key event equivalent to the system back on Android test env.
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      // Assert we returned to home.
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);
    });

    testWidgets('WillPopScope-like behavior: canPop false on root', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
      // Root should not be able to pop initially.
      expect(navigatorState.canPop(), isFalse);

      // After a push, canPop should be true.
      navigatorState.push(
        MaterialPageRoute<void>(
          builder: (_) => const _TestSecondScreen(
            key: Key('another_second_screen_route'),
            label: 'Another',
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(navigatorState.canPop(), isTrue);
    });
  });
}
