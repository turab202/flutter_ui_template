import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP TEXT FIELD
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.2
// ============================================================
//
// PDF Specifications:
//   Height:  48pt minimum
//   Padding: 12pt
//
//   States:
//     Default:  border = border-default (#E5E7EB)
//     Focused:  border = primary (#0066CC), width 2pt
//     Error:    border = error (#DC2626), helper text below in error color
//     Disabled: bg = disabled-bg (#F3F4F6), border = border-default,
//               text = text-disabled (#9CA3AF)
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.semanticLabel,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// Floating label above the field.
  final String? label;

  /// Placeholder text when the field is empty.
  final String? hint;

  /// Helper text below the field (neutral state).
  final String? helperText;

  /// Error message. When non-null, switches to error state.
  /// PDF: "border = error, helper text below in error color."
  final String? errorText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  /// When false, renders disabled state.
  /// PDF: "bg = disabled-bg, border = border-default, text = text-disabled."
  final bool isEnabled;

  final bool isReadOnly;

  /// Hides input for password fields.
  final bool obscureText;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final GestureTapCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  /// Use > 1 for multiline text areas.
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;

  /// Override screen-reader label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label ?? hint,
      textField: true,
      enabled: isEnabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppConstants.minInputHeight, // PDF: 48pt
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              enabled: isEnabled,
              readOnly: isReadOnly,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              onChanged: onChanged,
              onFieldSubmitted: onSubmitted,
              onTap: onTap,
              inputFormatters: inputFormatters,
              maxLines: obscureText ? 1 : maxLines,
              minLines: minLines,
              maxLength: maxLength,
              autofocus: autofocus,
              style: AppTypography.body.copyWith(
                color: isEnabled
                    ? AppColors.textPrimary
                    : AppColors.textDisabled, // PDF: text = text-disabled
              ),
              decoration: _buildDecoration(),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildDecoration() {
    // Disabled fill color — PDF: bg = disabled-bg (#F3F4F6)
    final fillColor = isEnabled ? AppColors.background : AppColors.disabledBg;

    return InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helperText,
      errorText: errorText,
      filled: true,
      fillColor: fillColor,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.inputPaddingHorizontal,
              ),
              child: IconTheme(
                data: const IconThemeData(
                  size: AppConstants.iconMd,
                  color: AppColors.textSecondary,
                ),
                child: prefixIcon!,
              ),
            )
          : null,
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.inputPaddingHorizontal,
              ),
              child: IconTheme(
                data: const IconThemeData(
                  size: AppConstants.iconMd,
                  color: AppColors.textSecondary,
                ),
                child: suffixIcon!,
              ),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(
        minWidth: AppConstants.minTouchTarget,
        minHeight: AppConstants.minInputHeight,
      ),
      suffixIconConstraints: const BoxConstraints(
        minWidth: AppConstants.minTouchTarget,
        minHeight: AppConstants.minInputHeight,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.inputPaddingHorizontal, // PDF: 12pt
        vertical: AppSpacing.inputPaddingVertical,     // PDF: 12pt
      ),
      // Default border — PDF: border = border-default
      border: const OutlineInputBorder(
        borderRadius: AppRadius.smAll,
        borderSide: BorderSide(color: AppColors.borderDefault),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.smAll,
        borderSide: BorderSide(color: AppColors.borderDefault),
      ),
      // Focused border — PDF: border = primary, width 2pt
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.smAll,
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      // Error border — PDF: border = error
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.smAll,
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.smAll,
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      // Disabled border — PDF: border = border-default
      disabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.smAll,
        borderSide: BorderSide(color: AppColors.borderDefault),
      ),
      hintStyle: AppTypography.body.copyWith(color: AppColors.textDisabled),
      labelStyle: AppTypography.caption.copyWith(color: AppColors.textSecondary),
      floatingLabelStyle: AppTypography.caption.copyWith(color: AppColors.primary),
      errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
      helperStyle: AppTypography.caption.copyWith(color: AppColors.textSecondary),
    );
  }
}

// ----------------------------------------------------------
// AppPasswordField
// TextField variant for passwords with built-in visibility toggle.
// ⚙️ OPTIONAL — convenience wrapper, not specified in PDF.
// ----------------------------------------------------------

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.controller,
    this.focusNode,
    this.label = 'Password',
    this.hint,
    this.helperText,
    this.errorText,
    this.isEnabled = true,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final bool isEnabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      label: widget.label,
      hint: widget.hint,
      helperText: widget.helperText,
      errorText: widget.errorText,
      isEnabled: widget.isEnabled,
      obscureText: _obscure,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      suffixIcon: IconButton(
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscure = !_obscure),
        tooltip: _obscure ? 'Show password' : 'Hide password',
      ),
    );
  }
}
