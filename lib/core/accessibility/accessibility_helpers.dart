import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

// ============================================================
// ACCESSIBILITY HELPERS
// Source: Mobile App UI Consistency Guide v2.0 — Section 11
// ============================================================
//
// PDF Accessibility Requirements:
//   • Dynamic Type: Support system font scaling end-to-end;
//     do not cap or disable it.
//   • Screen Readers: Label all interactive elements for
//     VoiceOver / TalkBack, including icon-only buttons.
//   • Reduce Motion: Honor system setting (opacity fades only).
//   • Contrast: Minimum 4.5:1 body text, 3:1 large text.
//     Verify actual token pairings.
//   • Focus Indication: Visible focus state (border-strong
//     outline, 2pt) for keyboard / switch control.
//   • Minimum 44×44pt touch targets.
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

// ----------------------------------------------------------
// MinTouchTarget
// Wraps any widget and enforces the 44×44pt minimum touch
// target by using a GestureDetector area larger than the
// visual element.
//
// PDF Section 4: "Minimum touch area: 44×44pt — non-negotiable,
// applies to icons, checkboxes, and any tappable element
// regardless of visual size."
// ----------------------------------------------------------

class MinTouchTarget extends StatelessWidget {
  const MinTouchTarget({
    super.key,
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final Widget child;
  final VoidCallback? onTap;

  /// Screen reader label for the interactive area.
  /// PDF: Label all interactive elements for VoiceOver / TalkBack.
  final String? semanticLabel;

  /// Set true when a parent Semantics widget already covers this.
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      excludeSemantics: excludeSemantics,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.minTouchTarget / 2),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: AppConstants.minTouchTarget,
            minHeight: AppConstants.minTouchTarget,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// SemanticIconButton
// An icon-only button with a mandatory semantic label.
//
// PDF Section 11: "Label all interactive elements for
// VoiceOver / TalkBack, including icon-only buttons."
// ----------------------------------------------------------

class SemanticIconButton extends StatelessWidget {
  const SemanticIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.onTap,
    this.size = AppConstants.iconMd,
    this.color,
  });

  final Widget icon;

  /// Required accessible label for screen readers.
  final String semanticLabel;
  final VoidCallback? onTap;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.minTouchTarget / 2),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: AppConstants.minTouchTarget,
            minHeight: AppConstants.minTouchTarget,
          ),
          child: Center(
            child: IconTheme(
              data: IconThemeData(size: size, color: color),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// FocusOutline
// Draws a visible focus ring (border-strong, 2pt) around its
// child when that child has keyboard focus.
//
// PDF Section 11: "Any element reachable via external keyboard
// or switch control needs a visible focus state
// (border-strong outline, 2pt)."
// ----------------------------------------------------------

class FocusOutline extends StatefulWidget {
  const FocusOutline({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  final Widget child;
  final BorderRadius borderRadius;

  @override
  State<FocusOutline> createState() => _FocusOutlineState();
}

class _FocusOutlineState extends State<FocusOutline> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final outlineColor = theme.colorScheme.primary;

    return Focus(
      onFocusChange: (focused) => setState(() => _focused = focused),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: _focused
            ? BoxDecoration(
                borderRadius: widget.borderRadius,
                border: Border.all(
                  color: outlineColor,
                  width: 2, // PDF: border-strong outline, 2pt
                ),
              )
            : const BoxDecoration(),
        child: widget.child,
      ),
    );
  }
}

// ----------------------------------------------------------
// AccessibilityHelpers — static utilities
// ----------------------------------------------------------

abstract final class AccessibilityHelpers {
  // ----------------------------------------------------------
  // Dynamic Type / Font Scaling (PDF Sections 2 & 11)
  // ----------------------------------------------------------

  /// Returns true when the user has increased their system font
  /// scale above 1.0. Useful for adapting layouts.
  ///
  /// PDF: "Support system font scaling (Dynamic Type / Android
  /// font scale) — do not disable it."
  static bool isLargeText(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0) > 1.0;
  }

  /// Returns the current text scale factor.
  static double textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0);
  }

  // ----------------------------------------------------------
  // Reduce Motion (PDF Sections 10 & 11)
  // ----------------------------------------------------------

  /// Returns true when the system "Reduce Motion" setting is on.
  /// PDF: "Honor system setting (fallback to simple opacity fades)."
  static bool reduceMotion(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  // ----------------------------------------------------------
  // Contrast helpers (PDF Section 3 & 11)
  // WCAG AA: 4.5:1 for body text, 3:1 for large text.
  //
  // These are computed helpers; the actual token pairings from
  // the PDF are verified manually in comments within AppColors.
  // ⚙️ OPTIONAL — runtime contrast checking utility.
  // ----------------------------------------------------------

  /// Calculates the relative luminance of a color per WCAG 2.1.
  static double relativeLuminance(Color color) {
    double linearize(double channel) {
      return channel <= 0.03928
          ? channel / 12.92
          : ((channel + 0.055) / 1.055) * ((channel + 0.055) / 1.055);
    }

    final r = linearize(color.r);
    final g = linearize(color.g);
    final b = linearize(color.b);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Calculates the WCAG contrast ratio between two colors.
  /// PDF: "Every text/background pairing must meet WCAG AA —
  /// 4.5:1 for body text, 3:1 for large text."
  static double contrastRatio(Color foreground, Color background) {
    final l1 = relativeLuminance(foreground);
    final l2 = relativeLuminance(background);
    final lighter = l1 > l2 ? l1 : l2;
    final darker  = l1 > l2 ? l2 : l1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Returns true if the contrast ratio meets WCAG AA for body text (4.5:1).
  static bool meetsWcagAABody(Color foreground, Color background) {
    return contrastRatio(foreground, background) >= 4.5;
  }

  /// Returns true if the contrast ratio meets WCAG AA for large text (3:1).
  /// Large text = 18pt+ regular or 14pt+ bold.
  static bool meetsWcagAALarge(Color foreground, Color background) {
    return contrastRatio(foreground, background) >= 3.0;
  }
}
