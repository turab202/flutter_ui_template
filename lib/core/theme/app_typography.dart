import 'package:flutter/material.dart';

// ============================================================
// APP TYPOGRAPHY
// Source: Mobile App UI Consistency Guide v2.0 — Section 2
// ============================================================
//
// Every style ships with a defined fontSize AND height (line-height).
// "Size alone is not a renderable spec." — PDF Section 2
//
// Flutter's TextStyle.height is a MULTIPLIER of fontSize,
// not an absolute pt value. Conversion: height = lineHeightPt / fontSizePt
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
// Sizes, weights, and line-heights are from the PDF.
//
// 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
// fontFamily: The PDF does not specify a typeface. The system
// font (default) is used here. Replace with your project's
// brand typeface if required.
//
// ============================================================

abstract final class AppTypography {
  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
  // Font Family
  // TODO: Replace null with your project's font family name,
  // e.g., 'Inter', 'Poppins', 'SF Pro'. Register fonts in pubspec.yaml.
  // null = Flutter default system font.
  // ----------------------------------------------------------
  static const String? fontFamily = null;

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Font Weight Constants (PDF Section 2 — Typography Rules)
  // ----------------------------------------------------------
  static const FontWeight weightRegular = FontWeight.w400;   // Body text
  static const FontWeight weightMedium = FontWeight.w500;    // Buttons, labels, small
  static const FontWeight weightSemibold = FontWeight.w600;  // Headers, emphasis

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Type Scale (PDF Section 2 — Typography System table)
  //
  // H1:      32pt / 40pt line-height (1.25x) / Semibold (600) — Screen title
  // H2:      24pt / 32pt line-height (1.33x) / Semibold (600) — Section header
  // H3:      20pt / 28pt line-height (1.40x) / Semibold (600) — Card title
  // Body:    16pt / 24pt line-height (1.50x) / Regular (400)  — Primary content
  // Caption: 14pt / 20pt line-height (1.43x) / Regular (400)  — Labels, metadata
  // Small:   12pt / 16pt line-height (1.33x) / Medium (500)   — Badges, timestamps
  //
  // Minimum readable size: 12pt — Never go smaller. (PDF Section 2)
  // ----------------------------------------------------------

  /// H1 — Screen title
  /// PDF: 32pt, line-height 40pt (1.25x), Semibold (600)
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.0,
    height: 1.25, // 40 / 32 = 1.25
    fontWeight: weightSemibold,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// H2 — Section header
  /// PDF: 24pt, line-height 32pt (1.33x), Semibold (600)
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.0,
    height: 1.3333, // 32 / 24 ≈ 1.33
    fontWeight: weightSemibold,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// H3 — Card title
  /// PDF: 20pt, line-height 28pt (1.40x), Semibold (600)
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.0,
    height: 1.4, // 28 / 20 = 1.40
    fontWeight: weightSemibold,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Body — Primary content
  /// PDF: 16pt, line-height 24pt (1.50x), Regular (400)
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    height: 1.5, // 24 / 16 = 1.50
    fontWeight: weightRegular,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Body Medium — Same size as Body but medium weight.
  /// Used for buttons and labels per PDF Section 2 Typography Rules.
  /// ⚙️ OPTIONAL — Derived from PDF weight rules, not a named entry in the scale.
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    height: 1.5,
    fontWeight: weightMedium,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Caption — Labels, metadata
  /// PDF: 14pt, line-height 20pt (1.43x), Regular (400)
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    height: 1.4286, // 20 / 14 ≈ 1.43
    fontWeight: weightRegular,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Small — Badges, timestamps
  /// PDF: 12pt, line-height 16pt (1.33x), Medium (500)
  /// ⚠️ This is the minimum readable size. Never use smaller than 12pt.
  static const TextStyle small = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.0,
    height: 1.3333, // 16 / 12 ≈ 1.33
    fontWeight: weightMedium,
    leadingDistribution: TextLeadingDistribution.even,
  );

  // ----------------------------------------------------------
  // Helper: Build a TextTheme for use in ThemeData.
  // Maps PDF styles to Material TextTheme roles.
  // ⚙️ OPTIONAL — mapping is an engineering decision.
  // ----------------------------------------------------------

  static TextTheme buildTextTheme({Color? color}) {
    final c = color;
    return TextTheme(
      displayLarge:  h1.copyWith(color: c),
      displayMedium: h2.copyWith(color: c),
      displaySmall:  h3.copyWith(color: c),
      headlineLarge:  h1.copyWith(color: c),
      headlineMedium: h2.copyWith(color: c),
      headlineSmall:  h3.copyWith(color: c),
      titleLarge:   h3.copyWith(color: c),
      titleMedium:  bodyMedium.copyWith(color: c),
      titleSmall:   caption.copyWith(fontWeight: FontWeight.w500, color: c),
      bodyLarge:    body.copyWith(color: c),
      bodyMedium:   body.copyWith(color: c),
      bodySmall:    caption.copyWith(color: c),
      labelLarge:   bodyMedium.copyWith(color: c),
      labelMedium:  small.copyWith(color: c),
      labelSmall:   small.copyWith(fontSize: 11, color: c),
    );
  }
}
