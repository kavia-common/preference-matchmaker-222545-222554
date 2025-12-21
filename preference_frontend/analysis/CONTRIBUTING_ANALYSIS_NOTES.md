# Contributing Notes — Analysis Artifacts

This project captures analyzer outputs under `analysis/` to provide a reliable audit trail for CI and local runs.

What you’ll find:
- POST_FIX_ANALYZE_SUMMARY.txt — Initial post-format/fix analyzer summary
- POST_APPROVAL_ANALYZE_SUMMARY_*.txt — Subsequent CI snapshots
- READ_ME_FIRST_POST_FIX.md — One-page remediation guide
- ARTIFACTS_INDEX.md — Quick index of all analyzer artifacts
- NEXT_AGENT_CHECKLIST.md — Step-by-step checklist to implement missing lib/ sources

How to use these artifacts:
1) Start with `READ_ME_FIRST_POST_FIX.md` for context and required missing sources.
2) Use `ARTIFACTS_INDEX.md` to locate the latest analyzer snapshot.
3) Follow `NEXT_AGENT_CHECKLIST.md` to implement the minimal `lib/` files referenced by tests.

Local workflow after adding sources:
- flutter pub get
- dart format .
- dart analyze .
- dart fix --apply
- flutter test

Notes:
- The current analyzer failures are due to missing `lib/` application sources referenced by tests (out of scope for the formatting phase).
- Keep imports as full package paths (e.g., package:preference_frontend/...).
- Prefer const constructors and follow Effective Dart.
