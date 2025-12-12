# Testing and Coverage Guide

This project includes a standard Flutter test suite with:
- Widget tests for core app widgets (MyApp, MyHomePage)
- Service mocking examples using mocktail
- Shared test helpers for consistent widget pumping
- Coverage script targeting ~80% overall coverage

## Test Structure

- test/
  - widgets/
    - test_main_widgets_test.dart
  - services/
    - test_sample_service_test.dart (mocktail example)
  - helpers/
    - test_helpers.dart
  - widget_test.dart (smoke test)

Planned areas (currently not implemented in lib/):
- Home/Swipe, Matches, Chat, Profile screens
  - Placeholder tests exist and are marked `skip: true`. Once screens exist, unskip and add real assertions.

## Dependencies

Ensure dev dependencies include:
- flutter_test
- mocktail

Already added to pubspec.yaml.

Install/update packages:
- flutter pub get

## Running Tests

- Run tests only:
  - flutter test

- Run tests with coverage and produce lcov:
  - bash coverage.sh
  - Artifacts are created in coverage/ (lcov.info)

If you have `lcov` installed, the script will filter out:
- Generated files (*.g.dart, *.freezed.dart)
- main.dart bootstrap

Optional: Convert LCOV to HTML locally (requires genhtml):
- genhtml coverage/lcov.info -o coverage/html
- open coverage/html/index.html

### Navigation Tests
- Location: test/navigation/
- These tests validate:
  - Navigator.push/pop flows with a dummy second screen
  - Named route navigation via a local routes map scaffold
  - Back button behavior (using escape key event in tests)
- Important: Avoid using `pumpAndSettle()` on screens with continuous animations (e.g., `CircularProgressIndicator` on home),
  as it may never settle. Instead:
  - Wrap the subtree with `TickerMode(enabled: false, child: ...)` while asserting on the home screen, and
  - Use bounded pumps: `await tester.pump(); await tester.pump(const Duration(milliseconds: 200));`.
- Run only navigation tests:
  - flutter test test/navigation/

## CI Guidance (optional)

If CI is present, run:
- flutter pub get
- flutter test --coverage

To enforce ~80% coverage, consider a coverage gate step using a tool like `lcov_cobertura` or a custom script to parse coverage/lcov.info.

## Adding New Tests

- Widgets:
  - Place under test/widgets/
  - Use test/helpers/test_helpers.dart to pump widgets:
    - await pumpApp(tester, YourWidget());

- Services:
  - Place under test/services/
  - Use mocktail for mocks and verifications:
    - class MockYourService extends Mock implements YourService {}

## Notes

- Screens not present in the codebase (home/swipe, matches, chat, profile) are documented with skipped placeholder tests in test/widgets/test_main_widgets_test.dart.
- When those screens are implemented under lib/, replace the placeholders with concrete tests and assertions to increase coverage.
