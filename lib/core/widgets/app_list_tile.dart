import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP LIST TILE
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.4
// ============================================================
//
// PDF Specifications:
//   Single-line:      56pt height
//   Two-line:         72pt height
//   Horizontal padding: 16pt
//
// Touch target: each item is at least 44pt tall, which is
// satisfied by both single (56pt) and two-line (72pt).
// PDF Section 4: "minimum touch area 44×44pt."
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

enum AppListTileVariant {
  /// Single-line: 56pt height.
  singleLine,

  /// Two-line: 72pt height.
  twoLine,
}

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isSelected = false,
    this.isEnabled = true,
    this.semanticLabel,
    this.contentPadding,
  });

  /// Primary text. Required.
  final String title;

  /// Secondary text. When provided, renders as two-line variant (72pt).
  final String? subtitle;

  /// Leading widget (icon or avatar). Must meet 44pt touch target if interactive.
  final Widget? leading;

  /// Trailing widget (icon, badge, switch, etc.).
  final Widget? trailing;

  /// Tap callback. When null, item is non-interactive (no ink splash).
  final VoidCallback? onTap;

  /// Highlights the item with primary tint when true.
  final bool isSelected;

  /// Grays out the item when false.
  final bool isEnabled;

  /// Override accessible label.
  final String? semanticLabel;

  /// Override horizontal padding (default: 16pt per PDF).
  final EdgeInsetsGeometry? contentPadding;

  AppListTileVariant get _variant =>
      subtitle != null ? AppListTileVariant.twoLine : AppListTileVariant.singleLine;

  double get _minHeight => _variant == AppListTileVariant.twoLine
      ? AppConstants.listItemTwoLineHeight   // 72pt
      : AppConstants.listItemSingleHeight;   // 56pt

  @override
  Widget build(BuildContext context) {
    final effectivePadding = contentPadding ??
        const EdgeInsets.symmetric(
          horizontal: AppSpacing.listItemHorizontalPadding, // PDF: 16pt
        );

    final titleColor = isEnabled ? AppColors.textPrimary : AppColors.textDisabled;
    final subtitleColor =
        isEnabled ? AppColors.textSecondary : AppColors.textDisabled;
    final bgColor = isSelected
        ? AppColors.primary.withValues(alpha: 0.06)
        : Colors.transparent;

    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      selected: isSelected,
      enabled: isEnabled,
      child: Material(
        color: bgColor,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          splashColor: AppColors.primary.withValues(alpha: 0.08),
          highlightColor: AppColors.primary.withValues(alpha: 0.04),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: _minHeight),
            child: Padding(
              padding: effectivePadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Leading
                  if (leading != null) ...[
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: AppConstants.minTouchTarget,
                        minHeight: AppConstants.minTouchTarget,
                      ),
                      child: Center(child: leading),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                  ],

                  // Title + Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: AppTypography.body.copyWith(color: titleColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: AppTypography.caption
                                .copyWith(color: subtitleColor),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Trailing
                  if (trailing != null) ...[
                    const SizedBox(width: AppSpacing.xs),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
