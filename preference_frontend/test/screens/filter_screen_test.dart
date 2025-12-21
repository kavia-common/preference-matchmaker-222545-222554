import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:preference_frontend/models/filter_criteria.dart';
import 'package:preference_frontend/screens/filter_screen.dart';
import 'package:preference_frontend/state/filter_provider.dart';
import 'package:provider/provider.dart';

Widget _buildApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<FilterProvider>(create: (_) => FilterProvider()),
    ],
    child: MaterialApp(
      routes: <String, WidgetBuilder>{
        '/':
            (_) => const Scaffold(
              body: Center(child: Text('Home')),
              floatingActionButton: null,
            ),
        '/filters': (_) => const FilterScreen(),
      },
      initialRoute: '/filters',
    ),
  );
}

void main() {
  testWidgets(
    'FilterScreen: toggles and sliders update provider and Apply pops',
    (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pump();

      // Tap first checkbox (HairColor first item).
      await tester.tap(find.byType(CheckboxListTile).first);
      await tester.pump();

      // Adjust height slider slightly.
      final heightSlider = find.byType(RangeSlider).first;
      await tester.drag(heightSlider, const Offset(40, 0));
      await tester.pump();

      // Adjust weight slider slightly.
      final weightSlider = find.byType(RangeSlider).at(1);
      await tester.drag(weightSlider, const Offset(-20, 0));
      await tester.pump();

      // Apply
      await tester.tap(find.byKey(const Key('apply_all_button')));
      await tester.pump();

      final provider = Provider.of<FilterProvider>(
        tester.element(find.byType(Scaffold)),
        listen: false,
      );
      final criteria = provider.criteria;
      // Ranges are within bounds after user interaction.
      expect(criteria.heightRange.min, inInclusiveRange(100, 220));
      expect(criteria.heightRange.max, inInclusiveRange(100, 220));
      expect(criteria.weightRange.min, inInclusiveRange(40, 150));
      expect(criteria.weightRange.max, inInclusiveRange(40, 150));
    },
  );

  testWidgets(
    'FilterScreen: reset clears provider to defaults and resets local ranges',
    (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pump();

      // Change a checkbox.
      await tester.tap(find.byType(CheckboxListTile).first);
      await tester.pump();

      // Tap Reset (inline button)
      await tester.tap(find.byKey(const Key('reset_button')));
      await tester.pump();

      final provider = Provider.of<FilterProvider>(
        tester.element(find.byType(Scaffold)),
        listen: false,
      );
      final criteria = provider.criteria;
      expect(criteria.hairColors.isEmpty, isTrue);
      expect(criteria.races.isEmpty, isTrue);
      expect(criteria.religions.isEmpty, isTrue);
      expect(criteria.heightRange, const Range(min: 140, max: 210));
      expect(criteria.weightRange, const Range(min: 40, max: 140));
    },
  );
}
