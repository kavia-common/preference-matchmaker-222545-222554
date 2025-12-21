Preference Frontend - Dependency Update Report

Date: 2025-12-21

Environment
- Flutter: 3.29.1
- Dart: 3.7.0

Updated direct dependencies
- flutter_dotenv: 5.1.0 -> 6.0.0
- provider: 6.1.1 -> 6.1.2
- sqflite: 2.3.2 -> 2.4.2
- shared_preferences: 2.2.2 -> 2.5.3 (held; 2.5.4 requires Dart >=3.9.0, current SDK 3.7.0)
- intl: 0.19.0 -> 0.20.2
- path: (unchanged) 1.9.0
- flutter_staggered_grid_view: (unchanged) 0.7.0
- cupertino_icons: (unchanged) 1.0.8

Updated dev dependencies
- flutter_lints: (held) 5.0.0 (v6.0.0 requires Dart >=3.8.0; current SDK is 3.7.0)
- build_runner: (unchanged) 2.4.13
- mocktail: (unchanged) 1.0.4
- flutter_test: SDK (no version change)

Analyzer status
- Before: No issues
- After: No new issues detected

Notes and follow-ups
- Some transitive packages have newer versions (e.g., analyzer, lints, vector_math, etc.). They are constrained by current direct dependency constraints and SDK; they will be updated indirectly as constraints allow.
- No app feature changes were made.
