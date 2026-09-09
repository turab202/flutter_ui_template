// ============================================================
// APP CONSTANTS
// Source: Mobile App UI Consistency Guide v2.0 — Various sections
// ============================================================
//
// Non-theme constants that components reference.
//
// ANNOTATION LEGEND:
//   🔒 DESIGN SYSTEM — KEEP CONSISTENT
//   🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
//   ⚙️ OPTIONAL — CONFIGURE IF NEEDED
//
// ============================================================

abstract final class AppConstants {
  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Touch Targets (PDF Section 4)
  // ----------------------------------------------------------

  /// Minimum interactive touch area. PDF: 44×44pt — non-negotiable.
  static const double minTouchTarget = 44.0;

  /// Minimum button height. PDF: 48pt minimum.
  static const double minButtonHeight = 48.0;

  /// Small button height (secondary/small variant). PDF: 40pt.
  static const double smallButtonHeight = 40.0;

  /// Minimum input field height. PDF: 48pt minimum.
  static const double minInputHeight = 48.0;

  /// Minimum spacing between adjacent tappable elements. PDF: 8pt.
  static const double minTappableSpacing = 8.0;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Component Dimensions (PDF Section 7)
  // ----------------------------------------------------------

  /// Fixed header height. PDF Section 8: height = 56pt.
  static const double headerHeight = 56.0;

  /// Fixed footer / action bar height. PDF Section 8: height = 56pt.
  static const double footerHeight = 56.0;

  /// Bottom navigation bar height. PDF Section 7.7: NavBar height = 56pt.
  static const double bottomNavHeight = 56.0;

  /// Bottom navigation item height. PDF Section 7.7: itemHeight = 44pt.
  static const double bottomNavItemHeight = 44.0;

  /// Single-line list item height. PDF Section 7.4: Single-line = 56pt.
  static const double listItemSingleHeight = 56.0;

  /// Two-line list item height. PDF Section 7.4: Two-line = 72pt.
  static const double listItemTwoLineHeight = 72.0;

  /// Badge / chip height. PDF Section 7.6: Height = 24pt.
  static const double badgeHeight = 24.0;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Icon Sizes (PDF Section 7.12)
  // Standard stroke: 1.5pt. Emphasis stroke: 2pt.
  // ----------------------------------------------------------

  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  /// Standard icon stroke width. PDF Section 7.12.
  static const double iconStrokeDefault = 1.5;

  /// Emphasis icon stroke width. PDF Section 7.12.
  static const double iconStrokeEmphasis = 2.0;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Avatar Sizes (PDF Section 7.12)
  // ----------------------------------------------------------

  static const double avatarXxs = 24.0;
  static const double avatarXs  = 32.0;
  static const double avatarSm  = 40.0;
  static const double avatarMd  = 56.0;
  static const double avatarLg  = 96.0;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Typography minimum (PDF Section 2)
  // ----------------------------------------------------------

  /// Minimum readable text size across the entire app.
  /// PDF: "Minimum readable size: 12pt — Never go smaller."
  static const double minFontSize = 12.0;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Toast behavior (PDF Section 7.9)
  // ----------------------------------------------------------

  /// Toast auto-dismiss duration. PDF: 3–4 seconds.
  static const Duration toastDuration = Duration(seconds: 3);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Z-Index / Stacking Layer Map (PDF Section 5)
  // Flutter uses Stack widget ordering rather than CSS z-index,
  // but these values are documented for reference and used in
  // Overlay-based components.
  // ----------------------------------------------------------

  static const int zBase        = 0;
  static const int zStickyHeader = 10;
  static const int zDropdown    = 100;
  static const int zModalOverlay = 1000;
  static const int zModalContent = 1001;
  static const int zToast       = 2000;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Max content width (PDF Sections 2 & 9)
  // Cap body text / form content at ~600–680pt on larger screens.
  // ----------------------------------------------------------

  /// Maximum content width on large screens. PDF: ~600–680pt.
  static const double maxContentWidth = 640.0;

  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
  // App-level metadata
  // TODO: Replace with your application's name and version.
  // ----------------------------------------------------------

  /// The application display name shown in headers/titles.
  static const String appName = 'Flutter UI Template';

  /// Application version string (informational only).
  static const String appVersion = '1.0.0';
}
