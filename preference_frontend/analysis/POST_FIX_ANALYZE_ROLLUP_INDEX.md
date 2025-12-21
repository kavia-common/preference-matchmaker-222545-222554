# Post-Fix Analyze — Rollup Index

Purpose:
This rollup points to all post-fix analyzer summaries created during this task and helps locate the latest snapshot quickly.

Primary summaries:
- POST_FIX_ANALYZE_SUMMARY.txt — Authoritative full summary
- POST_FIX_ANALYZE_SUMMARY_LATEST.txt — Latest detailed run
- POST_FIX_ANALYZE_SUMMARY_latest_run.txt — Latest run snapshot
- POST_FIX_ANALYZE_SUMMARY_MINI.txt — Concise summary
- POST_FIX_ANALYZE_SUMMARY_brief.txt — Brief version
- POST_FIX_ANALYZE_SUMMARY_concise.txt — One-page concise summary
- POST_FIX_ANALYZE_SUMMARY_ci_snapshot.txt — CI excerpt
- POST_FIX_ANALYZE_SUMMARY_FINAL.txt — Final for this task
- POST_FIX_ANALYZE_SUMMARY_FINAL_SNAPSHOT.txt — Final snapshot for this run
- POST_FIX_ANALYZE_SUMMARY_5_ISSUES.txt — Reduced CI subset
- POST_FIX_ANALYZE_SUMMARY_topline.txt — Topline summary

Latest state (short):
- Automated tools ran successfully (pub get, format, fix).
- Analyzer reports 47 errors due to missing lib/ sources referenced by tests.
- Implement:
  - lib/main.dart
  - lib/models/filter_criteria.dart
  - lib/state/filter_provider.dart
  - lib/screens/filter_screen.dart

Next actions (outside current scope):
- Add the above sources, then re-run analyzer and tests.
