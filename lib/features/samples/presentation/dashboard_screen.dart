import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_divider.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_loading.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../data/sample_data.dart';
import '../widgets/sample_screen_shell.dart';

// ============================================================
// DASHBOARD / HOME SCREEN
// Matches reference: greeting banner, user card, stat strip,
// quick actions, active projects, recent activity.
// ============================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _initialLoading = true;
  int _filterIndex = 0;
  bool _isLoadingMore = false;
  bool _showEmpty = false;

  static const _filters = ['All', 'Active', 'Review', 'Done'];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _initialLoading = false);
    });
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() {
      _isLoadingMore = false;
      _showEmpty = true;
    });
    showAppToast(context, message: 'All activity loaded');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _initialLoading ? _buildSkeleton() : _buildBody(context),
    );
  }

  Widget _buildSkeleton() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ShimmerScope(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xs),
                const SkeletonLine(width: 140, height: 14),
                const SizedBox(height: 6),
                const SkeletonLine(width: 220, height: 28),
                const SizedBox(height: 4),
                const SkeletonLine(width: 180, height: 14),
                const SizedBox(height: AppSpacing.sm),
                // User card skeleton
                SkeletonBox(
                  width: double.infinity,
                  height: 72,
                  borderRadius: BorderRadius.circular(12),
                ),
                const SizedBox(height: AppSpacing.md),
                // Stat row
                Row(
                  children: List.generate(
                    4,
                    (_) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xs),
                        child: SkeletonBox(
                          width: double.infinity,
                          height: 60,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const SkeletonLine(width: 120, height: 18),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: List.generate(
                    4,
                    (_) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xs),
                        child: SkeletonBox(
                          width: double.infinity,
                          height: 80,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const SkeletonLine(width: 120, height: 18),
                const SizedBox(height: AppSpacing.xs),
                const SkeletonCard(),
                const SizedBox(height: AppSpacing.xs),
                const SkeletonCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ── Greeting header ─────────────────────────────
          SliverToBoxAdapter(
            child: _GreetingHeader(
              onSearch: () => showAppToast(context, message: 'Search (demo)'),
              onNotifications: () =>
                  showAppToast(context, message: '3 new notifications'),
            ),
          ),

          // ── User card ───────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              0,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            sliver: SliverToBoxAdapter(child: _UserCard()),
          ),

          // ── Stat strip ──────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            sliver: SliverToBoxAdapter(child: _StatStrip()),
          ),

          // ── Quick Actions ────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: _SectionRow(
                title: 'Quick Actions',
                actionLabel: 'View all',
                onAction: () {},
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.xs,
              AppSpacing.sm,
              0,
            ),
            sliver: SliverToBoxAdapter(child: _QuickActions()),
          ),

          // ── Active Projects ──────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: _SectionRow(
                title: 'Active Projects',
                actionLabel: 'View all',
                onAction: () {},
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.xs,
              AppSpacing.sm,
              0,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                SampleData.projects
                    .map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: _ProjectTile(project: p),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          // ── Recent Activity ──────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.xs,
              AppSpacing.sm,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: _SectionRow(title: 'Recent Activity'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.xs,
              AppSpacing.sm,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: SampleFilterRow(
                options: _filters,
                initialIndex: _filterIndex,
                onChanged: (i) => setState(() => _filterIndex = i),
              ),
            ),
          ),

          if (_filterIndex == 3 || _showEmpty)
            SliverToBoxAdapter(
              child: AppEmptyState(
                icon: const Icon(Icons.inbox_outlined),
                title: 'No completed tasks yet',
                body: 'Finished tasks will appear here.',
              ),
            )
          else ...[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _ActivityRow(item: SampleData.activities[i]),
                  childCount: SampleData.activities.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.xs,
                AppSpacing.sm,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: _isLoadingMore
                    ? const AppPaginationLoader()
                    : AppButton(
                        label: 'Load more',
                        onPressed: _loadMore,
                        variant: AppButtonVariant.secondary,
                        size: AppButtonSize.small,
                        isFullWidth: false,
                      ),
              ),
            ),
          ],

          const SliverPadding(padding: EdgeInsets.only(bottom: AppSpacing.xl)),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Greeting header — "Good morning, / Alexandra Chen 👋"
