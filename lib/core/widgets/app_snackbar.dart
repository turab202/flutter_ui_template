import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP SNACKBAR / TOAST
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.9
// ============================================================
//
// PDF Specifications:
//   Radius:       8pt
//   Elevation:    elevation-4 (0px 8px 24px rgba(0,0,0,0.16))
//   Position:     bottom-anchored
//   Auto-dismiss: 3–4 seconds
//   Dismissible:  by swipe
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

// ----------------------------------------------------------
// Toast variant — maps to semantic color tokens.
// ⚙️ OPTIONAL — semantic variants derived from PDF color tokens.
// ----------------------------------------------------------
enum AppToastVariant {
  /// Dark background (default). Used for neutral messages.
  neutral,

  /// Success — uses success color token.
  success,

  /// Error — uses error color token.
  error,

  /// Warning — uses warning color token.
  warning,
}

// ----------------------------------------------------------
// showAppToast — primary API for displaying toasts/snackbars.
// PDF: bottom-anchored, auto-dismiss 3–4s, dismissible by swipe.
// ----------------------------------------------------------

void showAppToast(
  BuildContext context, {
  required String message,
  AppToastVariant variant = AppToastVariant.neutral,
  String? actionLabel,
  VoidCallback? onAction,
  Duration duration = AppConstants.toastDuration, // PDF: 3–4 seconds
}) {
  final colors = _ToastColors.forVariant(variant);

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            // Leading icon per variant
            if (_leadingIcon(variant) != null) ...[
              Icon(
                _leadingIcon(variant),
                size: 18,
                color: colors.foreground,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Expanded(
              child: Text(
                message,
                style: AppTypography.body.copyWith(
                  color: colors.foreground,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colors.background,
        // PDF: radius = 8pt
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.smAll,
        ),
        // PDF: elevation-4
        elevation: AppShadows.elevationValue4,
        // PDF: floating (bottom-anchored)
        behavior: SnackBarBehavior.floating,
        // PDF: auto-dismiss 3–4 seconds
        duration: duration,
        // PDF: dismissible by swipe (built into Flutter SnackBar)
        dismissDirection: DismissDirection.down,
        margin: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          0,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        action: onAction != null && actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: colors.actionColor,
                onPressed: onAction,
              )
            : null,
      ),
    );
}

// ----------------------------------------------------------
// Helper functions
// ----------------------------------------------------------

IconData? _leadingIcon(AppToastVariant variant) {
  switch (variant) {
    case AppToastVariant.success: return Icons.check_circle_outline;
    case AppToastVariant.error:   return Icons.error_outline;
    case AppToastVariant.warning: return Icons.warning_amber_outlined;
    case AppToastVariant.neutral: return null;
  }
}

class _ToastColors {
  const _ToastColors({
    required this.background,
    required this.foreground,
    required this.actionColor,
  });

  final Color background;
  final Color foreground;
  final Color actionColor;

  static _ToastColors forVariant(AppToastVariant variant) {
    switch (variant) {
      case AppToastVariant.neutral:
        return const _ToastColors(
          background: AppColors.textPrimary, // #111827 — dark neutral
          foreground: Colors.white,
          actionColor: Color(0xFF93C5FD), // light blue action
        );
      case AppToastVariant.success:
        return _ToastColors(
          background: AppColors.success.withValues(alpha: 0.95),
          foreground: Colors.white,
          actionColor: Colors.white70,
        );
      case AppToastVariant.error:
        return _ToastColors(
          background: AppColors.error.withValues(alpha: 0.95),
          foreground: Colors.white,
          actionColor: Colors.white70,
        );
      case AppToastVariant.warning:
        return _ToastColors(
          background: AppColors.warning.withValues(alpha: 0.95),
          foreground: Colors.white,
          actionColor: Colors.white70,
        );
    }
  }
}
