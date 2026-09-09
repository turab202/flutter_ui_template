// ============================================================
// APP SPACING
// Source: Mobile App UI Consistency Guide v2.0 — Section 1
// ============================================================
//
// 8pt grid system. All layout spacing is a multiple of 8.
// 4pt (xxs) is the only exception — reserved for icon-level
// micro-adjustments only.
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
// These values come directly from the PDF and define the grid.
// Do NOT introduce arbitrary spacing values. If you need a new
// size, it must be a multiple of 8 (or exactly 4 for micro gaps).
//
// ============================================================

abstract final class AppSpacing {
  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Spacing Scale (PDF Section 1 — Spacing System)
  // ----------------------------------------------------------

  /// xxs = 4pt — Icon padding, tiny internal gaps.
  /// ⚠️ Only exception to the 8pt grid. Reserved for icon-level micro-adjustments.
  static const double xxs = 4.0;

  /// xs = 8pt — Small gaps, button internal padding.
  static const double xs = 8.0;

  /// sm = 16pt — Card padding, spacing between elements.
  static const double sm = 16.0;

  /// md = 24pt — Section spacing, list gaps.
  static const double md = 24.0;

  /// lg = 32pt — Screen margins.
  static const double lg = 32.0;

  /// xl = 48pt — Major section breaks, empty states.
  static const double xl = 48.0;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Semantic Spacing Aliases (derived from the spacing scale)
  // Named for their intended structural use.
  // ----------------------------------------------------------

  /// Default horizontal padding for screen content.
  /// PDF Section 8: paddingHorizontal = 16pt
  static const double screenHorizontalPadding = sm;

  /// Default card internal padding.
  /// PDF Section 7.3: Card padding = 16pt
  static const double cardPadding = sm;

  /// Default input internal padding (vertical sides).
  /// PDF Section 7.2: Input padding = 12pt
  /// ⚙️ 12pt is NOT on the 8pt grid — this is a PDF-specified exception
  /// for input vertical padding only.
  static const double inputPaddingVertical = 12.0;

  /// Input internal padding (horizontal sides).
  /// PDF Section 7.2: Input padding = 12pt
  static const double inputPaddingHorizontal = 12.0;

  /// List item horizontal padding.
  /// PDF Section 7.4: Horizontal padding = 16pt
  static const double listItemHorizontalPadding = sm;

  /// Badge/chip horizontal padding.
  /// PDF Section 7.6: Padding = 8pt
  static const double badgePadding = xs;

  /// Modal horizontal margin.
  /// PDF Section 7.8: margin = 16pt
  static const double modalMargin = sm;

  /// Empty state vertical padding.
  /// PDF Section 7.10: Vertical padding = 48pt (xl)
  static const double emptyStatePadding = xl;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Touch Target Spacing (PDF Section 4)
  // ----------------------------------------------------------

  /// Minimum spacing between adjacent tappable elements.
  /// PDF: Minimum = 8pt
  static const double minTappableSpacing = xs;
}
