import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../showcase_section.dart';

class ShowcaseAvatarsIconsSection extends StatelessWidget {
  const ShowcaseAvatarsIconsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '7.12 Icons & Avatars',
      subtitle:
          'PDF Section 7.12 — Icons: 16/20/24/32pt, stroke 1.5pt. '
          'Avatars: 24/32/40/56/96pt',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icons
          Text('Icons — standard sizes (stroke width defined in design tokens)',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _IconSample(size: AppConstants.iconXs, label: '16pt'),
              _IconSample(size: AppConstants.iconSm, label: '20pt'),
              _IconSample(size: AppConstants.iconMd, label: '24pt'),
              _IconSample(size: AppConstants.iconLg, label: '32pt'),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Avatars — initials
          Text('Avatars (initials) — 24 / 32 / 40 / 56 / 96pt',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              AppAvatar(initials: 'AB', size: AppAvatarSize.xxs, semanticLabel: 'AB avatar 24pt'),
              SizedBox(width: AppSpacing.xs),
              AppAvatar(initials: 'CD', size: AppAvatarSize.xs, semanticLabel: 'CD avatar 32pt'),
              SizedBox(width: AppSpacing.xs),
              AppAvatar(initials: 'EF', size: AppAvatarSize.sm, semanticLabel: 'EF avatar 40pt'),
              SizedBox(width: AppSpacing.xs),
              AppAvatar(initials: 'GH', size: AppAvatarSize.md, semanticLabel: 'GH avatar 56pt'),
              SizedBox(width: AppSpacing.xs),
              AppAvatar(initials: 'IJ', size: AppAvatarSize.lg, semanticLabel: 'IJ avatar 96pt'),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Avatars — icon fallback
          Text('Avatars (icon fallback)',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: const [
              AppAvatar(size: AppAvatarSize.sm, semanticLabel: 'Default avatar'),
              SizedBox(width: AppSpacing.xs),
              AppAvatar(
                size: AppAvatarSize.sm,
                icon: Icon(Icons.business),
                backgroundColor: Color(0xFFEDE9FE),
                foregroundColor: Color(0xFF7C3AED),
                semanticLabel: 'Business avatar',
              ),
              SizedBox(width: AppSpacing.xs),
              AppAvatar(
                size: AppAvatarSize.sm,
                icon: Icon(Icons.support_agent),
                backgroundColor: Color(0xFFFEF3C7),
                foregroundColor: Color(0xFFD97706),
                semanticLabel: 'Support avatar',
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Avatar with badge
          Text('Avatar with badge overlay',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              AppAvatar(
                initials: 'AK',
                size: AppAvatarSize.md,
                semanticLabel: 'AK with online badge',
                badge: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // AvatarGroup
          Text('AvatarGroup — overlapping stack',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.xs),
          AvatarGroup(
            size: AppAvatarSize.xs,
            avatars: const [
              AppAvatar(initials: 'AA', size: AppAvatarSize.xs),
              AppAvatar(initials: 'BB', size: AppAvatarSize.xs),
              AppAvatar(initials: 'CC', size: AppAvatarSize.xs),
              AppAvatar(initials: 'DD', size: AppAvatarSize.xs),
              AppAvatar(initials: 'EE', size: AppAvatarSize.xs),
              AppAvatar(initials: 'FF', size: AppAvatarSize.xs),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconSample extends StatelessWidget {
  const _IconSample({required this.size, required this.label});
  final double size;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.home_outlined, size: size, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(label,
            style: AppTypography.small.copyWith(
                color: AppColors.textSecondary)),
      ],
    );
  }
}
