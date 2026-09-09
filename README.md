# Flutter UI Template

> **Enterprise-grade Flutter design system built from the Mobile App UI Consistency Guide v2.0.**  
> Every spacing value, color token, component size, and interaction rule traces back to the PDF specification or is clearly marked as an engineering decision.

---

## Table of Contents

1. [What This Template Is](#1-what-this-template-is)
2. [Why It Exists](#2-why-it-exists)
3. [Design Principles](#3-design-principles)
4. [Design Tokens](#4-design-tokens)
5. [Folder Structure](#5-folder-structure)
6. [How to Use the Theme](#6-how-to-use-the-theme)
7. [How to Use Reusable Components](#7-how-to-use-reusable-components)
8. [How to Add a New Component](#8-how-to-add-a-new-component)
9. [Responsive Behavior](#9-responsive-behavior)
10. [Accessibility](#10-accessibility)
11. [Motion & Animation](#11-motion--animation)
12. [Customization Guide](#12-customization-guide)
13. [Quick Start — New Project](#13-quick-start--new-project)
14. [Running & Testing](#14-running--testing)
15. [PDF Coverage Reference](#15-pdf-coverage-reference)
16. [Implementation Decisions](#16-implementation-decisions)

---

## 1. What This Template Is

A **reusable Flutter UI design system** that implements the *Mobile App UI Consistency Guide v2.0* as runnable Dart/Flutter code.

It is **not** an application. It is a component library and visual showcase that you clone, adapt, and build your actual application on top of.

### What's included

| Layer | Files |
|---|---|
| Design tokens | `AppColors`, `AppSpacing`, `AppTypography`, `AppRadius`, `AppShadows`, `AppMotion` |
| Theme | `AppTheme.light()` / `AppTheme.dark()` |
| Constants | `AppConstants` — touch targets, heights, z-index, sizes |
| Responsive | `ResponsiveLayout`, `ResponsiveConstrainedBox` |
| Accessibility | `AccessibilityHelpers`, `MinTouchTarget`, `FocusOutline` |
| Widgets (12) | Button, TextField, Card, ListTile, Divider, Badge, BottomNav, Dialog, BottomSheet, Toast, EmptyState, Skeleton, Loading, ErrorState, Avatar, ScreenLayout |
| Showcase | Visual demo of every token and component |
| Tests | Token values, widget states, touch targets, responsive breakpoints, WCAG contrast |

---

## 2. Why It Exists

Design systems fail when the gap between design specs and code widens over time. This template closes that gap by:

- Encoding every PDF spec value as a named constant — no magic numbers.
- Annotating every value with its PDF section and token name.
- Clearly separating **design-system constants** (keep consistent) from **project-specific values** (replace per app).
- Providing a visual Showcase screen so every value can be validated at a glance.

---

## 3. Design Principles

All rules come directly from **Mobile App UI Consistency Guide v2.0**:

| Rule | Source |
|---|---|
| 8pt spacing grid (4pt for icons only) | PDF §1 |
| Every typography style includes line-height | PDF §2 |
| Minimum readable font size: 12pt | PDF §2 |
| WCAG AA contrast (4.5:1 body, 3:1 large text) | PDF §3 |
| Minimum touch target 44×44pt | PDF §4 |
| Defined elevation scale (0–4), never ad-hoc | PDF §5 |
| All component states: default, pressed, disabled, loading | PDF §7 |
| Screen layout: SafeArea + fixed header + scroll + footer | PDF §8 |
| Responsive breakpoints (mobile / mobile-large / tablet) | PDF §9 |
| Reduce Motion support | PDF §10 |
| Screen reader labels on all interactive elements | PDF §11 |

---

## 4. Design Tokens

### Spacing (`AppSpacing`) — PDF §1

```dart
AppSpacing.xxs  // 4pt  — icon micro-gaps only
AppSpacing.xs   // 8pt  — small gaps, button padding
AppSpacing.sm   // 16pt — card padding, element gaps
AppSpacing.md   // 24pt — section spacing
AppSpacing.lg   // 32pt — screen margins
AppSpacing.xl   // 48pt — major breaks, empty states
```

### Colors (`AppColors`) — PDF §3

```dart
// 🎨 PROJECT-SPECIFIC (brand colors)
AppColors.primary       // #0066CC
AppColors.secondary     // #6B7280

// 🔒 DESIGN SYSTEM (semantic)
AppColors.error         // #DC2626
AppColors.success       // #059669
AppColors.warning       // #D97706
AppColors.background    // #FFFFFF
AppColors.surface       // #F3F4F6
AppColors.textPrimary   // #111827
AppColors.textSecondary // #6B7280
AppColors.textDisabled  // #9CA3AF
AppColors.borderDefault // #E5E7EB
AppColors.borderStrong  // #D1D5DB
AppColors.overlay       // rgba(0,0,0,0.5)
AppColors.disabledBg    // #F3F4F6
```

### Typography (`AppTypography`) — PDF §2

```dart
AppTypography.h1       // 32pt / 1.25× / w600 — screen title
AppTypography.h2       // 24pt / 1.33× / w600 — section header
AppTypography.h3       // 20pt / 1.40× / w600 — card title
AppTypography.body     // 16pt / 1.50× / w400 — primary content
AppTypography.caption  // 14pt / 1.43× / w400 — labels, metadata
AppTypography.small    // 12pt / 1.33× / w500 — badges, timestamps
```

### Radius (`AppRadius`) — PDF §15

```dart
AppRadius.sm    // 8pt  — toasts, standard cards
AppRadius.md    // 12pt — card surfaces
AppRadius.lg    // 20pt — modals, bottom sheets
AppRadius.full  // 100pt — badges, pill chips
```

### Shadows (`AppShadows`) — PDF §5

```dart
AppShadows.elevation0  // none — flat surfaces
AppShadows.elevation1  // 0 1px 2px rgba(0,0,0,0.06) — cards
AppShadows.elevation2  // 0 2px 8px rgba(0,0,0,0.08) — dropdowns
AppShadows.elevation3  // 0 4px 16px rgba(0,0,0,0.12) — modals
AppShadows.elevation4  // 0 8px 24px rgba(0,0,0,0.16) — toasts
```

### Motion (`AppMotion`) — PDF §10

```dart
AppMotion.micro             // 125ms — micro-interactions
AppMotion.screenTransition  // 350ms — screen transitions
AppMotion.modal             // 300ms — modals/sheets

AppMotion.standard          // cubic-bezier(0.4, 0, 0.2, 1)
AppMotion.decelerate        // cubic-bezier(0, 0, 0.2, 1) — entering
AppMotion.accelerate        // cubic-bezier(0.4, 0, 1, 1) — exiting

// Reduce Motion check
AppMotion.shouldReduceMotion(context)  // → bool
```

---

## 5. Folder Structure

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart       ← Color tokens (PDF §3)
│   │   ├── app_spacing.dart      ← Spacing scale (PDF §1)
│   │   ├── app_typography.dart   ← Type scale (PDF §2)
│   │   ├── app_radius.dart       ← Corner radii (PDF §15)
│   │   ├── app_shadows.dart      ← Elevation shadows (PDF §5)
│   │   ├── app_motion.dart       ← Duration & easing (PDF §10)
│   │   └── app_theme.dart        ← ThemeData factory
│   │
│   ├── constants/
│   │   └── app_constants.dart    ← Touch targets, heights, z-index
│   │
│   ├── responsive/
│   │   └── responsive.dart       ← Breakpoints, layout helpers (PDF §9)
│   │
│   ├── accessibility/
│   │   └── accessibility_helpers.dart  ← WCAG, touch target, focus (PDF §11)
│   │
│   └── widgets/
│       ├── app_button.dart           ← PDF §7.1
│       ├── app_text_field.dart       ← PDF §7.2
│       ├── app_card.dart             ← PDF §7.3
│       ├── app_list_tile.dart        ← PDF §7.4
│       ├── app_divider.dart          ← PDF §7.5
│       ├── app_badge.dart            ← PDF §7.6
│       ├── app_bottom_navigation.dart ← PDF §7.7
│       ├── app_dialog.dart           ← PDF §7.8
│       ├── app_bottom_sheet.dart     ← PDF §7.8
│       ├── app_snackbar.dart         ← PDF §7.9
│       ├── app_empty_state.dart      ← PDF §7.10
│       ├── app_skeleton.dart         ← PDF §7.11
│       ├── app_loading.dart          ← Engineering addition
│       ├── app_error_state.dart      ← Engineering addition
│       ├── app_avatar.dart           ← PDF §7.12
│       └── app_screen_layout.dart    ← PDF §8
│
├── features/
│   └── showcase/
│       └── presentation/
│           ├── showcase_screen.dart     ← Visual component gallery
│           ├── showcase_section.dart    ← Section wrapper widget
│           └── sections/               ← One file per showcase section
│
└── main.dart
```

---

## 6. How to Use the Theme

### Wire up in `main.dart`

```dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/my_app/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',         // 🎨 PROJECT-SPECIFIC
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),  // ⚙️ OPTIONAL
      themeMode: ThemeMode.system, // ⚙️ OPTIONAL
      home: const HomeScreen(),    // 🎨 PROJECT-SPECIFIC
    );
  }
}
```

### Access theme values in widgets

All standard Flutter theme values are wired from the tokens automatically:

```dart
// Prefer direct token references for precision:
Container(color: AppColors.surface)
Text('Hello', style: AppTypography.h2)
SizedBox(height: AppSpacing.md)

// Or use Theme.of(context) for Material integration:
Theme.of(context).colorScheme.primary   // → AppColors.primary
Theme.of(context).textTheme.bodyLarge   // → AppTypography.body
```

---

## 7. How to Use Reusable Components

### AppButton

```dart
// Primary large (48pt, full-width)
AppButton(
  label: 'Save Changes',
  onPressed: () => _save(),
)

// Secondary small (40pt)
AppButton(
  label: 'Cancel',
  onPressed: () => Navigator.pop(context),
  variant: AppButtonVariant.secondary,
  size: AppButtonSize.small,
)

// Loading state — keeps background, shows spinner, blocks taps
AppButton(
  label: 'Saving...',
  onPressed: null,
  isLoading: _isSaving,
)

// Not full-width, with icon
AppButton(
  label: 'Add Item',
  onPressed: () {},
  isFullWidth: false,
  leadingIcon: const Icon(Icons.add),
)
```

### AppTextField

```dart
// Default
AppTextField(
  label: 'Email',
  hint: 'your@email.com',
  onChanged: (v) => setState(() => _email = v),
)

// Error state
AppTextField(
  label: 'Username',
  errorText: _usernameError,  // null = no error
)

// Disabled
AppTextField(
  label: 'Account ID',
  isEnabled: false,
)

// Password with toggle
AppPasswordField(label: 'Password')
```

### AppCard

```dart
// Static card
AppCard(
  child: Text('Content', style: AppTypography.body),
)

// Pressable card (bg darkens 4–6% on press)
AppCard(
  onTap: () => _openDetail(),
  semanticLabel: 'Open article',
  child: Row(children: [/* ... */]),
)
```

### AppScreenLayout

```dart
AppScreenLayout(
  header: Text('My Screen', style: AppTypography.h3),
  footer: AppButton(label: 'Continue', onPressed: () {}),
  body: Column(
    children: [
      // Your screen content — auto 16pt horizontal padding
    ],
  ),
)
```

### Showing a toast

```dart
showAppToast(
  context,
  message: 'Profile saved',
  variant: AppToastVariant.success,
)
```

### Showing a dialog

```dart
showAppDialog(
  context: context,
  dialog: AppDialog(
    title: 'Confirm Delete',
    content: const Text('This cannot be undone.'),
    primaryLabel: 'Delete',
    primaryAction: () { _delete(); Navigator.pop(context); },
    secondaryLabel: 'Cancel',
    secondaryAction: () => Navigator.pop(context),
  ),
)
```

### Showing a bottom sheet

```dart
showAppBottomSheet(
  context: context,
  sheet: AppBottomSheet(
    title: 'Options',
    child: Column(children: [/* list items */]),
  ),
)
```

### Skeletons

```dart
// Wrap related skeletons in a single ShimmerScope
ShimmerScope(
  child: Column(
    children: [
      SkeletonCard(),
      SkeletonListTile(showSubtitle: true),
      SkeletonParagraph(lines: 3),
    ],
  ),
)
```

### Responsive helpers

```dart
// Check current breakpoint
final isTablet = ResponsiveLayout.isTablet(context);

// Resolve a value per breakpoint
final columns = ResponsiveLayout.resolve(
  context,
  mobile: 1,
  tablet: 2,
);

// Constrain content width on tablet (caps at 640pt)
ResponsiveConstrainedBox(
  child: MyFormWidget(),
)
```

---

## 8. How to Add a New Component

1. **Create** `lib/core/widgets/app_my_widget.dart`.
2. **Reference tokens only** — no raw hex values, no hard-coded sizes:
   ```dart
   // ✅ Correct
   color: AppColors.primary
   height: AppConstants.minButtonHeight
   padding: EdgeInsets.all(AppSpacing.sm)

   // ❌ Wrong
   color: Color(0xFF0066CC)
   height: 48
   padding: EdgeInsets.all(16)
   ```
3. **Add all required states** if interactive: default, pressed, disabled, loading (PDF §13 Golden Rules).
4. **Ensure 44pt touch target** for any tappable element (use `MinTouchTarget` widget if needed).
5. **Add semantic labels** for screen readers.
6. **Add to showcase**: create a new section file in `lib/features/showcase/presentation/sections/` and add it to `ShowcaseScreen._buildSections()`.
7. **Write tests** in `test/core/widgets/`.
8. **Add any new token** to the shared token files — never create a one-off value inside a widget.

---

## 9. Responsive Behavior

From **PDF §9**:

| Breakpoint | Range | Reference device |
|---|---|---|
| `mobile` | 0–375pt | iPhone SE |
| `mobileLarge` | 376–428pt | iPhone Pro |
| `tablet` | 429–1024pt | iPad |

**Rules enforced:**

- Use `MediaQuery` / `LayoutBuilder` — never fixed screen dimensions.
- Cap content width at 640pt on tablet (`ResponsiveConstrainedBox`).
- Never let forms span full tablet width.
- Prefer centered single-column or two-column layout on tablet.

```dart
// Check breakpoint
ResponsiveLayout.breakpointOf(context)  // → AppBreakpoint

// Adaptive value
final padding = ResponsiveLayout.resolve(
  context,
  mobile: AppSpacing.sm,
  tablet: AppSpacing.md,
);

// Auto-constrain on tablet
ResponsiveConstrainedBox(child: MyForm())
```

---

## 10. Accessibility

From **PDF §11**:

| Requirement | Implementation |
|---|---|
| Dynamic Type — do NOT disable font scaling | `textScaleFactor` from `MediaQuery` is never overridden |
| Screen reader labels — all interactive elements | `Semantics(label: ...)` on every tappable widget |
| Icon-only buttons need labels | `SemanticIconButton(semanticLabel: '...')` |
| Reduce Motion fallback | `AppMotion.shouldReduceMotion(context)` → opacity-only transition |
| WCAG AA contrast 4.5:1 body, 3:1 large text | `AccessibilityHelpers.meetsWcagAABody(fg, bg)` |
| Visible focus state (border-strong, 2pt) | `FocusOutline` widget |
| Minimum touch target 44×44pt | `MinTouchTarget` widget, `AppConstants.minTouchTarget` |

```dart
// Enforce 44pt touch area around a small icon
MinTouchTarget(
  semanticLabel: 'Close',
  onTap: () => Navigator.pop(context),
  child: Icon(Icons.close, size: 20),
)

// Check WCAG contrast at runtime
final passes = AccessibilityHelpers.meetsWcagAABody(
  AppColors.textSecondary,
  AppColors.surface,
);
// ⚠️ PDF flags text-secondary on surface as a common failure point.
```

---

## 11. Motion & Animation

From **PDF §10**:

```dart
// Duration constants
AppMotion.micro             // 125ms — hover, toggle
AppMotion.screenTransition  // 350ms — route changes
AppMotion.modal             // 300ms — dialog/sheet

// Easing curves
AppMotion.standard    // cubic-bezier(0.4, 0, 0.2, 1)
AppMotion.decelerate  // entering elements
AppMotion.accelerate  // exiting elements

// In an AnimatedContainer:
AnimatedContainer(
  duration: AppMotion.micro,
  curve: AppMotion.standard,
  color: _pressed ? AppColors.primaryPressed : AppColors.primary,
)

// Reduce Motion guard:
final duration = AppMotion.shouldReduceMotion(context)
    ? const Duration(milliseconds: 150)
    : AppMotion.screenTransition;
```

---

## 12. Customization Guide

### Annotation convention used throughout the codebase

```
🔒 DESIGN SYSTEM — KEEP CONSISTENT
   Value from the PDF. Change only if the guide is updated.

🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
   Replace with your application's brand values.

⚙️ OPTIONAL — CONFIGURE IF NEEDED
   Engineering addition. Enable or disable as needed.
```

---

### What MUST be changed for a new project

| File | What to change | Annotation |
|---|---|---|
| `lib/core/theme/app_colors.dart` | `AppColors.primary` and `AppColors.secondary` | `🎨 PROJECT-SPECIFIC` |
| `lib/core/theme/app_typography.dart` | `AppTypography.fontFamily` (set your brand typeface) | `🎨 PROJECT-SPECIFIC` |
| `lib/core/constants/app_constants.dart` | `AppConstants.appName`, `AppConstants.appVersion` | `🎨 PROJECT-SPECIFIC` |
| `lib/main.dart` | `title`, `home` widget | `🎨 PROJECT-SPECIFIC` |
| `pubspec.yaml` | `name`, `description`, add custom fonts/assets | — |

---

### What CAN be changed (optional)

| File | What to change | Annotation |
|---|---|---|
| `lib/core/theme/app_colors.dart` | Dark mode colors (`darkBackground`, etc.) | `⚙️ OPTIONAL` |
| `lib/main.dart` | `themeMode` (system / light / dark) | `⚙️ OPTIONAL` |
| `lib/core/constants/app_constants.dart` | `maxContentWidth` (640pt — within PDF 600–680 range) | `⚙️ OPTIONAL` |

---

### What should REMAIN unchanged

- All spacing token values (`AppSpacing.*`)
- All typography sizes, line-heights, weights
- All semantic color tokens (error, success, warning)
- All touch target minimums
- All elevation shadow specs
- All component height values (48pt buttons, 56pt list items, etc.)
- All animation durations and easing curves

---

### How to introduce project-specific design tokens

If your project needs a color or size not in the PDF:

1. Add it to the relevant token file with a `🎨 PROJECT-SPECIFIC` comment.
2. Document which brand guideline defines it.
3. Never create a one-off raw value inside a widget file.

```dart
// In app_colors.dart — project extension:
// 🎨 PROJECT-SPECIFIC — brand gradient start color
static const Color brandGradientStart = Color(0xFF...');
```

---

### Where to put assets (logos, illustrations)

```
assets/
  images/
    logo.png              ← 🎨 PROJECT-SPECIFIC
    empty_state_inbox.svg ← 🎨 PROJECT-SPECIFIC per feature
  fonts/
    Inter-Regular.ttf     ← 🎨 PROJECT-SPECIFIC
    Inter-SemiBold.ttf
```

Register in `pubspec.yaml` and update `AppTypography.fontFamily`.

---

## 13. Quick Start — New Project

```bash
# 1. Clone or copy this template
git clone https://github.com/your-org/flutter_ui_template.git my_new_app
cd my_new_app

# 2. Update pubspec.yaml
#    - Change name: my_new_app
#    - Update description
#    - Add your font assets if needed

# 3. Set your brand colors
#    Open lib/core/theme/app_colors.dart
#    Update AppColors.primary and AppColors.secondary

# 4. Set your font family
#    Open lib/core/theme/app_typography.dart
#    Update AppTypography.fontFamily = 'YourFont'
#    Register font in pubspec.yaml

# 5. Set app name and version
#    Open lib/core/constants/app_constants.dart
#    Update appName and appVersion

# 6. Replace the home screen
#    Open lib/main.dart
#    Replace ShowcaseScreen() with your app's home screen

# 7. Run
flutter pub get
flutter run

# 8. Verify the Showcase still works (regression check)
#    Temporarily set home: const ShowcaseScreen()
#    Confirm all design tokens render correctly
```

---

## 14. Running & Testing

### Run the app

```bash
flutter pub get
flutter run
```

The app launches the Showcase screen — a scrollable visual library of every design token and component.

### Analyze

```bash
flutter analyze --no-pub
```

### Run all tests

```bash
flutter test
```

### Run a specific test file

```bash
flutter test test/core/theme/app_tokens_test.dart
flutter test test/core/widgets/app_button_test.dart
flutter test test/core/responsive/responsive_test.dart
```

### Test coverage

| Test file | What it covers |
|---|---|
| `app_tokens_test.dart` | All spacing, color, typography, radius, shadow, motion, constant values |
| `app_button_test.dart` | Rendering, touch targets, disabled/loading states, semantics, callback |
| `app_text_field_test.dart` | Rendering, disabled state, input interaction, obscure, password toggle |
| `app_card_test.dart` | Rendering, pressable tap, semantics |
| `app_avatar_test.dart` | All 5 sizes, initials, fallback icon, tap, semantics |
| `responsive_test.dart` | All breakpoints, isTablet, contentMaxWidth cap, resolve() |
| `widget_test.dart` | App smoke test |

---

## 15. PDF Coverage Reference

| PDF Section | What's implemented |
|---|---|
| §1 Spacing (8pt grid) | `AppSpacing` — all 6 tokens, semantic aliases |
| §2 Typography | `AppTypography` — all 6 styles with exact size/line-height/weight |
| §3 Color System | `AppColors` — all 15 tokens (core + text/structural) |
| §4 Touch Targets | `AppConstants.minTouchTarget`, `MinTouchTarget`, enforced in all interactive widgets |
| §5 Elevation & Z-Index | `AppShadows` — 5 levels with exact shadow specs; `AppConstants` z-index values |
| §7.1 Buttons | `AppButton` — primary/secondary/destructive/ghost, large/small, all 4 states |
| §7.2 Inputs | `AppTextField` — 48pt height, 12pt padding, all 4 states; `AppPasswordField` |
| §7.3 Cards | `AppCard` — 16pt padding, 12pt radius, elevation-1, pressable HSL darkening |
| §7.4 List Items | `AppListTile` — 56pt single, 72pt two-line, 16pt padding |
| §7.5 Dividers | `AppDivider` — 1pt, border-default |
| §7.6 Badges/Chips | `AppBadge`, `AppChip` — 24pt, 8pt padding, pill radius |
| §7.7 Bottom Nav | `AppBottomNavigation` — 56pt bar, 44pt items |
| §7.8 Modals/Sheets | `AppDialog` (20pt radius, 16pt margin, elevation-3), `AppBottomSheet` |
| §7.9 Toasts | `showAppToast` — 8pt radius, elevation-4, 3s dismiss, swipe |
| §7.10 Empty States | `AppEmptyState` — 48pt padding, centered, icon+title+body+CTA |
| §7.11 Skeletons | `ShimmerScope`, `SkeletonCard/ListTile/Paragraph` — content-matching shapes |
| §7.12 Icons/Avatars | `AppAvatar` — 5 sizes; icon size constants |
| §8 Screen Layout | `AppScreenLayout` — SafeArea, 56pt header, 16pt padding, 56pt footer |
| §9 Responsive | `ResponsiveLayout`, breakpoints, content cap at 640pt |
| §10 Motion | `AppMotion` — durations, easing curves, Reduce Motion guard |
| §11 Accessibility | `AccessibilityHelpers`, `MinTouchTarget`, `FocusOutline`, semantic labels |
| §12 Pitfalls | Every item in the PDF's pitfall list is addressed in the widget implementations |
| §13 Golden Rules | All 8 rules encoded as constants, widget behavior, and test assertions |

---

## 16. Implementation Decisions

The following choices were made by the engineering implementation and are **not** specified in the PDF:

| Decision | Rationale |
|---|---|
| **Dark theme** — dark color values in `AppColors` are engineering additions. The PDF defines a light palette only. | Common production requirement. Clearly marked `⚙️ OPTIONAL`. |
| **Font family = null** (system font) | The PDF does not specify a typeface. Marked `🎨 PROJECT-SPECIFIC`. Replace with your brand font. |
| **Shimmer implemented via AnimationController + gradient** | No external shimmer package. Avoids dependency. |
| **Pressed button uses HSL darkening** (~15–17% lightness reduction) | PDF says "darken 15–20%". HSL is a clean, formula-based approach. |
| **Pressed card uses ~5% HSL lightening** | PDF says "bg darken 4–6%". |
| **`AppMotion` uses mid-point of PDF duration ranges** | PDF gives ranges; mid-point is pragmatic default. |
| **`AppConstants.maxContentWidth` = 640pt** | PDF specifies "~600–680pt". 640 is the mid-point. |
| **`AppButtonVariant.destructive` and `.ghost`** | PDF implies semantic variants via error token; these are engineering additions. |
| **`AppLoadingOverlay`, `AppInlineError`, `AppPaginationLoader`** | Common patterns that complement the PDF-specified states. |
| **`AvatarGroup`** | Common UI pattern derived from avatar specs. |
| **`AppSliverScreenLayout`** | Engineering variant of the PDF screen template for collapsible headers. |

---

*Built from Mobile App UI Consistency Guide v2.0 — Enterprise Design System Reference.*
