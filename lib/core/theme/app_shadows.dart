import 'package:flutter/material.dart';

// ============================================================
// APP SHADOWS
// Source: Mobile App UI Consistency Guide v2.0 — Section 5
// ============================================================
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
// Exact shadow specs from the PDF. Never invent per-screen
// shadow values. Always use one of these defined elevations.
//
// PDF shadow specs:
//   elevation-0: none
//   elevation-1: 0px 1px 2px  rgba(0,0,0,0.06)
//   elevation-2: 0px 2px 8px  rgba(0,0,0,0.08)
//   elevation-3: 0px 4px 16px rgba(0,0,0,0.12)
//   elevation-4: 0px 8px 24px rgba(0,0,0,0.16)
//
// Note on Flutter Material elevation:
// Flutter's Material elevation system uses an internal algorithm
// that does not map 1:1 to custom shadow specs. We implement the
// PDF shadows as explicit BoxShadow lists on components that
// need them. See AppShadows.forElevation() for a helper.
// ⚙️ OPTIONAL: The numeric elevation values (0–4) are also
// provided as doubles for use with Material widget `elevation`
// props where exact shadow control is not needed.
//
// ============================================================

abstract final class AppShadows {
  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Elevation 0 — Flat surfaces
  // PDF: none
  // ----------------------------------------------------------
  static const List<BoxShadow> elevation0 = [];

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Elevation 1 — Cards
  // PDF: 0px 1px 2px rgba(0,0,0,0.06)
  // ----------------------------------------------------------
  static const List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Color(0x0F000000), // rgba(0,0,0,0.06) → 0x0F ≈ 15
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Elevation 2 — Dropdowns, popovers
  // PDF: 0px 2px 8px rgba(0,0,0,0.08)
  // ----------------------------------------------------------
  static const List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Color(0x14000000), // rgba(0,0,0,0.08) → 0x14 = 20
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
  ];

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Elevation 3 — Modals, bottom sheets
  // PDF: 0px 4px 16px rgba(0,0,0,0.12)
  // ----------------------------------------------------------
  static const List<BoxShadow> elevation3 = [
    BoxShadow(
      color: Color(0x1F000000), // rgba(0,0,0,0.12) → 0x1F = 31
      offset: Offset(0, 4),
      blurRadius: 16,
    ),
  ];

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Elevation 4 — Toasts, snackbars
  // PDF: 0px 8px 24px rgba(0,0,0,0.16)
  // ----------------------------------------------------------
  static const List<BoxShadow> elevation4 = [
    BoxShadow(
      color: Color(0x29000000), // rgba(0,0,0,0.16) → 0x29 = 41
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Material elevation numeric values for use with Material widgets.
  // Matches the PDF's 0–4 scale.
  // ----------------------------------------------------------
  static const double elevationValue0 = 0;
  static const double elevationValue1 = 1;
  static const double elevationValue2 = 2;
  static const double elevationValue3 = 3;
  static const double elevationValue4 = 4;

  // ----------------------------------------------------------
  // Helper: get BoxShadow list by elevation index (0–4).
  // ⚙️ OPTIONAL — convenience utility.
  // ----------------------------------------------------------
  static List<BoxShadow> forElevation(int level) {
    switch (level) {
      case 1: return elevation1;
      case 2: return elevation2;
      case 3: return elevation3;
      case 4: return elevation4;
      default: return elevation0;
    }
  }
}
