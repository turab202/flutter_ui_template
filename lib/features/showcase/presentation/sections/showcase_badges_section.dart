import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_badge.dart';
import '../showcase_section.dart';

class ShowcaseBadgesSection extends StatefulWidget {
  const ShowcaseBadgesSection({super.key});

  @override
  State<ShowcaseBadgesSection> createState() => _ShowcaseBadgesSectionState();
}

class _ShowcaseBadgesSectionState extends State<ShowcaseBadgesSection> {
  final Set<String> _selected = {'Flutter'};

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '7.6 Badges / Chips',
      subtitle: 'PDF Section 7.6 — 24pt height, 8pt padding, full/pill radius',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AppBadge — non-interactive status labels',
              style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: const [
              AppBadge(label: 'Primary', variant: AppBadgeVariant.primary),
              AppBadge(label: 'Secondary', variant: AppBadgeVariant.secondary),
              AppBadge(label: 'Success', variant: AppBadgeVariant.success),
              AppBadge(label: 'Error', variant: AppBadgeVariant.error),
              AppBadge(label: 'Warning', variant: AppBadgeVariant.warning),
              AppBadge(
                label: 'With Icon',
                variant: AppBadgeVariant.primary,
                leadingIcon: Icon(Icons.verified),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),
          Text('AppChip — interactive, selectable',
              style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: ['Flutter', 'Dart', 'Design', 'Mobile', 'UI'].map((tag) {
              final isSelected = _selected.contains(tag);
              return AppChip(
                label: tag,
                isSelected: isSelected,
                variant: AppBadgeVariant.primary,
                onTap: () => setState(() {
                  if (isSelected) {
                    _selected.remove(tag);
                  } else {
                    _selected.add(tag);
                  }
                }),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.sm),
          Text('NotificationDot — count overlay',
              style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_outlined, size: 28),
                  Positioned(
                    top: -4,
                    right: -6,
                    child: NotificationDot(count: 3),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.mail_outline, size: 28),
                  Positioned(
                    top: -4,
                    right: -6,
                    child: NotificationDot(count: 99),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.chat_bubble_outline, size: 28),
                  Positioned(
                    top: -4,
                    right: -6,
                    child: NotificationDot(count: 150),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
