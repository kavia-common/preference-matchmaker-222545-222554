import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// PUBLIC_INTERFACE
Widget wrapWithMaterialApp(Widget child, {ThemeData? theme}) {
  /** Wrap a widget with a minimal MaterialApp/Scaffold for widget tests. */
  return MaterialApp(
    theme: theme ?? ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
    home: Scaffold(body: child),
  );
}

/// PUBLIC_INTERFACE
Future<void> pumpApp(WidgetTester tester, Widget widget, {ThemeData? theme}) async {
  /** Pump a widget wrapped in MaterialApp+Scaffold. */
  await tester.pumpWidget(wrapWithMaterialApp(widget, theme: theme));
  await tester.pump();
}

/// Example mock classes for service layer with mocktail
class MockApiClient extends Mock {}

class FakeUri extends Fake {}

/// Registers common fallback values for mocktail.
void registerFallbacks() {
  registerFallbackValue(Uri());
}
