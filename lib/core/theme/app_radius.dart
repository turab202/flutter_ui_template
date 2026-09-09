import 'package:flutter/material.dart';

// ============================================================
// APP RADIUS
// Source: Mobile App UI Consistency Guide v2.0 — Sections 7 & 15
// ============================================================
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
// All radius values are taken directly from the PDF component
// specifications. Do not invent per-component corner radii.
//
// ============================================================

abstract final class AppRadius {
  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Radius Scale (PDF Section 15 — Quick Reference Sheet)
  //
  // 8pt   — cards (standard)
  // 12pt  — cards (alternate / larger surfaces)
  // 20pt  — modals
  // full  — badges / pill chips
  // ----------------------------------------------------------

  /// 8pt — Standard card radius and toast radius.
  /// PDF Section 7.9 (Toasts): Radius = 8pt
  /// PDF Section 15: "8pt cards"
  static const double sm = 8.0;

  /// 12pt — Alternate card radius.
  /// PDF Section 7.3 (Cards): radius = 12pt
  /// PDF Section 15: "12pt cards (alt)"
  static const double md = 12.0;

  /// 20pt — Modals and bottom sheets.
  /// PDF Section 7.8 (Modals/Sheets): radius = 20pt
  static const double lg = 20.0;

  /// Full / pill — Badges, chips.
  /// PDF Section 7.6 (Badges/Chips): Radius = full (pill)
  /// Using 100 as a large value that always renders as full pill.
  static const double full = 100.0;

  // ----------------------------------------------------------
  // Convenience BorderRadius objects
  // ⚙️ OPTIONAL — convenience wrappers, not in PDF directly.
  // ----------------------------------------------------------

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius fullAll = BorderRadius.all(Radius.circular(full));

  /// Top-only rounded corners — used for bottom sheets.
  /// ⚙️ OPTIONAL — engineering decision for bottom sheet shape.
  static const BorderRadius lgTop = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );
}
