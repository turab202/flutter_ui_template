import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_divider.dart';
import '../../../../core/widgets/app_list_tile.dart';
import '../showcase_section.dart';

class ShowcaseCardsSection extends StatelessWidget {
  const ShowcaseCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '7.3 Cards',
      subtitle:
          'PDF Section 7.3 — 16pt padding, 12pt radius, elevation-1, pressable state',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Static card — elevation-1',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xxs),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Title', style: AppTypography.h3),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'Card body text using the Body style at 16pt. '
                  'Cards have 16pt padding and 12pt corner radius.',
                  style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          Text('Pressable card — bg darkens 4–6% on press',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xxs),
          AppCard(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.article_outlined,
                      color: AppColors.primary),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pressable Card', style: AppTypography.h3.copyWith(fontSize: 16)),
                      Text('Tap to see pressed state',
                          style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right,
                    color: AppColors.textSecondary),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          Text('Surface card — uses surface color (#F3F4F6)',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xxs),
          AppSurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Surface Card', style: AppTypography.h3.copyWith(fontSize: 16)),
                const SizedBox(height: AppSpacing.xxs),
                Text('Uses surface color for nested cards on white backgrounds.',
                    style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          Text('7.4 List Items — 56pt single-line, 72pt two-line, 16pt padding',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xxs),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderDefault),
            ),
            child: Column(
              children: [
                AppListTile(
                  title: 'Single-line item (56pt)',
                  leading: const Icon(Icons.inbox_outlined,
                      color: AppColors.primary),
                  trailing: const Icon(Icons.chevron_right,
                      color: AppColors.textSecondary),
                  onTap: () {},
                ),
                const AppDivider(indent: 56),
                AppListTile(
                  title: 'Two-line item (72pt)',
                  subtitle: 'Secondary text below the main title',
                  leading: const Icon(Icons.star_outline,
                      color: AppColors.warning),
                  trailing: const Icon(Icons.chevron_right,
                      color: AppColors.textSecondary),
                  onTap: () {},
                ),
                const AppDivider(indent: 56),
                const AppListTile(
                  title: 'Disabled item',
                  subtitle: 'Cannot be tapped',
                  isEnabled: false,
                  leading: Icon(Icons.block_outlined),
                ),
                const AppDivider(indent: 56),
                AppListTile(
                  title: 'Selected item',
                  isSelected: true,
                  leading: const Icon(Icons.check_circle_outline,
                      color: AppColors.primary),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
