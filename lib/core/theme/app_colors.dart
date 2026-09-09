import 'package:flutter/material.dart';

// ============================================================
// APP COLORS
// Source: Mobile App UI Consistency Guide v2.0 — Section 3
// ============================================================
//
// This file defines the complete color token system.
//
// ANNOTATION LEGEND:
//   🔒 DESIGN SYSTEM — KEEP CONSISTENT
//      Values defined by the design guide. Change only if the
//      design system itself is updated.
//
//   🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
//      Replace with the target application's brand colors.
//
//   ⚙️ OPTIONAL — CONFIGURE IF NEEDED
//      Engineering additions not specified in the PDF.
//
// ============================================================

abstract final class AppColors {
  // ----------------------------------------------------------
  // 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
  // Core Palette (PDF Section 3 — Core Palette)
  // TODO: Replace primary/secondary with your brand colors.
  // ----------------------------------------------------------

  /// Main action color. Used for primary buttons, links, focus rings.
  /// PDF value: #0066CC
  static const Color primary = Color(0xFF0066CC);

  /// Secondary action color.
  /// PDF value: #6B7280
  static const Color secondary = Color(0xFF6B7280);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Semantic / State Colors (PDF Section 3 — Core Palette)
  // ----------------------------------------------------------

  /// Error state color.
  /// PDF value: #DC2626
  static const Color error = Color(0xFFDC2626);

  /// Success state color.
  /// PDF value: #059669
  static const Color success = Color(0xFF059669);

  /// Warning state color.
  /// PDF value: #D97706
  static const Color warning = Color(0xFFD97706);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Surface / Background Colors (PDF Section 3 — Core Palette)
  // ----------------------------------------------------------

  /// Screen background.
  /// PDF value: #FFFFFF
  static const Color background = Color(0xFFFFFFFF);

  /// Cards and sheets surface.
  /// PDF value: #F3F4F6
  static const Color surface = Color(0xFFF3F4F6);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Text Colors (PDF Section 3 — Text & Structural Palette)
  // ----------------------------------------------------------

  /// Primary text content.
  /// PDF value: #111827
  static const Color textPrimary = Color(0xFF111827);

  /// Secondary / supporting text content.
  /// PDF value: #6B7280
  /// ⚠️ WCAG NOTE: Verify this pairing on surface (#F3F4F6) before
  /// shipping — the guide flags it as a common contrast failure point.
  static const Color textSecondary = Color(0xFF6B7280);

  /// Disabled text.
  /// PDF value: #9CA3AF
  static const Color textDisabled = Color(0xFF9CA3AF);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Border Colors (PDF Section 3 — Text & Structural Palette)
  // ----------------------------------------------------------

  /// Default dividers and borders.
  /// PDF value: #E5E7EB
  static const Color borderDefault = Color(0xFFE5E7EB);

  /// Emphasized / focus borders.
  /// PDF value: #D1D5DB
  static const Color borderStrong = Color(0xFFD1D5DB);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Overlay & Disabled (PDF Section 3 — Text & Structural Palette)
  // ----------------------------------------------------------

  /// Modal scrim overlay.
  /// PDF value: rgba(0,0,0,0.5)
  static const Color overlay = Color(0x80000000);

  /// Disabled element background.
  /// PDF value: #F3F4F6
  static const Color disabledBg = Color(0xFFF3F4F6);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Disabled Button (PDF Section 7.1 — Buttons)
  // ----------------------------------------------------------

  /// Disabled button background.
  /// PDF value: #9CA3AF
  static const Color disabledButton = Color(0xFF9CA3AF);

  // ----------------------------------------------------------
  // ⚙️ OPTIONAL — CONFIGURE IF NEEDED
  // Dark Mode Surfaces
  // These are NOT from the PDF (which defines a light palette only).
  // Provided as an engineering addition for dark theme support.
  // See AppTheme.dark() for usage.
  // ----------------------------------------------------------

  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkBorderDefault = Color(0xFF374151);
  static const Color darkBorderStrong = Color(0xFF4B5563);

  // ----------------------------------------------------------
  // Pressed-state helpers
  // ⚙️ OPTIONAL — Engineering utility, not specified in PDF.
  // PDF requires pressed = bg darkened 15–20% (Section 7.1).
  // ----------------------------------------------------------

  /// Primary color darkened ~17% for pressed state.
  static const Color primaryPressed = Color(0xFF0052A3);

  /// Secondary color darkened ~17% for pressed state.
  static const Color secondaryPressed = Color(0xFF4B5563);
}
