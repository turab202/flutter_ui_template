import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

// ============================================================
// RESPONSIVE HELPERS
// Source: Mobile App UI Consistency Guide v2.0 — Section 9
// ============================================================
//
// Breakpoint definitions and responsive layout utilities.
//
// PDF Breakpoints:
//   mobile:       0–375pt     (iPhone SE reference)
//   mobile-large: 376–428pt   (iPhone Pro reference)
//   tablet:       429–1024pt  (iPad reference)
//
// Key PDF rules:
//   • Use dynamic APIs (MediaQuery) — not fixed constants.
//   • Cap content/text width at ~600–680pt on tablet.
//   • Never let form fields span full tablet width.
//   • Prefer two-column or centered single-column on tablet.
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT (breakpoint values)
// ⚙️ OPTIONAL — layout helpers are engineering additions.
//
// ============================================================

// ----------------------------------------------------------
// Breakpoint enum
// ----------------------------------------------------------

enum AppBreakpoint {
  /// 0–375pt — iPhone SE reference device.
  mobile,

  /// 376–428pt — iPhone Pro reference device.
  mobileLarge,

  /// 429–1024pt — iPad reference device.
  tablet,
}

// ----------------------------------------------------------
// Breakpoint boundary constants (PDF Section 9)
// ----------------------------------------------------------

abstract final class AppBreakpoints {
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT

  /// Upper bound of mobile breakpoint. PDF: 0–375pt.
  static const double mobileMax = 375.0;

  /// Upper bound of mobile-large breakpoint. PDF: 376–428pt.
  static const double mobileLargeMax = 428.0;

  // tablet = 429–1024pt (anything above mobileLargeMax)
}

// ----------------------------------------------------------
// ResponsiveLayout — InheritedWidget that exposes breakpoint
// info to the subtree. Wrap your app's root (or individual
// screens) to make responsive values available via context.
// ⚙️ OPTIONAL — engineering utility widget.
// ----------------------------------------------------------

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  // ----------------------------------------------------------
  // Static helpers — use these in any widget.
  // These use MediaQuery so they respect system font scaling
  // and device pixel ratio correctly.
  // ----------------------------------------------------------

  /// Returns the current [AppBreakpoint] for the given context.
  static AppBreakpoint breakpointOf(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width <= AppBreakpoints.mobileMax) return AppBreakpoint.mobile;
    if (width <= AppBreakpoints.mobileLargeMax) return AppBreakpoint.mobileLarge;
    return AppBreakpoint.tablet;
  }

  /// Returns true when the screen is tablet-sized or larger.
  static bool isTablet(BuildContext context) =>
      breakpointOf(context) == AppBreakpoint.tablet;

  /// Returns true when the screen is mobile (SE size).
  static bool isMobile(BuildContext context) =>
      breakpointOf(context) == AppBreakpoint.mobile;

  /// Returns true when the screen is mobile-large (Pro size).
  static bool isMobileLarge(BuildContext context) =>
      breakpointOf(context) == AppBreakpoint.mobileLarge;

  /// Returns the maximum width a content block should occupy.
  ///
  /// On tablet: capped at [AppConstants.maxContentWidth] (640pt).
  /// On mobile: full available width.
  ///
  /// PDF: "Cap content/text width at ~600–680pt on larger screens."
  static double contentMaxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isTablet(context)) {
      return AppConstants.maxContentWidth.clamp(0, screenWidth);
    }
    return screenWidth;
  }

  /// Returns a value that resolves to [mobile], [mobileLarge], or
  /// [tablet] depending on the current screen width.
  ///
  /// Example:
  /// ```dart
  /// final columns = ResponsiveLayout.resolve(
  ///   context,
  ///   mobile: 1,
  ///   mobileLarge: 1,
  ///   tablet: 2,
  /// );
  /// ```
  static T resolve<T>(
    BuildContext context, {
    required T mobile,
    T? mobileLarge,
    required T tablet,
  }) {
    switch (breakpointOf(context)) {
      case AppBreakpoint.tablet:
        return tablet;
      case AppBreakpoint.mobileLarge:
        return mobileLarge ?? mobile;
      case AppBreakpoint.mobile:
        return mobile;
    }
  }
}

// ----------------------------------------------------------
// ResponsiveConstrainedBox
// Wraps a child and centres it, capping width at the design
// system's maxContentWidth on tablet screens.
//
// PDF: "On tablet, prefer a two-column or centered
// single-column layout over full-width stretch — never let
// form fields span the full tablet width."
//
// ⚙️ OPTIONAL — convenience widget.
// ----------------------------------------------------------

class ResponsiveConstrainedBox extends StatelessWidget {
  const ResponsiveConstrainedBox({
    super.key,
    required this.child,
    this.maxWidth = AppConstants.maxContentWidth,
  });

  final Widget child;

  /// Maximum content width. Defaults to PDF-specified 640pt cap.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    if (!ResponsiveLayout.isTablet(context)) return child;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

// ----------------------------------------------------------
// ResponsiveGrid
// Returns a GridView with column count that adapts to breakpoint.
// On mobile → 1 column, on tablet → 2 columns by default.
//
// ⚙️ OPTIONAL — convenience widget.
// ----------------------------------------------------------

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.padding,
  });

  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final double spacing;
  final double runSpacing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveLayout.resolve(
      context,
      mobile: mobileColumns,
      tablet: tabletColumns,
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          mainAxisSpacing: runSpacing,
          childAspectRatio: 1.0,
        ),
        itemCount: children.length,
        itemBuilder: (_, i) => children[i],
      ),
    );
  }
}
