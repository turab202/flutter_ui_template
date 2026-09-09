import 'package:flutter/material.dart';

// ============================================================
// APP MOTION
// Source: Mobile App UI Consistency Guide v2.0 — Section 10
// ============================================================
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
// Duration ranges and easing curves from the PDF.
// The mid-point of each range is used as the canonical value.
//
// PDF Durations:
//   Micro-interactions:  100–150ms
//   Screen transitions:  300–400ms
//   Modals/sheets:       250–350ms
//
// PDF Easing Curves:
//   Standard:              cubic-bezier(0.4, 0.0, 0.2, 1.0)
//   Deceleration (enter):  cubic-bezier(0.0, 0.0, 0.2, 1.0)
//   Acceleration (exit):   cubic-bezier(0.4, 0.0, 1.0, 1.0)
//
// PDF Accessibility: Respect "Reduce Motion" system setting —
// fall back to opacity-only transitions when enabled.
//
// ============================================================

abstract final class AppMotion {
  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Duration constants
  // Using mid-point of each PDF range.
  // ----------------------------------------------------------

  /// Micro-interaction duration. PDF range: 100–150ms.
  static const Duration micro = Duration(milliseconds: 125);

  /// Screen transition duration. PDF range: 300–400ms.
  static const Duration screenTransition = Duration(milliseconds: 350);

  /// Modal / bottom sheet duration. PDF range: 250–350ms.
  static const Duration modal = Duration(milliseconds: 300);

  // ----------------------------------------------------------
  // ⚙️ OPTIONAL — Min/max bounds for reference.
  // ----------------------------------------------------------
  static const Duration microMin = Duration(milliseconds: 100);
  static const Duration microMax = Duration(milliseconds: 150);
  static const Duration screenTransitionMin = Duration(milliseconds: 300);
  static const Duration screenTransitionMax = Duration(milliseconds: 400);
  static const Duration modalMin = Duration(milliseconds: 250);
  static const Duration modalMax = Duration(milliseconds: 350);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Easing curves (PDF Section 10)
  // ----------------------------------------------------------

  /// Standard curve — general transitions.
  /// PDF: cubic-bezier(0.4, 0.0, 0.2, 1.0)
  static const Curve standard = Cubic(0.4, 0.0, 0.2, 1.0);

  /// Deceleration curve — elements entering the screen.
  /// PDF: cubic-bezier(0.0, 0.0, 0.2, 1.0)
  static const Curve decelerate = Cubic(0.0, 0.0, 0.2, 1.0);

  /// Acceleration curve — elements leaving the screen.
  /// PDF: cubic-bezier(0.4, 0.0, 1.0, 1.0)
  static const Curve accelerate = Cubic(0.4, 0.0, 1.0, 1.0);

  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Reduce Motion support (PDF Sections 10 & 11)
  // When the system "Reduce Motion" preference is active,
  // fall back to simple opacity transitions.
  // Use AppMotion.shouldReduceMotion(context) in widgets.
  // ----------------------------------------------------------

  /// Returns true when the system "Reduce Motion" setting is active.
  /// PDF: "Respect system 'Reduce Motion' setting — fall back to
  /// opacity-only transitions when enabled."
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Returns the appropriate duration: standard, or near-instant
  /// if Reduce Motion is enabled. Opacity fades still use a brief
  /// duration so the transition isn't jarring.
  static Duration effectiveDuration(
    BuildContext context,
    Duration standard,
  ) {
    if (shouldReduceMotion(context)) {
      return const Duration(milliseconds: 150);
    }
    return standard;
  }

  /// Returns the appropriate curve: standard, or linear (for
  /// simple opacity fades) if Reduce Motion is enabled.
  static Curve effectiveCurve(BuildContext context, Curve standard) {
    if (shouldReduceMotion(context)) return Curves.linear;
    return standard;
  }
}
