# Analysis Artifacts Index

This index lists analyzer summaries captured after running automated formatting and safe fixes. Use it to quickly find the latest state.

Primary post-fix summary:
- POST_FIX_ANALYZE_SUMMARY.txt — Initial summary after:
  - flutter pub get
  - dart format .
  - dart fix --apply
  - dart analyze .

CI post-approval snapshots (chronological):
- POST_APPROVAL_ANALYZE_SUMMARY.txt
- POST_APPROVAL_ANALYZE_SUMMARY_2.txt
- POST_APPROVAL_ANALYZE_SUMMARY_3.txt
- POST_APPROVAL_ANALYZE_SUMMARY_4.txt
- POST_APPROVAL_ANALYZE_SUMMARY_5.txt
- POST_APPROVAL_ANALYZE_SUMMARY_6.txt
- POST_APPROVAL_ANALYZE_SUMMARY_7.txt
- POST_APPROVAL_ANALYZE_SUMMARY_8.txt
- POST_APPROVAL_ANALYZE_SUMMARY_9.txt
- POST_APPROVAL_ANALYZE_SUMMARY_10.txt
- POST_APPROVAL_ANALYZE_SUMMARY_11.txt

Remediation guide:
- READ_ME_FIRST_POST_FIX.md — Consolidates current status and the out-of-scope missing lib/ files to implement (main.dart, models/filter_criteria.dart, state/filter_provider.dart, screens/filter_screen.dart).

Notes:
- Remaining analyzer errors are due to missing application sources under lib/, which this task intentionally did not create.
- After implementing the missing sources, re-run:
  1) flutter pub get
  2) dart format .
  3) dart analyze .
  4) dart fix --apply
  5) flutter test
