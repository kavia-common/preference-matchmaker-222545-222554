# Next Agent Checklist — Resolve Analyzer Errors

Goal: Implement minimal lib/ sources referenced by tests to clear analyzer errors, then re-run analysis/tests.

1) Implement missing files under lib/
   - lib/main.dart
     - Expose: class MyApp (StatelessWidget) and optionally MyHomePage
     - AppBar title should include text 'preference_frontend' (as asserted)
     - Home body should include 'preference_frontend App is being generated...' text and a CircularProgressIndicator
   - lib/models/filter_criteria.dart
     - Expose:
       - class Range { final double min; final double max; const Range({required this.min, required this.max}); }
       - enum Race, enum HairColor, enum Religion (include some values: asian/black/white/etc., blonde/black/etc., christianity/islam/etc.)
       - class FilterCriteria with:
         - const defaults: heightRange: Range(140, 210); weightRange: Range(40, 140)
         - Set<Race> races, Set<HairColor> hairColors, Set<Religion> religions
         - copyWith, ==, hashCode
   - lib/state/filter_provider.dart
     - Expose: class FilterProvider extends ChangeNotifier
     - Holds FilterCriteria criteria (default const FilterCriteria())
     - Methods used by tests:
       - void setCriteria(FilterCriteria v)
       - void toggleHairColor(HairColor color, {required bool selected})
       - void toggleRace(Race race, {required bool selected})
       - void updateHeightRange(Range r)
       - void updateWeightRange(Range r)
       - void reset()
   - lib/screens/filter_screen.dart
     - Expose: class FilterScreen extends StatelessWidget
     - UI includes:
       - CheckboxListTile groups (HairColor at least first) to allow .first tap
       - Two RangeSlider widgets (height 100–220; weight 40–150 preferred)
       - Apply All button with Key('apply_all_button') that Navigator.pop(context)
       - Reset button with Key('reset_button') that calls provider.reset()

2) Keep imports as full package paths
   - package:preference_frontend/...

3) Lints and style
   - Use const constructors where possible
   - Follow Effective Dart naming
   - Avoid using BuildContext across async gaps

4) Commands to run after implementation
   - flutter pub get
   - dart format .
   - dart analyze .
   - dart fix --apply
   - flutter test

5) Artifact updates
   - Update analysis/POST_FIX_ANALYZE_SUMMARY.txt with the new analyzer results
   - Optionally prune older CI snapshots after the build turns green

6) Out-of-scope note for this task
   - The previous task executed formatting and safe fixes only and intentionally did not create lib/ app sources.
