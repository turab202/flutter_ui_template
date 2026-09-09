import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../showcase_section.dart';

class ShowcaseButtonsSection extends StatefulWidget {
  const ShowcaseButtonsSection({super.key});

  @override
  State<ShowcaseButtonsSection> createState() => _ShowcaseButtonsSectionState();
}

class _ShowcaseButtonsSectionState extends State<ShowcaseButtonsSection> {
  bool _loading = false;

  void _simulateLoad() {
    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '7.1 Buttons',
      subtitle: 'PDF Section 7.1 — All variants, sizes, and states',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary
          _Label('Primary (large, 48pt, full-width)'),
          const SizedBox(height: AppSpacing.xxs),
          AppButton(label: 'Primary Button', onPressed: () {}),
          const SizedBox(height: AppSpacing.xs),

          _Label('Primary — Pressed state (darkened 15–20%, not opacity)'),
          const SizedBox(height: AppSpacing.xxs),
          const AppButton(label: 'Hold to see pressed state', onPressed: null),
          // Note: actual pressed state is interaction-driven on the live widget above.

          const SizedBox(height: AppSpacing.xs),
          _Label('Primary — Loading state (spinner, interaction blocked)'),
          const SizedBox(height: AppSpacing.xxs),
          AppButton(
            label: 'Tap to load',
            onPressed: _loading ? null : _simulateLoad,
            isLoading: _loading,
          ),

          const SizedBox(height: AppSpacing.xs),
          _Label('Primary — Disabled state (bg #9CA3AF, white text)'),
          const SizedBox(height: AppSpacing.xxs),
          const AppButton(label: 'Disabled Button', onPressed: null),

          const SizedBox(height: AppSpacing.sm),
          // Secondary
          _Label('Secondary (small, 40pt)'),
          const SizedBox(height: AppSpacing.xxs),
          AppButton(
            label: 'Secondary Button',
            onPressed: () {},
            variant: AppButtonVariant.secondary,
            size: AppButtonSize.small,
          ),
          const SizedBox(height: AppSpacing.xs),
          _Label('Secondary — Disabled'),
          const SizedBox(height: AppSpacing.xxs),
          const AppButton(
            label: 'Secondary Disabled',
            onPressed: null,
            variant: AppButtonVariant.secondary,
            size: AppButtonSize.small,
          ),

          const SizedBox(height: AppSpacing.sm),
          // Destructive
          _Label('Destructive'),
          const SizedBox(height: AppSpacing.xxs),
          AppButton(
            label: 'Delete Item',
            onPressed: () {},
            variant: AppButtonVariant.destructive,
            isFullWidth: false,
          ),

          const SizedBox(height: AppSpacing.sm),
          // Ghost
          _Label('Ghost'),
          const SizedBox(height: AppSpacing.xxs),
          AppButton(
            label: 'Cancel',
            onPressed: () {},
            variant: AppButtonVariant.ghost,
            isFullWidth: false,
          ),

          const SizedBox(height: AppSpacing.sm),
          // With icons
          _Label('With Icons'),
          const SizedBox(height: AppSpacing.xxs),
          AppButton(
            label: 'Add to Cart',
            onPressed: () {},
            isFullWidth: false,
            leadingIcon: const Icon(Icons.add_shopping_cart_outlined),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
      );
}
