import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP BUTTON
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.1
// ============================================================
//
// PDF Specifications:
//   Primary large:   height 48pt, full width
//   Secondary small: height 40pt
//
//   States:
//     Default:  bg = primary, opacity 1
//     Pressed:  bg darkened 15–20% (NOT simple opacity fade)
//     Disabled: bg = #9CA3AF, text = white, must meet legibility
//     Loading:  bg unchanged + inline spinner, interaction blocked
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT (all sizing/color values)
//
// ============================================================

// ----------------------------------------------------------
// Button variant enum
// ----------------------------------------------------------

enum AppButtonVariant {
  /// Primary — filled, uses primary brand color.
  primary,

  /// Secondary — outlined, transparent background.
  secondary,

  /// Destructive — filled with error color.
  /// ⚙️ OPTIONAL — not explicitly named in PDF, derived from error token.
  destructive,

  /// Ghost — no border, no fill. Text only.
  /// ⚙️ OPTIONAL — engineering addition for low-emphasis actions.
  ghost,
}

// ----------------------------------------------------------
// Button size enum
// ----------------------------------------------------------

enum AppButtonSize {
  /// Large — 48pt height. PDF primary button spec.
  large,

  /// Small — 40pt height. PDF secondary button spec.
  small,
}

// ----------------------------------------------------------
// AppButton widget
// ----------------------------------------------------------

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.isLoading = false,
    this.isFullWidth = true,
    this.leadingIcon,
    this.trailingIcon,
    this.semanticLabel,
  });

  /// Button label text.
  final String label;

  /// Callback. Pass null to render the disabled state.
  final VoidCallback? onPressed;

  /// Visual variant. Defaults to primary.
  final AppButtonVariant variant;

  /// Size variant. Defaults to large (48pt).
  final AppButtonSize size;

  /// When true: spinner shown, interaction blocked, bg unchanged.
  /// PDF: "bg unchanged + inline spinner, interaction blocked."
  final bool isLoading;

  /// When true the button expands to full available width.
  final bool isFullWidth;

  /// Optional leading icon widget.
  final Widget? leadingIcon;

  /// Optional trailing icon widget.
  final Widget? trailingIcon;

  /// Override accessible label for screen readers.
  final String? semanticLabel;

  bool get _isDisabled => onPressed == null && !isLoading;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  // Height from PDF spec
  double get _height =>
      widget.size == AppButtonSize.large
          ? AppConstants.minButtonHeight   // 48pt
          : AppConstants.smallButtonHeight; // 40pt

  // ----------------------------------------------------------
  // Color resolution per state
  // PDF: pressed = bg darkened 15–20% (not opacity fade)
  //      disabled = #9CA3AF bg, white text
  // ----------------------------------------------------------
  Color get _backgroundColor {
    if (widget._isDisabled) return AppColors.disabledButton;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return _pressed ? AppColors.primaryPressed : AppColors.primary;
      case AppButtonVariant.secondary:
        return Colors.transparent;
      case AppButtonVariant.destructive:
        return _pressed
            ? const Color(0xFFB91C1C) // error darkened ~15%
            : AppColors.error;
      case AppButtonVariant.ghost:
        return _pressed
            ? AppColors.primary.withValues(alpha: 0.08)
            : Colors.transparent;
    }
  }

  Color get _foregroundColor {
    if (widget._isDisabled) return Colors.white;
    switch (widget.variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.destructive:
        return Colors.white;
      case AppButtonVariant.secondary:
        return _pressed ? AppColors.primaryPressed : AppColors.primary;
      case AppButtonVariant.ghost:
        return _pressed ? AppColors.primaryPressed : AppColors.primary;
    }
  }

  BorderSide? get _borderSide {
    if (widget.variant == AppButtonVariant.secondary) {
      if (widget._isDisabled) {
        return const BorderSide(color: AppColors.textDisabled, width: 1.5);
      }
      return BorderSide(
        color: _pressed ? AppColors.primaryPressed : AppColors.primary,
        width: 1.5,
      );
    }
    return BorderSide.none;
  }

  @override
  Widget build(BuildContext context) {
    final bool interactive = !widget._isDisabled && !widget.isLoading;

    Widget buttonContent = _ButtonContent(
      label: widget.label,
      isLoading: widget.isLoading,
      isDisabled: widget._isDisabled,
      foregroundColor: _foregroundColor,
      leadingIcon: widget.leadingIcon,
      trailingIcon: widget.trailingIcon,
      size: widget.size,
    );

    if (!widget.isFullWidth) {
      buttonContent = IntrinsicWidth(child: buttonContent);
    }

    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      button: true,
      enabled: interactive,
      child: AnimatedContainer(
        duration: AppMotion.micro,
        curve: AppMotion.standard,
        height: _height,
        width: widget.isFullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: AppRadius.smAll,
          border: _borderSide != null && _borderSide != BorderSide.none
              ? Border.fromBorderSide(_borderSide!)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: AppRadius.smAll,
          child: InkWell(
            onTap: interactive ? widget.onPressed : null,
            onTapDown: interactive ? (_) => setState(() => _pressed = true) : null,
            onTapUp: interactive ? (_) => setState(() => _pressed = false) : null,
            onTapCancel: interactive ? () => setState(() => _pressed = false) : null,
            borderRadius: AppRadius.smAll,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: buttonContent,
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Internal button content
// ----------------------------------------------------------

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.isLoading,
    required this.isDisabled,
    required this.foregroundColor,
    required this.size,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String label;
  final bool isLoading;
  final bool isDisabled;
  final Color foregroundColor;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    final hPadding = AppSpacing.sm;

    if (isLoading) {
      // PDF: "bg unchanged + inline spinner, interaction blocked"
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            IconTheme(
              data: IconThemeData(
                size: AppConstants.iconSm,
                color: foregroundColor,
              ),
              child: leadingIcon!,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: foregroundColor,
                fontSize: size == AppButtonSize.small ? 14.0 : 16.0,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: AppSpacing.xs),
            IconTheme(
              data: IconThemeData(
                size: AppConstants.iconSm,
                color: foregroundColor,
              ),
              child: trailingIcon!,
            ),
          ],
        ],
      ),
    );
  }
}
