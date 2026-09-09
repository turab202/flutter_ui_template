import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

// ============================================================
// APP CARD
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.3
// ============================================================
//
// PDF Specifications:
//   Padding:   16pt
//   Radius:    12pt
//   Elevation: elevation-1 (0px 1px 2px rgba(0,0,0,0.06))
//
//   Pressable cards:
//     Pressed state: bg darken 4–6% OR elevation step-down.
//     PDF: "Pressable cards require pressed state
//           (bg darken 4-6% or elevation step-down)"
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.semanticLabel,
    this.header,
    this.footer,
  });

  /// Card body content.
  final Widget child;

  /// When non-null, the card becomes pressable.
  /// PDF: "Pressable cards require pressed state."
  final VoidCallback? onTap;

  /// Override default 16pt padding.
  final EdgeInsetsGeometry? padding;

  /// Override card surface color.
  final Color? color;

  /// Screen-reader label for pressable cards.
  final String? semanticLabel;

  /// Optional header widget rendered above the padded body.
  final Widget? header;

  /// Optional footer widget rendered below the padded body.
  final Widget? footer;

  bool get _isPressable => onTap != null;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;

  // PDF: pressed = bg darken 4–6% OR elevation step-down.
  // We implement both: darken bg AND step elevation down.
  List<BoxShadow> get _shadow =>
      _pressed ? AppShadows.elevation0 : AppShadows.elevation1;

  Color get _surfaceColor {
    final base = widget.color ?? AppColors.background;
    if (_pressed && widget._isPressable) {
      // Darken by ~5% using HSL
      final hsl = HSLColor.fromColor(base);
      return hsl.withLightness((hsl.lightness - 0.05).clamp(0.0, 1.0)).toColor();
    }
    return base;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.header != null) widget.header!,
        Padding(
          padding: widget.padding ??
              const EdgeInsets.all(AppSpacing.cardPadding), // PDF: 16pt
          child: widget.child,
        ),
        if (widget.footer != null) widget.footer!,
      ],
    );

    return Semantics(
      label: widget.semanticLabel,
      button: widget._isPressable,
      child: AnimatedContainer(
        duration: AppMotion.micro,
        curve: AppMotion.standard,
        decoration: BoxDecoration(
          color: _surfaceColor,
          borderRadius: AppRadius.mdAll, // PDF: radius = 12pt
          boxShadow: _shadow,
        ),
        child: ClipRRect(
          borderRadius: AppRadius.mdAll,
          child: widget._isPressable
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onTap,
                    onTapDown: (_) => setState(() => _pressed = true),
                    onTapUp: (_) => setState(() => _pressed = false),
                    onTapCancel: () => setState(() => _pressed = false),
                    splashColor: AppColors.primary.withValues(alpha: 0.06),
                    highlightColor: Colors.transparent,
                    child: content,
                  ),
                )
              : content,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// AppSurfaceCard
// A card that uses the surface color (#F3F4F6) instead of
// the default white background — for nested cards inside
// a white screen.
// ⚙️ OPTIONAL — convenience variant.
// ----------------------------------------------------------

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: padding,
      color: AppColors.surface,
      semanticLabel: semanticLabel,
      child: child,
    );
  }
}
