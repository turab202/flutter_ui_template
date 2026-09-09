import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// ============================================================
// APP DIVIDER
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.5
// ============================================================
//
// PDF Specifications:
//   Height: 1pt
//   Color:  border-default (#E5E7EB)
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.color,
    this.indent = 0,
    this.endIndent = 0,
  });

  /// Override color. Defaults to border-default per PDF.
  final Color? color;

  /// Leading indent.
  final double indent;

  /// Trailing indent.
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.borderDefault, // PDF: border-default
      thickness: 1,                            // PDF: Height = 1pt
      height: 1,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

// ----------------------------------------------------------
// AppInsetDivider
// A divider indented to align with list item text content,
// matching the 16pt horizontal padding + leading widget width.
// ⚙️ OPTIONAL — engineering convenience variant.
// ----------------------------------------------------------

class AppInsetDivider extends StatelessWidget {
  const AppInsetDivider({
    super.key,
    this.leadingWidth = 72.0, // 16pt padding + 40pt icon + 16pt gap
  });

  final double leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppDivider(indent: leadingWidth);
  }
}

// ----------------------------------------------------------
// AppVerticalDivider
// Vertical version for use in rows / toolbar separators.
// ⚙️ OPTIONAL — not explicitly in PDF, derived from divider token.
// ----------------------------------------------------------

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({
    super.key,
    this.height = 24,
    this.color,
  });

  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: VerticalDivider(
        color: color ?? AppColors.borderDefault,
        thickness: 1,
        width: 1,
      ),
    );
  }
}
