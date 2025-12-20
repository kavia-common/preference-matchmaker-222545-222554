# Preference – Flutter Mobile App

This is the Preference mobile app (Flutter) implementing the initial UI scaffolding with the Ocean Professional style.

## Features (initial)
- Material 3 Ocean Professional Theme:
  - primary #2563EB, secondary/success #F59E0B, error #EF4444
  - background #f9fafb, surface #ffffff, text #111827
- Bottom navigation with 4 tabs:
  - Home (swipe-style stacked profile cards placeholder)
  - Matches (grid of match cards)
  - Chat (list of conversations)
  - Profile (user summary and settings placeholders)
- Reusable widgets: ProfileCard, MatchCard, ChatListItem, PrimaryButton, AccentChip
- Mock data models so the app runs without external services
- Filter models and provider, plus a minimal Filter screen for tests

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
  - state/filter_provider.dart
  - screens/ (home, matches, chat, profile, filter)
  - widgets/ (primary_button, accent_chip, profile_card, match_card, chat_list_item)

Notes:
- No external service calls are made; all data is stubbed/mocked.
- The app uses only standard Flutter/Provider already included in pubspec.
