import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP BOTTOM SHEET
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.8
// ============================================================
//
// PDF Specifications (same as modal):
//   Radius:    20pt (top corners only)
//   Margin:    16pt (horizontal content padding)
//   Elevation: elevation-3 (0px 4px 16px rgba(0,0,0,0.12))
//   Overlay:   rgba(0,0,0,0.5)
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.showHandle = true,
    this.showCloseButton = false,
    this.onClose,
    this.contentPadding,
    this.maxHeightFraction = 0.9,
  });

  /// Optional sheet title in the header.
  final String? title;

  /// Sheet body content.
  final Widget child;

  /// Shows the drag handle at the top. Defaults to true.
  final bool showHandle;

  /// Shows a close icon button in the header.
  final bool showCloseButton;

  /// Called when the close button is tapped.
  final VoidCallback? onClose;

  /// Override content padding. Defaults to 16pt horizontal.
  final EdgeInsetsGeometry? contentPadding;

  /// Maximum height as a fraction of screen height.
  /// ⚙️ OPTIONAL — engineering decision, not in PDF.
  final double maxHeightFraction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // PDF: radius = 20pt (top corners)
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.lgTop,
        boxShadow: AppShadows.elevation3, // PDF: elevation-3
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * maxHeightFraction,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          if (showHandle)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderStrong,
                    borderRadius: AppRadius.fullAll,
                  ),
                ),
              ),
            ),

          // Header
          if (title != null || showCloseButton)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm, // PDF: 16pt horizontal margin
                AppSpacing.sm,
                AppSpacing.sm,
                0,
              ),
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
                      label: 'Close',
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
            ),

          // Body — scrollable
          Flexible(
            child: SingleChildScrollView(
              padding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: AppSpacing.modalMargin, // PDF: 16pt
                    vertical: AppSpacing.sm,
                  ),
              child: child,
            ),
          ),

          // Safe area bottom inset
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// showAppBottomSheet — convenience function.
// ⚙️ OPTIONAL — convenience wrapper.
// ----------------------------------------------------------

Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget sheet,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    // PDF Section 7.8: Overlay = rgba(0,0,0,0.5)
    barrierColor: AppColors.overlay,
    // PDF Section 10: Modals/sheets = 250–350ms
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: AppMotion.modal,
    ),
    builder: (_) => sheet,
  );
}
