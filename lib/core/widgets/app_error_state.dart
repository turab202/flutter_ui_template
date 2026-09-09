import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_button.dart';

// ============================================================
// APP ERROR STATE
// Source: Mobile App UI Consistency Guide v2.0 — Section 12
// ============================================================
//
// PDF Section 12 (Common Pitfalls):
//   "Missing loading/error states on inputs and buttons"
//
// The PDF does not define a standalone error-state component
// spec beyond noting its requirement. This widget follows the
// Empty State layout pattern (Section 7.10) with error color
// tokens. It is an engineering addition.
// ⚙️ OPTIONAL — layout mirrors Empty State pattern (7.10).
//
// ============================================================

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    this.title = 'Something went wrong',
    this.body,
    this.icon,
    this.retryLabel = 'Try Again',
    this.onRetry,
    this.secondaryLabel,
    this.onSecondaryAction,
  });

  /// 🎨 PROJECT-SPECIFIC: Error heading text.
  final String title;

  /// 🎨 PROJECT-SPECIFIC: Descriptive error detail.
  final String? body;

  /// 🎨 PROJECT-SPECIFIC: Error illustration/icon.
  /// ⚙️ Defaults to a generic error icon when not provided.
  final Widget? icon;

  /// Retry button label.
  final String retryLabel;

  /// Retry callback. When null the retry button is not shown.
  final VoidCallback? onRetry;

  /// Optional secondary action label (e.g. "Go Home").
  final String? secondaryLabel;

  final VoidCallback? onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Error: $title',
      liveRegion: true,
      child: Padding(
        // Mirrors Empty State vertical padding — PDF 7.10: 48pt (xl).
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
            IconTheme(
              data: const IconThemeData(
                size: 64,
                color: AppColors.error,
              ),
              child: icon ?? const Icon(Icons.error_outline_rounded),
            ),
            const SizedBox(height: AppSpacing.md),

            // Title
            Text(
              title,
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),

            // Body
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

            // Retry CTA
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: retryLabel,
                onPressed: onRetry,
                isFullWidth: false,
              ),
            ],

            // Secondary CTA
            if (secondaryLabel != null && onSecondaryAction != null) ...[
              const SizedBox(height: AppSpacing.xs),
              AppButton(
                label: secondaryLabel!,
                onPressed: onSecondaryAction,
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

// ----------------------------------------------------------
// AppInlineError — compact error for use inside forms/cards.
// ⚙️ OPTIONAL — engineering addition for inline error banners.
// ----------------------------------------------------------

class AppInlineError extends StatelessWidget {
  const AppInlineError({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.error.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.error_outline,
              size: 16,
              color: AppColors.error,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                message,
                style: AppTypography.caption.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(width: AppSpacing.xs),
              GestureDetector(
                onTap: onRetry,
                child: Text(
                  'Retry',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
