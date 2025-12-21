# Static Analysis Report — preference_frontend

Date: 2025-12-21
Tooling:
- Flutter 3.29.1 • Dart 3.7.0
- Commands executed:
  - flutter pub get
  - dart analyze .

Scope:
- Analyzed the Flutter mobile app in `preference_frontend`.
- Used the project's `analysis_options.yaml` (includes flutter_lints).

---

## 1) Summary of Issues by Severity

- Errors: 52
- Warnings/Infos: Not separately reported; the dominant category is errors due to missing source files referenced by tests.

Blocking: Yes — current errors prevent successful builds/tests.

---

## 2) Top Recurring Rule Violations (Patterns)

- uri_does_not_exist
  - Test files import application modules that are not present in `lib/`:
    - `package:preference_frontend/main.dart`
    - `package:preference_frontend/models/filter_criteria.dart`
    - `package:preference_frontend/screens/filter_screen.dart`
    - `package:preference_frontend/state/filter_provider.dart`

- undefined_identifier / undefined_class (downstream of missing files)
  - Symbols referenced in tests cannot be resolved:
    - `MyApp`, `MyHomePage`
    - `FilterProvider`
    - `FilterCriteria`, `Range`, `Race`, `HairColor`, `Religion`

- invalid_constant
  - Occurs because unresolved widgets/types are used in const contexts (cascades from undefined classes).

---

## 3) Hotspots (Files with Most Issues)

- `test/navigation/test_navigation_test.dart`
  - Missing imports for `MyApp`, `MyHomePage` and related.
- `test/widgets/test_main_widgets_test.dart`
  - Missing `MyApp`, `MyHomePage`.
- `test/widget_test.dart`
  - Missing `MyApp`.
- `test/screens/filter_screen_test.dart`
  - Missing `FilterScreen`, `FilterProvider`, `FilterCriteria`, and types.
- `test/state/filter_provider_test.dart`
  - Missing `FilterProvider`, `FilterCriteria`, `Range`, `Race`, `HairColor`, `Religion`.

---

## 4) Recommendations and Next Actions

Blocking resolution (highest priority):
- Implement the missing application source files under `lib/` to match test expectations:
  - `lib/main.dart`
    - Provide `MyApp` and `MyHomePage`.
  - `lib/models/filter_criteria.dart`
    - Provide `FilterCriteria`, `Range`, and enums/types: `Race`, `HairColor`, `Religion`.
  - `lib/state/filter_provider.dart`
    - Provide `FilterProvider` as a `ChangeNotifier` that manages `FilterCriteria` and exposes required methods used in tests (`toggleHairColor`, `toggleRace`, `updateHeightRange`, `updateWeightRange`, `reset`, etc.).
  - `lib/screens/filter_screen.dart`
    - Provide `FilterScreen` widget with keys used by tests:
      - `Key('apply_all_button')` on Apply All button
      - `Key('reset_button')` on Reset action
    - Include `CheckboxListTile` groups and `RangeSlider`s for Height and Weight.

Linting and formatting:
- analysis_options.yaml already includes `flutter_lints`. After compilation succeeds, consider enabling opinionated rules (e.g., `prefer_single_quotes`) as desired.
- Format code after adding sources:
  - dart format .

Re-run static analysis and apply safe fixes:
- dart analyze
- dart fix --apply

Dependency hygiene:
- `flutter pub outdated` indicates multiple packages with newer versions constrained by current ranges. Plan updates after code compiles and tests pass.

---

## 5) Blocking Errors Affecting Build

Yes — missing lib sources referenced by tests:
- `uri_does_not_exist` for `package:preference_frontend/...` imports.
- Undefined classes/identifiers stemming from the missing files.

These must be addressed before builds or tests can succeed.

---

## Suggested Commands (after adding missing lib/ files)

- flutter pub get
- dart format .
- dart analyze .
- dart fix --apply
- flutter test

---

## Environment Notes

- Flutter 3.29.1 / Dart 3.7.0 analyzed successfully.
- `flutter pub get` completed; some packages have newer incompatible versions (expected). Use `flutter pub outdated` to review when ready.

---
