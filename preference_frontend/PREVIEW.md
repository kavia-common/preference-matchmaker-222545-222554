# Preference App — Visual Preview and Polish Guide

This document summarizes the current UI layout (based on code inspection) and lists visual refinements to align with the project's "Ocean Professional" style guide.

## App Structure

- MaterialApp (light theme), bottom navigation with four tabs:
  - Home (swipe/home placeholder)
  - Matches
  - Chat
  - Profile
- FilterScreen available for setting `FilterCriteria` via `FilterProvider`.

## Screens Overview

- Home:
  - AppBar with title
  - Content area (placeholder)
  - BottomNavigationBar visible

- Matches:
  - Grid/List of user cards (placeholder data)
  - Intended for modern, clean card layout

- Chat:
  - List of chat tiles (placeholder)

- Profile:
  - Profile summary/settings (placeholder tiles)

- FilterScreen:
  - Form for age range, distance, interests
  - Backed by `FilterProvider` and `FilterCriteria` model

## Style Guide Targets

Application theme: Ocean Professional
- Primary: #2563EB (Blue)
- Secondary: #F59E0B (Amber)
- Success: #F59E0B
- Error: #EF4444
- Background: #f9fafb
- Surface: #ffffff
- Text: #111827
- Gradient: from blue-500/10 to gray-50 (subtle)

Design principles:
- Modern, minimal, clean
- Subtle shadows and rounded corners
- Smooth transitions and subtle gradients
- Accessible color contrast and large touch targets

## Quick Wins for Visual Polish

1) Define a comprehensive ThemeData
- Use colorScheme with the above palette (note: ColorScheme uses `surface` instead of deprecated `background`).
- AppBarTheme: white surface, primary icons/text.
- BottomNavigationBarTheme: selectedItemColor = primary, unselectedItemColor = neutral grey.
- CardTheme: elevation 2–4, BorderRadius.circular(12).
- ElevatedButtonTheme: rounded corners (12), primary background, amber secondary for accents.
- TextTheme: ensure readable sizes and weights.

2) Consistent Layout and Spacing
- Use EdgeInsets.symmetric(horizontal: 16, vertical: 12) for common padding.
- Apply uniform card radius and elevation across Matches/Profile.

3) Accessibility
- Add semantic labels for nav items and action buttons.
- Ensure sufficient contrast (dark text on light surfaces).
- Maintain 48px minimum touch targets.

4) Motion and Transitions
- Use AnimatedSwitcher or PageView for tab transitions.
- Apply InkWell ripple with `primary.withAlpha(40)` for press feedback.

5) FilterScreen UX
- Use Slider(s) for age/distance.
- Use ChoiceChips or FilterChips for interests (accent with secondary color).
- Clear Apply CTA with primary-colored ElevatedButton.

6) Home/Swipe (Future)
- If implementing swipe cards, use a deck with rounded corners, soft shadow, and a subtle top-to-bottom gradient overlay on photos.

## Suggested Theme Scaffold (Reference)

```dart
// Example: Apply in MaterialApp theme:
// Note: Always use withAlpha() instead of withOpacity() per lint rules.

final Color primary = const Color(0xFF2563EB);
final Color secondary = const Color(0xFFF59E0B);
final Color error = const Color(0xFFEF4444);
final Color surface = const Color(0xFFFFFFFF);
final Color background = const Color(0xFFF9FAFB);
final Color textColor = const Color(0xFF111827);

ThemeData buildOceanTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: primary,
      secondary: secondary,
      error: error,
      surface: surface,
      // Avoid deprecated fields; use surface + scaffoldBackgroundColor.
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF111827),
      elevation: 0.5,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey[600],
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),
    cardTheme: CardTheme(
      color: surface,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
    useMaterial3: false,
  );
}
```

## Known Gaps (from current code state)

- Default Material theme appears to be used; custom theme not fully applied.
- Placeholder content across screens; cards and lists could better reflect final design.
- No explicit animations/transitions between tabs or on interactions.
- Filter UI could be more expressive (chips, sliders) and aligned with accent colors.

## Proposed Next Steps

- Implement `buildOceanTheme()` and wire it in `MaterialApp(theme: buildOceanTheme(), ...)`.
- Standardize reusable widgets for:
  - Primary CTA button
  - Profile card (rounded corners, image, gradient overlay, name/age, chips)
  - Section header with consistent typography
- Add basic AnimatedSwitcher between tabs.
- Upgrade FilterScreen UI with sliders and chips using primary/secondary colors.
- Confirm accessibility via larger hit targets and color contrast checks.

---

This PREVIEW.md is intended as a quick reference for designers and developers to align on visual direction and implement consistent styling rapidly.
