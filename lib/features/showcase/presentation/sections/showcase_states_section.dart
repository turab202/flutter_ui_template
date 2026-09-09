import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../showcase_section.dart';

class ShowcaseStatesSection extends StatelessWidget {
  const ShowcaseStatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '7.10–7.11 States',
      subtitle: 'PDF Sections 7.10–7.11 — Empty, Error, Loading, Skeleton',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Empty State
          _label('7.10 Empty State — 48pt vertical padding, centered, icon+title+body+CTA'),
          const SizedBox(height: AppSpacing.xxs),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderDefault),
              borderRadius: BorderRadius.circular(12),
            ),
            child: AppEmptyState(
              icon: const Icon(Icons.inbox_outlined),
              title: 'No messages yet',
              body: 'When someone sends you a message, it will appear here.',
              ctaLabel: 'Start a conversation',
              onCtaTap: () {},
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Error State
          _label('Error State — mirrors empty state layout with error tokens'),
          const SizedBox(height: AppSpacing.xxs),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderDefault),
              borderRadius: BorderRadius.circular(12),
            ),
            child: AppErrorState(
              title: 'Failed to load',
              body: 'Check your connection and try again.',
              onRetry: () {},
              secondaryLabel: 'Go Back',
              onSecondaryAction: () {},
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Loading indicator
          _label('Inline Loading Indicator'),
          const SizedBox(height: AppSpacing.xs),
          const Row(
            children: [
              AppLoadingIndicator(size: 16, strokeWidth: 2),
              SizedBox(width: AppSpacing.xs),
              AppLoadingIndicator(size: 24),
              SizedBox(width: AppSpacing.xs),
              AppLoadingIndicator(size: 40, strokeWidth: 3),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Skeletons — shapes match content
          _label(
            '7.11 Skeletons — shimmer, shapes match content (never generic gray block)',
          ),
          const SizedBox(height: AppSpacing.xs),
          ShimmerScope(
            child: Column(
              children: [
                // Card skeleton
                const SkeletonCard(),
                const SizedBox(height: AppSpacing.xs),
                // List tile skeletons
                const SkeletonListTile(showSubtitle: true),
                const SkeletonListTile(showSubtitle: true),
                const SkeletonListTile(),
                const SizedBox(height: AppSpacing.xs),
                // Paragraph skeleton
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderDefault),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paragraph skeleton:',
                        style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const SkeletonParagraph(lines: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
      );
}
