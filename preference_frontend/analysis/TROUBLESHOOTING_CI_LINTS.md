# Troubleshooting — CI Lints Keep Failing

Why CI analyze fails:
- Tests import application files under `lib/` (e.g., `package:preference_frontend/main.dart`), but those files do not exist yet.
- The current task only applied automated formatting and safe fixes; it intentionally did not create any new sources.

Symptoms you’ll see in CI:
- uri_does_not_exist for:
  - package:preference_frontend/main.dart
  - package:preference_frontend/models/filter_criteria.dart
  - package:preference_frontend/state/filter_provider.dart
  - package:preference_frontend/screens/filter_screen.dart
- creation_with_non_type / undefined_* for:
  - MyApp, MyHomePage
  - FilterProvider
  - FilterCriteria, Range, Race, HairColor, Religion
  - FilterScreen

How to fix (next work item):
1) Implement missing `lib/` sources with the expected symbols:
   - lib/main.dart — MyApp (+ MyHomePage)
   - lib/models/filter_criteria.dart — FilterCriteria, Range, enums
   - lib/state/filter_provider.dart — FilterProvider (ChangeNotifier)
   - lib/screens/filter_screen.dart — FilterScreen (with keys: apply_all_button, reset_button)
2) Run locally:
   - flutter pub get
   - dart format .
   - dart analyze .
   - dart fix --apply
   - flutter test
3) Commit and push. CI lint step should pass once sources exist.

Where to start:
- See analysis/READ_ME_FIRST_POST_FIX.md (overview)
- See analysis/NEXT_AGENT_CHECKLIST.md (step-by-step plan)
- See analysis/ARTIFACTS_INDEX.md (find the latest analyzer snapshot)

Notes:
- Keep to full package imports (package:preference_frontend/...).
- Prefer const constructors and Effective Dart conventions.
