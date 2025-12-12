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
      // Start the real app entrypoint, but disable tickers on home to avoid infinite settle due to progress indicator.
      await tester.pumpWidget(
        const TickerMode(
          enabled: false,
          child: MyApp(),
        ),
      );
      // Use bounded pumps instead of pumpAndSettle on a continuously animating screen.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Verify we are on MyHomePage.
      expect(find.text('preference_frontend'), findsOneWidget);
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);

      // Push a test screen programmatically via Navigator.
      final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
      Future<String?> routeFuture = navigatorState.push<String>(
        MaterialPageRoute<String>(
          builder: (context) => const _TestSecondScreen(
            key: Key('second_screen_route'),
            label: 'Second',
          ),
          settings: const RouteSettings(name: '/second'),
        ),
      );

      // Let the push animation complete.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // On second screen.
      expect(find.text('Second'), findsWidgets); // title and body text

      // Pop with a result.
      await tester.tap(find.byKey(const Key('pop_button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      // We should be back on MyHomePage.
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);

      // Assert the result from the popped route.
      final result = await routeFuture;
      expect(result, 'popped');
    });
  });

  group('Navigation - named routes (local test scaffold)', () {
    testWidgets('Navigator.pushNamed and pop works using local routes map', (tester) async {
      // Build a local MaterialApp that uses named routes only for this test and
      // disable tickers while on home to avoid continuous animations settling issues.
      final localApp = TickerMode(
        enabled: false,
        child: MaterialApp(
          routes: <String, WidgetBuilder>{
            '/': (_) => const MyHomePage(title: 'preference_frontend'),
            '/second': (_) => const _TestSecondScreen(
                  key: Key('named_second_screen_route'),
                  label: 'Named Second',
                ),
          },
        ),
      );

      await tester.pumpWidget(localApp);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Confirm home.
      expect(find.text('preference_frontend'), findsOneWidget);
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);

      // Navigate to named route.
      final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
      final Future<Object?> routeFuture = navigatorState.pushNamed('/second');

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Assert on named second screen.
      expect(find.text('Named Second'), findsWidgets);

      // Pop back using the button.
      await tester.tap(find.byKey(const Key('pop_button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      // Back on home.
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);

      final result = await routeFuture;
      expect(result, 'popped');
    });
  });

  group('Navigation - back button behavior', () {
    testWidgets('Android back button (escape) pops the route', (tester) async {
      await tester.pumpWidget(
        const TickerMode(
          enabled: false,
          child: MyApp(),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

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
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Verify on second screen.
      expect(find.text('Back Second'), findsWidgets);

      // Simulate back navigation via back button/escape.
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      // Assert we returned to home.
      expect(find.text('preference_frontend App is being generated...'), findsOneWidget);
    });

    testWidgets('WillPopScope-like behavior: canPop false on root', (tester) async {
      await tester.pumpWidget(
        const TickerMode(
          enabled: false,
          child: MyApp(),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

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
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(navigatorState.canPop(), isTrue);
    });
  });
}
