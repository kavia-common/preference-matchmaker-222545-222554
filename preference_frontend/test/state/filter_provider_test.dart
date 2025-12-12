import 'package:flutter_test/flutter_test.dart';
import 'package:preference_frontend/models/filter_criteria.dart';
import 'package:preference_frontend/state/filter_provider.dart';

void main() {
  group('FilterProvider', () {
    test('initial criteria is default and setters update with notify', () {
      final provider = FilterProvider();
      int notifyCount = 0;
      provider.addListener(() {
        notifyCount += 1;
      });

      expect(provider.criteria, const FilterCriteria());

      final newCriteria = const FilterCriteria(
        heightRange: Range(min: 160, max: 190),
        weightRange: Range(min: 50, max: 90),
        race: Race.asian,
        hairColor: HairColor.black,
      );
      provider.setCriteria(newCriteria);

      expect(provider.criteria, newCriteria);
      expect(notifyCount, 1);

      // Update a single field helper.
      provider.updateHairColor(HairColor.blonde);
      expect(provider.criteria.hairColor, HairColor.blonde);
      expect(notifyCount, 2);

      // Reset
      provider.reset();
      expect(provider.criteria, const FilterCriteria());
      expect(notifyCount, 3);
    });
  });
}
