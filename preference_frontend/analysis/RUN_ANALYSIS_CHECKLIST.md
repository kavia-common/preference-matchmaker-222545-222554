# Run Analysis Checklist (Flutter/Dart)

Use this checklist to run static analysis reliably and triage findings.

Prereqs:
- Flutter SDK installed and on PATH
- Dart SDK bundled with Flutter
- Android toolchain optional (not needed for analysis)
- From project root: `preference-matchmaker-222545-222554/preference_frontend`

Commands:
1) Fetch packages:
   - flutter pub get

2) Run analyzer:
   - dart analyze .

3) Optional auto-fix (safe fixes):
   - dart fix --apply

4) Format:
   - dart format .

Artifacts produced by this repo:
- STATIC_ANALYSIS_REPORT.md (narrative summary)
- analysis/STATIC_ANALYSIS_SUMMARY.txt (plain-text summary)
- analysis/artifacts/dart_analyze_summary.json (JSON summary)
- analysis/artifacts/dart_analyze_latest.csv (CSV issues)
- analysis/artifacts/dart_analyze_YYYY-MM-DDTHH-MM-SSZ.json (snapshots)

Common blocking errors (current state):
- uri_does_not_exist for package:preference_frontend/... imports
- undefined classes: MyApp, MyHomePage, FilterProvider, FilterCriteria, Range, Race, HairColor, Religion
- Cause: missing lib/ application sources expected by tests

How to resolve blockers (next actions):
- Create these files under lib/:
  - lib/main.dart (MyApp, MyHomePage)
  - lib/models/filter_criteria.dart (FilterCriteria, Range, Race, HairColor, Religion)
  - lib/state/filter_provider.dart (FilterProvider)
  - lib/screens/filter_screen.dart (FilterScreen with keys: apply_all_button, reset_button)
- Ensure imports use full package paths: package:preference_frontend/...

Post-fix verification:
- flutter pub get
- dart format .
- dart analyze .
- dart fix --apply
- flutter test

Notes:
- analysis_options.yaml uses flutter_lints; consider enabling additional rules after build passes.
- Keep to Effective Dart naming, prefer const constructors, and avoid using BuildContext across async gaps.
