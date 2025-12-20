import 'package:flutter_test/flutter_test.dart';
import 'package:preference_frontend/models/filter_criteria.dart';
import 'package:preference_frontend/state/filter_provider.dart';

void main() {
  group('FilterProvider', () {
    test('initial criteria is default; setters and toggles notify', () {
      final provider = FilterProvider();
      int notifyCount = 0;
      provider.addListener(() {
        notifyCount += 1;
      });

      expect(provider.criteria, const FilterCriteria());

      final newCriteria = const FilterCriteria(
        heightRange: Range(min: 160, max: 190),
        weightRange: Range(min: 50, max: 90),
        races: <Race>{Race.asian},
        hairColors: <HairColor>{HairColor.black},
        religions: <Religion>{Religion.christianity},
      );
      provider.setCriteria(newCriteria);

      expect(provider.criteria, newCriteria);
      expect(notifyCount, 1);

      // Toggle a hair color on.
      provider.toggleHairColor(HairColor.blonde, selected: true);
      expect(provider.criteria.hairColors.contains(HairColor.blonde), isTrue);
      expect(notifyCount, 2);

      // Toggle race off.
      provider.toggleRace(Race.asian, selected: false);
      expect(provider.criteria.races.contains(Race.asian), isFalse);
      expect(notifyCount, 3);

      // Update ranges via Range objects.
      provider.updateHeightRange(const Range(min: 150.0, max: 200.0));
      expect(provider.criteria.heightRange, const Range(min: 150.0, max: 200.0));
      expect(notifyCount, 4);

      provider.updateWeightRange(const Range(min: 60.0, max: 100.0));
      expect(provider.criteria.weightRange, const Range(min: 60.0, max: 100.0));
      expect(notifyCount, 5);

      // Reset
      provider.reset();
      expect(provider.criteria, const FilterCriteria());
      expect(notifyCount, 6);
    });
  });
}
