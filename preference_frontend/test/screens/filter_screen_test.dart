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
        '/': (_) => const Scaffold(
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
  testWidgets('FilterScreen: enter values and save updates provider', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();

    // Enter height and weight values.
    await tester.enterText(find.byKey(const Key('min_height_field')), '165');
    await tester.enterText(find.byKey(const Key('max_height_field')), '185');
    await tester.enterText(find.byKey(const Key('min_weight_field')), '55');
    await tester.enterText(find.byKey(const Key('max_weight_field')), '80');

    // Select race.
    await tester.tap(find.byKey(const Key('race_dropdown')));
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
    await tester.tap(find.text(Race.white.name).last);
    await tester.pump();

    // Select hair color.
    await tester.tap(find.byKey(const Key('hair_dropdown')));
    await tester.pumpAndSettle(const Duration(milliseconds: 200));
    await tester.tap(find.text(HairColor.brown.name).last);
    await tester.pump();

    // Save.
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pump(); // allow maybePop to occur

    // Verify provider updated.
    final provider = tester.widget<MaterialApp>(find.byType(MaterialApp)).navigatorKey == null
        ? Provider.of<FilterProvider>(tester.element(find.byType(Scaffold)), listen: false)
        : Provider.of<FilterProvider>(tester.element(find.byType(MaterialApp)), listen: false);

    final criteria = provider.criteria;
    expect(criteria.heightRange.min, 165);
    expect(criteria.heightRange.max, 185);
    expect(criteria.weightRange.min, 55);
    expect(criteria.weightRange.max, 80);
    expect(criteria.race, Race.white);
    expect(criteria.hairColor, HairColor.brown);
  });

  testWidgets('FilterScreen: reset clears local inputs and provider', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();

    await tester.enterText(find.byKey(const Key('min_height_field')), '170');
    await tester.enterText(find.byKey(const Key('max_height_field')), '182');

    await tester.tap(find.byKey(const Key('reset_button')));
    await tester.pump();

    // After reset, provider should be back to defaults.
    final provider = Provider.of<FilterProvider>(tester.element(find.byType(Scaffold)), listen: false);
    expect(provider.criteria, const FilterCriteria());
  });
}
