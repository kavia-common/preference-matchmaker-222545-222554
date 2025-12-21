# Post-Fix Analyze Summaries — How to Read

This folder contains multiple summary variants produced after running:
- flutter pub get
- dart format .
- dart fix --apply
- dart analyze .

Primary current state:
- Analyzer still reports missing lib/ sources referenced by tests (47 issues in full run).
- This is expected because implementing these sources is out of scope for the formatting/fix step.

Where to look:
- POST_FIX_ANALYZE_SUMMARY.txt — Authoritative full summary
- POST_FIX_ANALYZE_SUMMARY_LATEST.txt — Latest detailed run
- POST_FIX_ANALYZE_SUMMARY_MINI.txt — Concise summary
- POST_FIX_ANALYZE_SUMMARY_5_ISSUES.txt — Reduced CI snapshot focused on widgets main test
- POST_FIX_ANALYZE_SUMMARY_concise.txt — One-page concise version
- POST_FIX_ANALYZE_SUMMARY_latest_run.txt — Latest run snapshot
- POST_FIX_ANALYZE_SUMMARY_ci_snapshot.txt — CI excerpt summary

Next steps (outside this task):
- Implement missing lib/ sources:
  - lib/main.dart (MyApp/MyHomePage)
  - lib/models/filter_criteria.dart (FilterCriteria, Range, Race, HairColor, Religion)
  - lib/state/filter_provider.dart (FilterProvider)
  - lib/screens/filter_screen.dart (FilterScreen with apply_all_button, reset_button)
- Then re-run analyze and tests.
