import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

// ============================================================
// APP SKELETON / SHIMMER LOADING
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.11
// ============================================================
//
// PDF Specifications:
//   Animation: Shimmer animation
//   Shape:     Matches shape of content being loaded
//              (never generic gray block)
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT (shapes must match content)
//
// Implementation note:
// Flutter does not include a shimmer library in the SDK. This
// implements shimmer via a custom AnimationController + gradient,
// avoiding any external package dependency.
//
// ============================================================

// ----------------------------------------------------------
// _ShimmerScope — InheritedWidget that shares the shimmer
// animation controller across multiple skeleton children.
// ⚙️ OPTIONAL — engineering architecture decision.
// ----------------------------------------------------------

// ----------------------------------------------------------
// ShimmerScopeState — public interface exposed by ShimmerScope.
// Returning this public type avoids exposing _ShimmerScopeState
// (a private type) in the public API.
// ⚙️ OPTIONAL — engineering architecture decision.
// ----------------------------------------------------------
abstract class ShimmerScopeState {
  Animation<double> get animation;
}

// ShimmerScope state is accessed via findAncestorStateOfType from child widgets.
class ShimmerScope extends StatefulWidget {
  const ShimmerScope({super.key, required this.child});
  final Widget child;

  @override
  State<ShimmerScope> createState() => _ShimmerScopeState();

  static ShimmerScopeState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ShimmerScopeState>();
  }
}
class _ShimmerScopeState extends State<ShimmerScope>
    with SingleTickerProviderStateMixin
    implements ShimmerScopeState {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // PDF: Shimmer animation — no exact duration specified.
      // ⚙️ 1.5s is a common industry standard for shimmer loops.
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Animation<double> get animation => _shimmerAnimation;

  @override
  Widget build(BuildContext context) => widget.child;
}

// ----------------------------------------------------------
// SkeletonBox — a single shimmer rectangle.
// Shape is defined by caller to match actual content.
// PDF: "Matches shape of content being loaded."
// ----------------------------------------------------------

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  final double width;
  final double height;
  final BorderRadius? borderRadius;

  /// Base (dark) shimmer color.
  /// ⚙️ Defaults derived from AppColors.surface token.
  final Color? baseColor;

  /// Highlight (light) shimmer color.
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final scope = ShimmerScope.of(context);
    final reduceMotion = AppMotion.shouldReduceMotion(context);

    final base = baseColor ?? AppColors.borderDefault;
    final highlight = highlightColor ?? AppColors.surface;
    final radius = borderRadius ?? AppRadius.smAll;

    if (reduceMotion || scope == null) {
      // Reduce Motion: static muted box, no animation.
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: radius,
        ),
      );
    }

    return AnimatedBuilder(
      animation: scope.animation,
    builder: (_, child) {
        final shimmerPosition = scope.animation.value;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (shimmerPosition - 1).clamp(0.0, 1.0),
                shimmerPosition.clamp(0.0, 1.0),
                (shimmerPosition + 1).clamp(0.0, 1.0),
              ],
              colors: [base, highlight, base],
            ),
          ),
        );
      },
    );
  }
}

// ----------------------------------------------------------
// SkeletonLine — a single text-line shaped skeleton.
// PDF: matches content shape — text lines are rectangles.
// ----------------------------------------------------------

class SkeletonLine extends StatelessWidget {
  const SkeletonLine({
    super.key,
    this.width,
    this.height = 16,
  });

  /// Defaults to full width.
  final double? width;

  /// Matches body text height (16pt default).
  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: width ?? double.infinity,
      height: height,
      borderRadius: AppRadius.smAll,
    );
  }
}

// ----------------------------------------------------------
// SkeletonCircle — circular skeleton for avatars/icons.
// PDF: matches content shape — avatars are circles.
// ----------------------------------------------------------

class SkeletonCircle extends StatelessWidget {
  const SkeletonCircle({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}

// ----------------------------------------------------------
// Pre-built skeleton layouts that mirror real content shapes.
// PDF: "Never generic gray block — match content being loaded."
// ----------------------------------------------------------

/// Skeleton that matches an AppCard with a text block.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding), // 16pt
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll, // 12pt matches AppCard
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLine(width: 120, height: 20),
          SizedBox(height: AppSpacing.xs),
          SkeletonLine(),
          SizedBox(height: AppSpacing.xxs),
          SkeletonLine(width: 220),
          SizedBox(height: AppSpacing.xs),
          SkeletonLine(width: 80, height: 14),
        ],
      ),
    );
  }
}

/// Skeleton that matches an AppListTile (single-line, with avatar).
class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key, this.showSubtitle = false});

  final bool showSubtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.listItemHorizontalPadding, // 16pt
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          // Avatar placeholder
          const SkeletonCircle(size: 40),
          const SizedBox(width: AppSpacing.xs),
          // Text lines
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLine(width: 140, height: 16),
                if (showSubtitle) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  const SkeletonLine(width: 100, height: 12),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          const SkeletonBox(width: 24, height: 24),
        ],
      ),
    );
  }
}

/// Skeleton that matches a text paragraph block.
class SkeletonParagraph extends StatelessWidget {
  const SkeletonParagraph({super.key, this.lines = 3});

  final int lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < lines; i++) ...[
          SkeletonLine(
            width: i == lines - 1
                ? 160 // last line is shorter — matches natural text
                : double.infinity,
          ),
          if (i < lines - 1) const SizedBox(height: AppSpacing.xxs),
        ],
      ],
    );
  }
}
