import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../core/widgets/app_bottom_navigation.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_divider.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_loading.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../data/sample_data.dart';
import '../widgets/sample_screen_shell.dart';

// ============================================================
// DASHBOARD / HOME SCREEN — Sample Screen
// Demonstrates: app bar with search, greeting header, stat cards,
// quick-action chips, project cards with progress, activity list,
// team avatars, pagination loading, bottom navigation, responsive.
// ============================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;
  int _filterIndex = 0;
  bool _isLoadingMore = false;
  bool _showEmptyState = false;
  // simulate skeleton loading on first mount
  bool _initialLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _initialLoading = false);
    });
  }

  final List<String> _filters = ['All', 'Active', 'Review', 'Done'];

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() {
      _isLoadingMore = false;
      _showEmptyState = true;
    });
    showAppToast(context, message: 'All items loaded');
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayout.isTablet(context);

    return SampleScreenShell(
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Column(
            children: [
              _DashboardAppBar(
                onSearch: () => showAppToast(
                  context,
                  message: 'Search (demo)',
                  variant: AppToastVariant.neutral,
                ),
                onNotifications: () => showAppToast(
                  context,
                  message: '3 new notifications',
                  variant: AppToastVariant.neutral,
                ),
              ),
              Expanded(
                child: _initialLoading
                    ? _SkeletonBody()
                    : _DashboardBody(
                        filterIndex: _filterIndex,
                        filters: _filters,
                        isTablet: isTablet,
                        isLoadingMore: _isLoadingMore,
                        showEmptyState: _showEmptyState,
                        onFilterChanged: (i) =>
                            setState(() => _filterIndex = i),
                        onLoadMore: _loadMore,
                        onCardTap: (name) => showAppToast(
                          context,
                          message: 'Opened "$name"',
                          variant: AppToastVariant.neutral,
                        ),
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: _navIndex,
          onTap: (i) => setState(() => _navIndex = i),
          items: [
            const AppBottomNavItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            AppBottomNavItem(
              icon: const Icon(Icons.folder_outlined),
              activeIcon: const Icon(Icons.folder_rounded),
              label: 'Projects',
              badge: NotificationDot(count: 3),
            ),
            const AppBottomNavItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart_rounded),
              label: 'Analytics',
            ),
            const AppBottomNavItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// App bar
// ----------------------------------------------------------
class _DashboardAppBar extends StatelessWidget {
  const _DashboardAppBar({
    required this.onSearch,
    required this.onNotifications,
  });
  final VoidCallback onSearch;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, Color(0xFF004499)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            'Workspace',
            style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
          ),
          const Spacer(),
          // Search
          Semantics(
            label: 'Search',
            button: true,
            child: InkWell(
              onTap: onSearch,
              borderRadius: BorderRadius.circular(22),
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.search_rounded,
                    color: AppColors.textSecondary, size: 22),
              ),
            ),
          ),
          // Notifications with badge
          Semantics(
            label: '3 notifications',
            button: true,
            child: InkWell(
              onTap: onNotifications,
              borderRadius: BorderRadius.circular(22),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.notifications_outlined,
                        color: AppColors.textSecondary, size: 22),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: NotificationDot(count: 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Avatar
          const AppAvatar(
            initials: 'AC',
            size: AppAvatarSize.xs,
            semanticLabel: 'Your profile',
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Skeleton loading body
// ----------------------------------------------------------
class _SkeletonBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShimmerScope(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting skeleton
            const SkeletonLine(width: 180, height: 28),
            const SizedBox(height: AppSpacing.xxs),
            const SkeletonLine(width: 240, height: 16),
            const SizedBox(height: AppSpacing.md),
            // Stat cards row
            Row(
              children: List.generate(4, (_) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.xs),
                  child: SkeletonBox(
                    width: double.infinity,
                    height: 80,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )),
            ),
            const SizedBox(height: AppSpacing.md),
            const SkeletonLine(width: 120, height: 20),
            const SizedBox(height: AppSpacing.xs),
            const SkeletonCard(),
            const SizedBox(height: AppSpacing.xs),
            const SkeletonCard(),
            const SizedBox(height: AppSpacing.md),
            const SkeletonLine(width: 100, height: 20),
            const SizedBox(height: AppSpacing.xs),
            const SkeletonListTile(showSubtitle: true),
            const SkeletonListTile(showSubtitle: true),
            const SkeletonListTile(showSubtitle: true),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Full dashboard body
// ----------------------------------------------------------
class _DashboardBody extends StatelessWidget {
  const _DashboardBody({
    required this.filterIndex,
    required this.filters,
    required this.isTablet,
    required this.isLoadingMore,
    required this.showEmptyState,
    required this.onFilterChanged,
    required this.onLoadMore,
    required this.onCardTap,
  });

  final int filterIndex;
  final List<String> filters;
  final bool isTablet;
  final bool isLoadingMore;
  final bool showEmptyState;
  final ValueChanged<int> onFilterChanged;
  final VoidCallback onLoadMore;
  final ValueChanged<String> onCardTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // ── Greeting + Quick Stats ─────────────────────────
        Container(
          color: AppColors.background,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.sm,
            AppSpacing.sm,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning, Alex 👋',
                          style: AppTypography.h2.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'Here\'s what\'s happening today',
                          style: AppTypography.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppBadge(
                    label: 'Pro',
                    variant: AppBadgeVariant.primary,
                    leadingIcon: const Icon(Icons.star_rounded),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // Stats grid — 2 cols on mobile, 4 on tablet
              isTablet
                  ? Row(
                      children: SampleData.stats.map((s) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.xs),
                          child: _StatCard(stat: s),
                        ),
                      )).toList(),
                    )
                  : Column(
                      children: [
                        Row(
                          children: SampleData.stats.take(2).map((s) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: s == SampleData.stats[0]
                                    ? AppSpacing.xs : 0,
                              ),
                              child: _StatCard(stat: s),
                            ),
                          )).toList(),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: SampleData.stats.skip(2).map((s) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: s == SampleData.stats[2]
                                    ? AppSpacing.xs : 0,
                              ),
                              child: _StatCard(stat: s),
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xs),

        // ── Quick Actions ──────────────────────────────────
        Container(
          color: AppColors.background,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                ),
                child: Text(
                  'Quick Actions',
                  style: AppTypography.h3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm),
                child: Row(
                  children: [
                    _QuickActionChip(
                      icon: Icons.add_rounded,
                      label: 'New Project',
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _QuickActionChip(
                      icon: Icons.upload_file_outlined,
                      label: 'Upload File',
                      color: AppColors.success,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _QuickActionChip(
                      icon: Icons.people_outline_rounded,
                      label: 'Invite Team',
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _QuickActionChip(
                      icon: Icons.bar_chart_rounded,
                      label: 'View Report',
                      color: const Color(0xFF7C3AED),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _QuickActionChip(
                      icon: Icons.calendar_today_outlined,
                      label: 'Schedule',
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xs),

        // ── Projects ───────────────────────────────────────
        Container(
          color: AppColors.background,
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Active Projects',
                      style: AppTypography.h3.copyWith(
                          color: AppColors.textPrimary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs),
                      minimumSize: const Size(44, 44),
                    ),
                    child: Text(
                      'View all',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              ...SampleData.projects.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: _ProjectCard(
                  project: p,
                  onTap: () => onCardTap(p.name),
                ),
              )),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xs),

        // ── Team ───────────────────────────────────────────
        Container(
          color: AppColors.background,
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Team Members',
                style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.xs),
              ...SampleData.team.map((m) => _TeamListTile(member: m)),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xs),

        // ── Activity Feed ──────────────────────────────────
        Container(
          color: AppColors.background,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Recent Activity',
                      style: AppTypography.h3.copyWith(
                          color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              // Filter chips
              SampleFilterRow(
                options: filters,
                initialIndex: filterIndex,
                onChanged: onFilterChanged,
              ),
              const SizedBox(height: AppSpacing.sm),

              // Activity items
              if (filterIndex == 3 || showEmptyState) ...[
                AppEmptyState(
                  icon: const Icon(Icons.inbox_outlined),
                  title: 'No completed tasks yet',
                  body: 'Finished tasks will appear here.',
                  ctaLabel: 'Browse all activity',
                  onCtaTap: () {},
                ),
              ] else ...[
                ...SampleData.activities.map(
                  (a) => _ActivityTile(item: a),
                ),
                const SizedBox(height: AppSpacing.xs),
                if (isLoadingMore)
                  const AppPaginationLoader()
                else
                  AppButton(
                    label: 'Load more',
                    onPressed: onLoadMore,
                    variant: AppButtonVariant.secondary,
                    size: AppButtonSize.small,
                    isFullWidth: false,
                    leadingIcon: const Icon(Icons.refresh_rounded),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

// ----------------------------------------------------------
// Stat card
// ----------------------------------------------------------
class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});
  final DashboardStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDefault),
        boxShadow: AppShadows.elevation1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stat.value,
            style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: AppTypography.small.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              Icon(
                stat.isPositive
                    ? Icons.trending_up_rounded
                    : Icons.trending_down_rounded,
                size: 12,
                color: stat.isPositive ? AppColors.success : AppColors.error,
              ),
              const SizedBox(width: 2),
              Text(
                stat.delta,
                style: AppTypography.small.copyWith(
                  color:
                      stat.isPositive ? AppColors.success : AppColors.error,
                  fontSize: 11,
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
// Quick action chip
// ----------------------------------------------------------
class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                label,
                style: AppTypography.small.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
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
// Project card with progress bar
// ----------------------------------------------------------
class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.onTap});
  final ProjectItem project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Color(project.colorHex);
    final percent = (project.progress * 100).toInt();

    return Semantics(
      label: '${project.name}, $percent% complete',
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderDefault),
            boxShadow: AppShadows.elevation1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
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
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LinearProgressIndicator(
                  value: project.progress,
                  backgroundColor: AppColors.borderDefault,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Row(
                children: [
                  Text(
                    '$percent% complete',
                    style: AppTypography.small.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  // Member avatars
                  SizedBox(
                    width: (project.members * 18.0) + 10,
                    height: 24,
                    child: Stack(
                      children: List.generate(
                        project.members.clamp(0, 3),
                        (i) => Positioned(
                          left: i * 18.0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.background, width: 1.5),
                            ),
                            child: AppAvatar(
                              initials: String.fromCharCode(65 + i),
                              size: AppAvatarSize.xxs,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Team list tile
// ----------------------------------------------------------
class _TeamListTile extends StatelessWidget {
  const _TeamListTile({required this.member});
  final TeamMember member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          AppAvatar(
            initials: member.initials,
            size: AppAvatarSize.sm,
            semanticLabel: member.name,
            badge: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: member.isOnline ? AppColors.success : AppColors.textDisabled,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 1.5),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  member.role,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          AppBadge(
            label: member.isOnline ? 'Online' : 'Offline',
            variant: member.isOnline
                ? AppBadgeVariant.success
                : AppBadgeVariant.secondary,
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Activity feed tile
// ----------------------------------------------------------
class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.item});
  final ActivityItem item;

  static IconData _iconFor(ActivityIcon a) {
    switch (a) {
      case ActivityIcon.design:   return Icons.design_services_outlined;
      case ActivityIcon.calendar: return Icons.calendar_today_outlined;
      case ActivityIcon.check:    return Icons.check_circle_outline_rounded;
      case ActivityIcon.mobile:   return Icons.phone_iphone_outlined;
      case ActivityIcon.research: return Icons.biotech_outlined;
      case ActivityIcon.sprint:   return Icons.directions_run_outlined;
    }
  }

  static AppBadgeVariant _variantFor(ActivityBadge b) {
    switch (b) {
      case ActivityBadge.success:   return AppBadgeVariant.success;
      case ActivityBadge.warning:   return AppBadgeVariant.warning;
      case ActivityBadge.primary:   return AppBadgeVariant.primary;
      case ActivityBadge.secondary: return AppBadgeVariant.secondary;
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
                child: Icon(
                  _iconFor(item.icon),
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
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        AppBadge(
                          label: item.badgeLabel,
                          variant: _variantFor(item.badgeVariant),
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
