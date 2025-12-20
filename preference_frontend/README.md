# Preference – Flutter Mobile App

This is the Preference mobile app (Flutter) implementing the initial UI scaffolding with the Ocean Professional style.

## Features
- Material 3 Ocean Professional Theme:
  - primary #2563EB, secondary/success #F59E0B, error #EF4444
  - background #f9fafb, surface #ffffff, text #111827
- Bottom navigation with 4 tabs:
  - Home (swipe-style stacked profile cards placeholder)
  - Matches (grid of match cards, with Filters FAB)
  - Chat (list of conversations)
  - Profile (user summary and settings placeholders)
- Reusable widgets: ProfileCard, MatchCard, ChatListItem, PrimaryButton, AccentChip
- Mock data models so the app runs without external services
- Comprehensive Filters:
  - Checkbox groups for Hair Color, Religion, Ethnicity
  - RangeSliders for Height (100–220 cm) and Weight (40–150 kg)
  - Apply All button (persistent bottom bar) and Reset action
  - Provider-based state (FilterProvider) with copyWith/equality on FilterCriteria
  - Local persistence: Filter selections are stored on device using SharedPreferences and restored on app start.

## Run locally
1. Install Flutter (see https://docs.flutter.dev/get-started/install)
2. Get packages:
   - flutter pub get
3. Run on a device or emulator:
   - flutter run

## Project structure
- lib/
  - main.dart (entrypoint + bottom nav)
  - theme/app_theme.dart
  - models/ (profile, conversation, filter_criteria)
  - state/filter_provider.dart, state/filter_persistence.dart
  - screens/ (home, matches, chat, profile, filter)
  - widgets/ (primary_button, accent_chip, profile_card, match_card, chat_list_item)

### Filters navigation
- From Matches tab, tap the "Filters" FAB to open the Filter screen.
- Adjust checkboxes and ranges, then tap "Apply All" to apply and dismiss.
- Use "Reset" (AppBar or the inline button) to clear selections to defaults.

Notes:
- Filter selections are persisted locally under the key `filter_criteria`. If persistence data is missing or malformed, defaults are used automatically.
- No external service calls are made; all data is stubbed/mocked.
- The app uses only standard Flutter/Provider already included in pubspec.
