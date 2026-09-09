import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/app_divider.dart';
import '../../../../core/widgets/app_list_tile.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../showcase_section.dart';

class ShowcaseOverlaysSection extends StatelessWidget {
  const ShowcaseOverlaysSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '7.8–7.9 Dialogs, Sheets & Toasts',
      subtitle:
          'PDF Sections 7.8–7.9 — radius 20pt, elevation-3, overlay rgba(0,0,0,0.5)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dialogs',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              AppButton(
                label: 'Alert Dialog',
                onPressed: () => showAppDialog(
                  context: context,
                  dialog: AppDialog(
                    title: 'Delete Item',
                    showCloseButton: true,
                    content: const Text(
                      'Are you sure you want to delete this item? '
                      'This action cannot be undone.',
                    ),
                    primaryLabel: 'Delete',
                    primaryAction: () => Navigator.of(context).pop(),
                    secondaryLabel: 'Cancel',
                    secondaryAction: () => Navigator.of(context).pop(),
                  ),
                ),
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.small,
                isFullWidth: false,
              ),
              AppButton(
                label: 'Form Dialog',
                onPressed: () => showAppDialog(
                  context: context,
                  dialog: AppDialog(
                    title: 'Edit Profile',
                    showCloseButton: true,
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextField(label: 'Name', hint: 'Your name'),
                        SizedBox(height: AppSpacing.xs),
                        AppTextField(label: 'Email', hint: 'your@email.com'),
                      ],
                    ),
                    primaryLabel: 'Save',
                    primaryAction: () => Navigator.of(context).pop(),
                    secondaryLabel: 'Cancel',
                    secondaryAction: () => Navigator.of(context).pop(),
                  ),
                ),
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.small,
                isFullWidth: false,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),
          Text('Bottom Sheet (radius 20pt, drag handle)',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.xs),
          AppButton(
            label: 'Open Bottom Sheet',
            onPressed: () => showAppBottomSheet(
              context: context,
              sheet: AppBottomSheet(
                title: 'Options',
                showCloseButton: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppListTile(
                      title: 'Edit',
                      leading: const Icon(Icons.edit_outlined),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const AppDivider(),
                    AppListTile(
                      title: 'Share',
                      leading: const Icon(Icons.share_outlined),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const AppDivider(),
                    AppListTile(
                      title: 'Delete',
                      leading: const Icon(Icons.delete_outline,
                          color: AppColors.error),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                  ],
                ),
              ),
            ),
            variant: AppButtonVariant.secondary,
            size: AppButtonSize.small,
            isFullWidth: false,
          ),

          const SizedBox(height: AppSpacing.sm),
          Text('Toasts / Snackbars (8pt radius, elevation-4, 3s auto-dismiss)',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              AppButton(
                label: 'Neutral',
                onPressed: () => showAppToast(context, message: 'Item saved successfully'),
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.small,
                isFullWidth: false,
              ),
              AppButton(
                label: 'Success',
                onPressed: () => showAppToast(
                  context,
                  message: 'Profile updated',
                  variant: AppToastVariant.success,
                ),
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.small,
                isFullWidth: false,
              ),
              AppButton(
                label: 'Error',
                onPressed: () => showAppToast(
                  context,
                  message: 'Network error. Please try again.',
                  variant: AppToastVariant.error,
                  actionLabel: 'Retry',
                  onAction: () {},
                ),
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.small,
                isFullWidth: false,
              ),
              AppButton(
                label: 'Warning',
                onPressed: () => showAppToast(
                  context,
                  message: 'Your session will expire soon',
                  variant: AppToastVariant.warning,
                ),
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.small,
                isFullWidth: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
