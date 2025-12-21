# Testing Guide

## Analyze and Format
Run format and analyzer to ensure code quality:

```
dart format .
dart analyze
```

## Unit/Widget Tests
```
flutter test
```

## Integration Test for Screenshots
With a device connected:

Option A:
```
flutter test integration_test --device <device_id>
```

Option B:
```
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/screenshot_navigation_test.dart
```

Screenshots will be written to:
```
assets/screenshots/
```
