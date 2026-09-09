import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP BADGE / CHIP
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.6
// ============================================================
//
// PDF Specifications:
//   Height:  24pt
//   Padding: 8pt (horizontal)
//   Radius:  full (pill)
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT (sizing/radius values)
// 🎨 PROJECT-SPECIFIC — colors per variant can be adapted.
//
// ============================================================

// ----------------------------------------------------------
// Badge color variant enum
// ⚙️ OPTIONAL — semantic color mapping not specified in PDF;
// derived from the PDF color token system.
// ----------------------------------------------------------
enum AppBadgeVariant {
  /// Uses primary color.
  primary,

  /// Uses secondary / neutral color.
  secondary,

  /// Uses success color.
  success,

  /// Uses error color.
  error,

  /// Uses warning color.
  warning,

  /// Custom — supply your own colors.
  custom,
}

// ----------------------------------------------------------
// AppBadge
// A non-interactive label / status badge.
// PDF Section 7.6: Height 24pt, Padding 8pt, Radius = full pill.
// ----------------------------------------------------------

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.primary,
    this.backgroundColor,
    this.foregroundColor,
    this.leadingIcon,
  });

  final String label;
  final AppBadgeVariant variant;

  /// Override background — required when variant is [AppBadgeVariant.custom].
  final Color? backgroundColor;

  /// Override text/icon color — required when variant is [AppBadgeVariant.custom].
  final Color? foregroundColor;

  /// Optional small icon before the label.
  final Widget? leadingIcon;

  _BadgeColors get _colors => _BadgeColors.forVariant(
        variant,
        customBg: backgroundColor,
        customFg: foregroundColor,
      );

  @override
  Widget build(BuildContext context) {
    final colors = _colors;

    return Semantics(
      label: label,
      child: Container(
        height: AppConstants.badgeHeight, // PDF: 24pt
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.badgePadding, // PDF: 8pt
        ),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: AppRadius.fullAll, // PDF: full pill
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              IconTheme(
                data: IconThemeData(
                  size: 12,
                  color: colors.foreground,
                ),
                child: leadingIcon!,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTypography.small.copyWith(
                color: colors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// AppChip
// An interactive, selectable/dismissible chip.
// PDF Section 7.6: same sizing as AppBadge + tap interaction.
// ----------------------------------------------------------

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.primary,
    this.isSelected = false,
    this.onTap,
    this.onDeleted,
    this.leadingIcon,
    this.semanticLabel,
  });

  final String label;
  final AppBadgeVariant variant;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final Widget? leadingIcon;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = _BadgeColors.forVariant(variant);
    final bgColor = isSelected ? colors.background : AppColors.surface;
    final fgColor = isSelected ? colors.foreground : AppColors.textSecondary;

    return Semantics(
      label: semanticLabel ?? label,
      button: onTap != null,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: AppConstants.badgeHeight, // PDF: 24pt
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.badgePadding, // PDF: 8pt
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: AppRadius.fullAll, // PDF: full pill
            border: Border.all(
              color: isSelected ? colors.background : AppColors.borderDefault,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                IconTheme(
                  data: IconThemeData(size: 12, color: fgColor),
                  child: leadingIcon!,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: AppTypography.small.copyWith(color: fgColor),
              ),
              if (onDeleted != null) ...[
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: onDeleted,
                  child: Semantics(
                    label: 'Remove $label',
                    button: true,
                    child: Icon(
                      Icons.close,
                      size: 12,
                      color: fgColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// _BadgeColors — internal color resolver
// ----------------------------------------------------------

class _BadgeColors {
  const _BadgeColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;

  static _BadgeColors forVariant(
    AppBadgeVariant variant, {
    Color? customBg,
    Color? customFg,
  }) {
    switch (variant) {
      case AppBadgeVariant.primary:
        return _BadgeColors(
          background: AppColors.primary.withValues(alpha: 0.12),
          foreground: AppColors.primary,
        );
      case AppBadgeVariant.secondary:
        return _BadgeColors(
          background: AppColors.secondary.withValues(alpha: 0.12),
          foreground: AppColors.secondary,
        );
      case AppBadgeVariant.success:
        return _BadgeColors(
          background: AppColors.success.withValues(alpha: 0.12),
          foreground: AppColors.success,
        );
      case AppBadgeVariant.error:
        return _BadgeColors(
          background: AppColors.error.withValues(alpha: 0.12),
          foreground: AppColors.error,
        );
      case AppBadgeVariant.warning:
        return _BadgeColors(
          background: AppColors.warning.withValues(alpha: 0.12),
          foreground: AppColors.warning,
        );
      case AppBadgeVariant.custom:
        return _BadgeColors(
          background: customBg ?? AppColors.surface,
          foreground: customFg ?? AppColors.textPrimary,
        );
    }
  }
}

// ----------------------------------------------------------
// NotificationDot
// A small circular badge for unread counts / notification dots.
// ⚙️ OPTIONAL — common UI pattern derived from badge tokens.
// ----------------------------------------------------------

class NotificationDot extends StatelessWidget {
  const NotificationDot({
    super.key,
    this.count,
    this.color,
  });

  /// When null, renders a plain dot (no number).
  final int? count;

  /// Defaults to error color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? AppColors.error;
    final hasCount = count != null && count! > 0;
    final label = hasCount ? (count! > 99 ? '99+' : '$count') : null;

    return Container(
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      padding: hasCount
          ? const EdgeInsets.symmetric(horizontal: 4)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: bg,
        shape: label == null ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: label != null ? AppRadius.fullAll : null,
      ),
      child: label != null
          ? Center(
              child: Text(
                label,
                style: AppTypography.small.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            )
          : null,
    );
  }
}
