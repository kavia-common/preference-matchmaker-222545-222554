# Screenshot Generation (Integration Tests)

This project includes an integration test that navigates across the main tabs (Home, Matches, Chat, Profile) and the Filter screen, capturing screenshots for each.

Output files are saved under:
- assets/screenshots/home.png
- assets/screenshots/matches.png
- assets/screenshots/chat.png
- assets/screenshots/profile.png
- assets/screenshots/filter.png

## Prerequisites
- A connected device or running emulator/simulator.
- Flutter SDK installed.

## Commands

Option A: Run with `flutter test` (recommended for CI):
```
flutter test integration_test --device <device_id>
```

To list devices:
```
flutter devices
```

Option B: Run with `flutter drive` (alternative):
```
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/screenshot_navigation_test.dart
```

After running, verify the `assets/screenshots/` directory contains updated PNG files.

## Notes
- The integration test uses `IntegrationTestWidgetsFlutterBinding.takeScreenshot` and also writes the images directly to `assets/screenshots/`.
- Ensure the `assets` folder is properly declared in `pubspec.yaml` if your app needs to reference the images at runtime.
