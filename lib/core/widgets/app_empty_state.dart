import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_button.dart';

// ============================================================
// APP EMPTY STATE
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.10
// ============================================================
//
// PDF Specifications:
//   Vertical padding: 48pt (xl)
//   Centered layout
//   Structure: Icon + Title + Body copy + optional CTA
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT (padding/layout/structure)
// 🎨 PROJECT-SPECIFIC — icon, title, body, CTA per use case.
//
// ============================================================

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.body,
    this.icon,
    this.ctaLabel,
    this.onCtaTap,
    this.secondaryCtaLabel,
    this.onSecondaryCtaTap,
    this.iconColor,
  });

  /// 🎨 PROJECT-SPECIFIC: Describe what is empty.
  final String title;

  /// 🎨 PROJECT-SPECIFIC: Explain why and what to do.
  final String? body;

  /// 🎨 PROJECT-SPECIFIC: Illustrative icon.
  /// PDF: "Icon + title + body copy + optional CTA, centered."
  final Widget? icon;

  /// 🎨 PROJECT-SPECIFIC: Primary CTA button label.
  final String? ctaLabel;

  /// 🎨 PROJECT-SPECIFIC: Primary CTA callback.
  final VoidCallback? onCtaTap;

  /// Secondary CTA label.
  /// ⚙️ OPTIONAL — engineering addition.
  final String? secondaryCtaLabel;

  /// Secondary CTA callback.
  final VoidCallback? onSecondaryCtaTap;

  /// Icon color override.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Empty state: $title',
      child: Padding(
        // PDF: Vertical padding = 48pt (xl)
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.emptyStatePadding, // 48pt
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  size: 64,
                  color: iconColor ?? AppColors.textDisabled,
                ),
                child: icon!,
              ),
              const SizedBox(height: AppSpacing.md),
            ],

            // Title
            Text(
              title,
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),

            // Body copy
            if (body != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                body!,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Primary CTA
            if (ctaLabel != null && onCtaTap != null) ...[
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: ctaLabel!,
                onPressed: onCtaTap,
                isFullWidth: false,
              ),
            ],

            // Secondary CTA
            if (secondaryCtaLabel != null && onSecondaryCtaTap != null) ...[
              const SizedBox(height: AppSpacing.xs),
              AppButton(
                label: secondaryCtaLabel!,
                onPressed: onSecondaryCtaTap,
                variant: AppButtonVariant.ghost,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
