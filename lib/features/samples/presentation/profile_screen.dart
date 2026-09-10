import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_divider.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../data/sample_data.dart';

// ============================================================
// PROFILE SCREEN
// 🎨 PROJECT-SPECIFIC — sample content only
// Matches reference: avatar, name, Pro Plan badge, stats row,
// About section with list tiles, Skills chips, Edit Profile btn.
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveConstrainedBox(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _ProfileHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                0,
                AppSpacing.sm,
                AppSpacing.xl,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _StatsRow(),
                  const SizedBox(height: AppSpacing.sm),
                  _AboutSection(),
                  const SizedBox(height: AppSpacing.sm),
                  _SkillsSection(),
                  const SizedBox(height: AppSpacing.sm),
                  _EditProfileButton(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE HEADER
// ============================================================

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
      ),
      child: Column(
        children: [
          // Top bar: title + edit icon
          Row(
            children: [
              Expanded(
                child: Text(
                  'Profile',
                  style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
                ),
              ),
              Semantics(
                label: 'Edit profile',
                button: true,
                child: InkWell(
                  onTap: () =>
                      showAppToast(context, message: 'Edit profile (demo)'),
                  borderRadius: AppRadius.fullAll,
                  child: const SizedBox(
                    width: AppConstants.minTouchTarget,
                    height: AppConstants.minTouchTarget,
                    child: Icon(
                      Icons.edit_outlined,
                      size: AppConstants.iconMd,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Avatar with online badge
          AppAvatar(
            initials: SampleData.userInitials,
            size: AppAvatarSize.lg,
            semanticLabel: SampleData.userName,
            badge: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),

          // Name + Pro Plan badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                SampleData.userName,
                style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            SampleData.userTitle,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xs),
          const AppBadge(
            label: '👑  Pro Plan',
            variant: AppBadgeVariant.warning,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            SampleData.userBio,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// STATS ROW
// ============================================================

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.borderDefault),
        boxShadow: AppShadows.elevation1,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _StatCell(
              value: '${SampleData.profileProjects}',
              label: 'Projects',
            ),
            const AppVerticalDivider(height: 40),
            _StatCell(
              value: '${SampleData.profileTasksDone}',
              label: 'Tasks Done',
            ),
            const AppVerticalDivider(height: 40),
            _StatCell(
              value: '${SampleData.profileTeamMembers}',
              label: 'Team Members',
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ABOUT SECTION — list tiles with chevrons
// ============================================================

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.borderDefault),
        boxShadow: AppShadows.elevation1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.sm,
              AppSpacing.sm,
              AppSpacing.xs,
            ),
            child: Text(
              'About',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
            ),
          ),
          _AboutRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: SampleData.userLocation,
          ),
          const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
          _AboutRow(
            icon: Icons.mail_outline_rounded,
            label: 'Email',
            value: SampleData.userEmail,
          ),
          const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
          _AboutRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: SampleData.userPhone,
          ),
          const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
          _AboutRow(
            icon: Icons.calendar_today_outlined,
            label: 'Joined',
            value: SampleData.userJoinDate,
          ),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  const _AboutRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: $value',
      button: true,
      child: InkWell(
        onTap: () => showAppToast(context, message: '$label (demo)'),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            children: [
              Icon(icon, size: AppConstants.iconSm, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: AppConstants.iconSm,
                color: AppColors.textDisabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SKILLS SECTION
// ============================================================

class _SkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.borderDefault),
        boxShadow: AppShadows.elevation1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills & Expertise',
            style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xxs,
            runSpacing: AppSpacing.xxs,
            children: SampleData.skills
                .map(
                  (s) => AppBadge(
                    label: s,
                    variant: AppBadgeVariant.primary,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EDIT PROFILE BUTTON
// ============================================================

class _EditProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: '✏️  Edit Profile',
      onPressed: () => showAppToast(context, message: 'Edit profile (demo)'),
      variant: AppButtonVariant.secondary,
      semanticLabel: 'Edit your profile',
    );
  }
}
