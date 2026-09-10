import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_divider.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../data/sample_data.dart';

// ============================================================
// DASHBOARD / HOME SCREEN
// 🎨 PROJECT-SPECIFIC — sample content only
// Consumes the design system; does not define its own tokens.
// ============================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveConstrainedBox(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _DashboardHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.sm,
                AppSpacing.xl,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _CurrentProjectCard(),
                  const SizedBox(height: AppSpacing.sm),
                  _QuickActionsRow(),
                  const SizedBox(height: AppSpacing.md),
                  _ProjectOverviewSection(),
                  const SizedBox(height: AppSpacing.md),
                  _RecentActivitySection(),
                  const SizedBox(height: AppSpacing.md),
                  _UpcomingDeadlinesSection(),
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
// HEADER
// ============================================================

class _DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning,',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      SampleData.userName,
                      style: AppTypography.h2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    const Text('👋', style: TextStyle(fontSize: 22)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  "Here's what's happening with your workspace today.",
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          _HeaderAction(
            icon: Icons.search_rounded,
            semanticLabel: 'Search',
            onTap: () => showAppToast(context, message: 'Search (demo)'),
          ),
          const SizedBox(width: AppSpacing.xxs),
          _HeaderAction(
            icon: Icons.notifications_outlined,
            semanticLabel: 'Notifications',
            onTap: () => showAppToast(context, message: '3 new notifications'),
            badge: true,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Semantics(
            label: 'Profile',
            button: true,
            child: GestureDetector(
              onTap: () => showAppToast(context, message: 'Profile (demo)'),
              child: const AppAvatar(
                initials: SampleData.userInitials,
                size: AppAvatarSize.sm,
                semanticLabel: SampleData.userName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({
    required this.icon,
    required this.semanticLabel,
    required this.onTap,
    this.badge = false,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.fullAll,
        child: SizedBox(
          width: AppConstants.minTouchTarget,
          height: AppConstants.minTouchTarget,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, size: AppConstants.iconMd, color: AppColors.textPrimary),
              if (badge)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CURRENT PROJECT CARD — blue filled card
// ============================================================

class _CurrentProjectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int pct = (SampleData.currentProjectProgress * 100).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppRadius.mdAll,
        boxShadow: AppShadows.elevation2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  borderRadius: AppRadius.smAll,
                ),
                child: const Icon(
                  Icons.work_outline_rounded,
                  color: Colors.white,
                  size: AppConstants.iconSm,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  SampleData.currentProjectLabel,
                  style: AppTypography.caption.copyWith(
                    color: Colors.white.withValues(alpha: 0.80),
                  ),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            SampleData.currentProjectName,
            style: AppTypography.h3.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: AppRadius.fullAll,
                  child: LinearProgressIndicator(
                    value: SampleData.currentProjectProgress,
                    minHeight: 6,
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '$pct%',
                style: AppTypography.small.copyWith(
                  color: Colors.white,
                  fontWeight: AppTypography.weightSemibold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            '${SampleData.currentProjectTasks} • ${SampleData.currentProjectDue}',
            style: AppTypography.small.copyWith(
              color: Colors.white.withValues(alpha: 0.80),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// QUICK ACTIONS ROW
// ============================================================

class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: SampleData.quickActions.map((action) {
        return _QuickActionItem(action: action);
      }).toList(),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({required this.action});
  final QuickAction action;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: action.label,
      button: true,
      child: InkWell(
        onTap: () => showAppToast(context, message: '${action.label} (demo)'),
        borderRadius: AppRadius.mdAll,
        child: SizedBox(
          width: 72,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppRadius.mdAll,
                  border: Border.all(color: AppColors.borderDefault),
                ),
                child: Icon(
                  IconData(action.iconCodePoint, fontFamily: 'MaterialIcons'),
                  size: AppConstants.iconMd,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                action.label,
                style: AppTypography.small.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PROJECT OVERVIEW — stat cards grid
// ============================================================

class _ProjectOverviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Project Overview',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
            ),
            Semantics(
              label: 'View all projects',
              button: true,
              child: GestureDetector(
                onTap: () => showAppToast(context, message: 'View all (demo)'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxs,
                    vertical: AppSpacing.xxs,
                  ),
                  child: Text(
                    'View all',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: AppTypography.weightMedium,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: SampleData.stats.asMap().entries.map((entry) {
            final i = entry.key;
            final stat = entry.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: i == 0 ? 0 : AppSpacing.xxs,
                  right: i == SampleData.stats.length - 1 ? 0 : AppSpacing.xxs,
                ),
                child: _StatCard(stat: stat),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});
  final DashboardStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.borderDefault),
        boxShadow: AppShadows.elevation1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: AppConstants.iconSm,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            stat.value,
            style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: AppTypography.small.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              Icon(
                stat.isPositive
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 10,
                color: stat.isPositive ? AppColors.success : AppColors.error,
              ),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  stat.delta,
                  style: AppTypography.small.copyWith(
                    color: stat.isPositive ? AppColors.success : AppColors.error,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// RECENT ACTIVITY
// ============================================================

class _RecentActivitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: AppRadius.mdAll,
            border: Border.all(color: AppColors.borderDefault),
            boxShadow: AppShadows.elevation1,
          ),
          child: Column(
            children: SampleData.activities.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  _ActivityRow(item: item),
                  if (i < SampleData.activities.length - 1)
                    const AppDivider(indent: AppSpacing.xl + AppSpacing.xs),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.item});
  final ActivityItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.isFile
              ? Container(
                  width: AppConstants.avatarSm,
                  height: AppConstants.avatarSm,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: AppRadius.smAll,
                  ),
                  child: const Icon(
                    Icons.insert_drive_file_outlined,
                    size: AppConstants.iconSm,
                    color: AppColors.primary,
                  ),
                )
              : AppAvatar(
                  initials: item.actorInitials,
                  size: AppAvatarSize.sm,
                  semanticLabel: item.actorName,
                ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      TextSpan(
                        text: item.actorName,
                        style: const TextStyle(
                          fontWeight: AppTypography.weightMedium,
                        ),
                      ),
                      TextSpan(text: ' ${item.action} '),
                      TextSpan(
                        text: item.target,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: AppTypography.weightMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.timeAgo,
                  style: AppTypography.small.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          const Icon(
            Icons.chevron_right_rounded,
            size: AppConstants.iconSm,
            color: AppColors.textDisabled,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// UPCOMING DEADLINES
// ============================================================

class _UpcomingDeadlinesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Deadlines',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
            ),
            Semantics(
              label: 'View all deadlines',
              button: true,
              child: GestureDetector(
                onTap: () => showAppToast(context, message: 'View all (demo)'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxs,
                    vertical: AppSpacing.xxs,
                  ),
                  child: Text(
                    'View all',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: AppTypography.weightMedium,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ...SampleData.deadlines.map((d) => _DeadlineRow(item: d)),
      ],
    );
  }
}

class _DeadlineRow extends StatelessWidget {
  const _DeadlineRow({required this.item});
  final DeadlineItem item;

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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: AppRadius.smAll,
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              size: AppConstants.iconSm,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.date} • ${item.time}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
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
    );
  }
}
