import 'package:flutter_test/flutter_test.dart';
import 'package:preference_frontend/main.dart';

void main() {
  testWidgets('smoke: app builds without exceptions', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
  });
}