// ----------------------------------------------------------
class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader({
    required this.onSearch,
    required this.onNotifications,
  });
  final VoidCallback onSearch;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.surface,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: greeting + icons
          Row(
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
                    Text(
                      '${SampleData.userName} 👋',
                      style: AppTypography.h2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Let's make today productive!",
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              _IconBtn(
                icon: Icons.search_rounded,
                label: 'Search',
                onTap: onSearch,
              ),
              const SizedBox(width: AppSpacing.xxs),
              _IconBtn(
                icon: Icons.notifications_none_rounded,
                label: '3 notifications',
                onTap: onNotifications,
                badge: true,
              ),
              const SizedBox(width: AppSpacing.xs),
              const AppAvatar(
                initials: 'AC',
                size: AppAvatarSize.xs,
                semanticLabel: 'Your profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, size: 22, color: AppColors.textPrimary),
              if (badge)
                Positioned(
                  top: 8,
                  right: 7,
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

// ----------------------------------------------------------
// User card — avatar, name, title, location
// ----------------------------------------------------------
class _UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlay.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const AppAvatar(
            initials: 'AC',
            size: AppAvatarSize.sm,
            semanticLabel: 'Alexandra Chen',
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      SampleData.userName,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    const AppBadge(
                      label: 'Pro',
                      variant: AppBadgeVariant.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  SampleData.userTitle,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 12,
                      color: AppColors.textDisabled,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${SampleData.userLocation} · ${SampleData.userDepartment}',
                      style: AppTypography.small.copyWith(
                        color: AppColors.textDisabled,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textDisabled,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Stat strip — 4 numbers in a row
// ----------------------------------------------------------
class _StatStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const stats = [
      ('24', 'Projects'),
      ('142', 'Tasks'),
      ('4.9', 'Rating'),
      ('4y', 'Tenure'),
    ];
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlay.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(stats.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Container(
              width: 1,
              height: 28,
              color: AppColors.borderDefault,
            );
          }
          final s = stats[i ~/ 2];
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  s.$1,
                  style: AppTypography.h3.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  s.$2,
                  style: AppTypography.small.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ----------------------------------------------------------
// Section row — title + optional "View all"
// ----------------------------------------------------------
class _SectionRow extends StatelessWidget {
  const _SectionRow({required this.title, this.actionLabel, this.onAction});
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
          ),
        ),
        if (actionLabel != null)
          Semantics(
            label: actionLabel,
            button: true,
            child: GestureDetector(
              onTap: onAction,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxs,
                  vertical: AppSpacing.xxs,
                ),
                child: Text(
                  actionLabel!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ----------------------------------------------------------
// Quick actions — icon tiles in a horizontal row
// ----------------------------------------------------------
class _QuickActions extends StatelessWidget {
  static const _actions = [
    (
      icon: Icons.add_circle_outline_rounded,
      label: 'New Project',
      color: Color(0xFF0066CC),
    ),
    (
      icon: Icons.upload_file_outlined,
      label: 'Upload File',
      color: Color(0xFF059669),
    ),
    (
      icon: Icons.people_outline_rounded,
      label: 'Invite Team',
      color: Color(0xFFD97706),
    ),
    (
      icon: Icons.bar_chart_rounded,
      label: 'View Reports',
      color: Color(0xFF7C3AED),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_actions.length * 2 - 1, (i) {
        if (i.isOdd) return const SizedBox(width: AppSpacing.xs);
        final a = _actions[i ~/ 2];
        return Expanded(
          child: _QuickTile(icon: a.icon, label: a.label, color: a.color),
        );
      }),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.icon,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderDefault),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                label,
                style: AppTypography.small.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Project tile — name, progress bar, due date, members
// ----------------------------------------------------------
class _ProjectTile extends StatelessWidget {
  const _ProjectTile({required this.project});
  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final color = Color(project.colorHex);
    final pct = (project.progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  project.name,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              AppBadge(
                label: 'Due ${project.dueDate}',
                variant: AppBadgeVariant.secondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: project.progress,
              backgroundColor: AppColors.borderDefault,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 5,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              Text(
                '$pct% complete',
                style: AppTypography.small.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              // Member initials
              ...List.generate(
                project.members.clamp(0, 3),
                (i) => Transform.translate(
                  offset: Offset(i * -8.0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.background,
                        width: 1.5,
                      ),
                    ),
                    child: AppAvatar(
                      initials: String.fromCharCode(65 + i),
                      size: AppAvatarSize.xxs,
                      backgroundColor: color.withValues(alpha: 0.15),
                      foregroundColor: color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                '${project.members} members',
                style: AppTypography.small.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Activity row
// ----------------------------------------------------------
class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.item});
  final ActivityItem item;

  static AppBadgeVariant _variant(ActivityBadge b) {
    switch (b) {
      case ActivityBadge.success:
        return AppBadgeVariant.success;
      case ActivityBadge.warning:
        return AppBadgeVariant.warning;
      case ActivityBadge.primary:
        return AppBadgeVariant.primary;
      case ActivityBadge.secondary:
        return AppBadgeVariant.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.history_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        AppBadge(
                          label: item.badgeLabel,
                          variant: _variant(item.badgeVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
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
            ],
          ),
        ),
        const AppDivider(indent: 44),
      ],
    );
  }
}
