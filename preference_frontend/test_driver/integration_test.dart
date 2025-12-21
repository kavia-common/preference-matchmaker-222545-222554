import 'package:integration_test/integration_test_driver.dart' as driver;

// PUBLIC_INTERFACE
Future<void> main() async {
  /** Integration test driver entrypoint for flutter drive.
   * Allows running:
   *   flutter drive --driver=test_driver/integration_test.dart --target=integration_test/screenshot_navigation_test.dart
   */
  await driver.integrationDriver();
}
