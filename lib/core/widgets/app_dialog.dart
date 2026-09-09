import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_button.dart';

// ============================================================
// APP DIALOG / MODAL
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.8
// ============================================================
//
// PDF Specifications:
//   Radius:   20pt
//   Margin:   16pt
//   Elevation: elevation-3 (0px 4px 16px rgba(0,0,0,0.12))
//   Overlay:  rgba(0,0,0,0.5)
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    this.title,
    required this.content,
    this.primaryAction,
    this.primaryLabel,
    this.secondaryAction,
    this.secondaryLabel,
    this.onClose,
    this.showCloseButton = false,
    this.icon,
  });

  /// Optional dialog title.
  final String? title;

  /// Main dialog content widget.
  final Widget content;

  /// Primary button callback (confirm / accept).
  final VoidCallback? primaryAction;

  /// Label for the primary button.
  final String? primaryLabel;

  /// Secondary button callback (cancel / dismiss).
  final VoidCallback? secondaryAction;

  /// Label for the secondary button.
  final String? secondaryLabel;

  /// Called when the close icon is tapped (when showCloseButton = true).
  final VoidCallback? onClose;

  /// Shows an X close button in the top-right corner.
  final bool showCloseButton;

  /// Optional icon shown above the title.
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(AppSpacing.modalMargin), // PDF: 16pt
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: AppRadius.lgAll, // PDF: radius = 20pt
          boxShadow: AppShadows.elevation3, // PDF: elevation-3
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header row (title + optional close button)
            if (title != null || showCloseButton)
              _buildHeader(context),

            // Optional icon
            if (icon != null) ...[
              Center(child: icon!),
              const SizedBox(height: AppSpacing.sm),
            ],

            // Content
            DefaultTextStyle(
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
              child: content,
            ),

            // Action buttons
            if (primaryAction != null || secondaryAction != null) ...[
              const SizedBox(height: AppSpacing.md),
              _buildActions(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: AppTypography.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          if (showCloseButton)
            Semantics(
              label: 'Close dialog',
              button: true,
              child: InkWell(
                onTap: onClose ?? () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.xxs),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final hasSecondary = secondaryAction != null && secondaryLabel != null;
    final hasPrimary = primaryAction != null && primaryLabel != null;

    if (hasSecondary && hasPrimary) {
      return Row(
        children: [
          Expanded(
            child: AppButton(
              label: secondaryLabel!,
              onPressed: secondaryAction,
              variant: AppButtonVariant.secondary,
              size: AppButtonSize.small,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: AppButton(
              label: primaryLabel!,
              onPressed: primaryAction,
              variant: AppButtonVariant.primary,
              size: AppButtonSize.small,
            ),
          ),
        ],
      );
    }

    if (hasPrimary) {
      return AppButton(
        label: primaryLabel!,
        onPressed: primaryAction,
      );
    }

    if (hasSecondary) {
      return AppButton(
        label: secondaryLabel!,
        onPressed: secondaryAction,
        variant: AppButtonVariant.secondary,
      );
    }

    return const SizedBox.shrink();
  }
}

// ----------------------------------------------------------
// showAppDialog — convenience function
// Handles overlay opacity and animation automatically.
// ⚙️ OPTIONAL — convenience wrapper.
// ----------------------------------------------------------

Future<T?> showAppDialog<T>({
  required BuildContext context,
  required Widget dialog,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dismiss dialog',
    // PDF Section 7.8: Overlay = rgba(0,0,0,0.5)
    barrierColor: AppColors.overlay,
    // PDF Section 10: Modals/sheets = 250–350ms
    transitionDuration: AppMotion.modal,
    pageBuilder: (ctx, anim, secondAnim) => dialog,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final reduceMotion = AppMotion.shouldReduceMotion(context);
      if (reduceMotion) {
        return FadeTransition(opacity: animation, child: child);
      }
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: AppMotion.decelerate,
        ),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: AppMotion.decelerate),
          ),
          child: child,
        ),
      );
    },
  );
}
