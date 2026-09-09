import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../core/widgets/app_divider.dart';
import '../../../core/widgets/app_list_tile.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../../../core/widgets/app_text_field.dart';
import '../data/sample_data.dart';

// ============================================================
// PROFILE SCREEN
// Reference: cover gradient, large avatar + name + badges,
// stat strip, 3-tab layout (Overview / Projects / Activity).
// ============================================================

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  void _editProfile() {
    showAppDialog(
      context: context,
      dialog: AppDialog(
        title: 'Edit Profile',
        showCloseButton: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AppTextField(label: 'Full name', hint: 'Alexandra Chen'),
            SizedBox(height: AppSpacing.xs),
            AppTextField(label: 'Job title', hint: 'Senior Product Designer'),
            SizedBox(height: AppSpacing.xs),
            AppTextField(label: 'Location', hint: 'San Francisco, CA'),
            SizedBox(height: AppSpacing.xs),
            AppTextField(
              label: 'Bio',
              hint: 'A short bio...',
              maxLines: 3,
              minLines: 3,
            ),
          ],
        ),
        primaryLabel: 'Save Changes',
        primaryAction: () {
          Navigator.of(context).pop();
          showAppToast(
            context,
            message: 'Profile updated (demo)',
            variant: AppToastVariant.success,
          );
        },
        secondaryLabel: 'Cancel',
        secondaryAction: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _shareProfile() {
    showAppBottomSheet(
      context: context,
      sheet: AppBottomSheet(
        title: 'Share Profile',
        showCloseButton: true,
        child: Column(
          children: [
            AppListTile(
              title: 'Copy profile link',
              leading: const Icon(Icons.link_rounded, color: AppColors.primary),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textDisabled,
              ),
              onTap: () {
                Navigator.pop(context);
                showAppToast(context, message: 'Link copied');
              },
            ),
            const AppDivider(),
            AppListTile(
              title: 'Share via email',
              leading: const Icon(
                Icons.mail_outline_rounded,
                color: AppColors.primary,
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textDisabled,
              ),
              onTap: () {
                Navigator.pop(context);
                showAppToast(context, message: 'Opened email (demo)');
              },
            ),
            const AppDivider(),
            AppListTile(
              title: 'Show QR code',
              leading: const Icon(
                Icons.qr_code_rounded,
                color: AppColors.primary,
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textDisabled,
              ),
              onTap: () {
                Navigator.pop(context);
                showAppToast(context, message: 'QR code (demo)');
              },
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (ctx, innerBoxScrolled) => [
          SliverToBoxAdapter(
            child: _ProfileHeader(onEdit: _editProfile, onShare: _shareProfile),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabs,
                labelStyle: AppTypography.bodyMedium.copyWith(fontSize: 14),
                unselectedLabelStyle: AppTypography.body.copyWith(fontSize: 14),
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                indicatorWeight: 2,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Projects'),
                  Tab(text: 'Activity'),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            _OverviewTab(onEdit: _editProfile),
            _ProjectsTab(),
            _ActivityTab(),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Profile header — cover, avatar, name, badges, stat strip
// ----------------------------------------------------------
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onEdit, required this.onShare});
  final VoidCallback onEdit;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cover gradient
        SizedBox(
          height: 130,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1565C0),
                      Color(0xFF42A5F5),
                      Color(0xFF64B5F6),
                    ],
                  ),
                ),
              ),
              // Decorative circles
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                right: 40,
                bottom: -40,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
              // Back + action buttons
              Positioned(
                top: AppSpacing.xs,
                right: AppSpacing.xs,
                child: Row(
                  children: [
                    _CoverButton(
                      icon: Icons.ios_share_outlined,
                      label: 'Share',
                      onTap: onShare,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    _CoverButton(
                      icon: Icons.edit_outlined,
                      label: 'Edit',
                      onTap: onEdit,
                      hasLabel: true,
                      btnLabel: 'Edit Profile',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Avatar + name section
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            0,
            AppSpacing.sm,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar row — overlaps cover
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Transform.translate(
                    offset: const Offset(0, -32),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.background,
                          width: 3,
                        ),
                      ),
                      child: AppAvatar(
                        initials: SampleData.userInitials,
                        size: AppAvatarSize.lg,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.15,
                        ),
                        foregroundColor: AppColors.primary,
                        semanticLabel: SampleData.userName,
                        badge: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.background,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(0, -8),
                    child: AppButton(
                      label: 'Edit Profile',
                      onPressed: onEdit,
                      isFullWidth: false,
                      size: AppButtonSize.small,
                      leadingIcon: const Icon(Icons.edit_outlined, size: 14),
                    ),
                  ),
                ],
              ),

              // Name + badges
              Transform.translate(
                offset: const Offset(0, -24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          SampleData.userName,
                          style: AppTypography.h2.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const AppBadge(
                          label: 'Pro',
                          variant: AppBadgeVariant.primary,
                          leadingIcon: Icon(Icons.star_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      SampleData.userTitle,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: AppColors.textDisabled,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          SampleData.userLocation,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(
                          Icons.business_outlined,
                          size: 13,
                          color: AppColors.textDisabled,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          SampleData.userDepartment,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    // Stat strip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderDefault),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _PStat(value: '24', label: 'Projects'),
                          _Divider(),
                          _PStat(value: '142', label: 'Tasks'),
                          _Divider(),
                          _PStat(value: '4.9', label: 'Rating'),
                          _Divider(),
                          _PStat(value: '4y', label: 'Tenure'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PStat extends StatelessWidget {
  const _PStat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        value,
        style: AppTypography.h3.copyWith(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 1),
      Text(
        label,
        style: AppTypography.small.copyWith(color: AppColors.textSecondary),
      ),
    ],
  );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 28, color: AppColors.borderDefault);
}

class _CoverButton extends StatelessWidget {
  const _CoverButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.hasLabel = false,
    this.btnLabel,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool hasLabel;
  final String? btnLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: hasLabel ? AppSpacing.xs : AppSpacing.xxs,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: hasLabel
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      btnLabel ?? label,
                      style: AppTypography.small.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// TabBar persistent header delegate
// ----------------------------------------------------------
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  const _TabBarDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.background, child: tabBar);
  }

  @override
  bool shouldRebuild(_TabBarDelegate old) => old.tabBar != tabBar;
}

// ----------------------------------------------------------
// Overview tab
// ----------------------------------------------------------
class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.onEdit});
  final VoidCallback onEdit;

  static const _skills = [
    'Figma',
    'Design Systems',
    'Prototyping',
    'User Research',
    'Accessibility',
    'Flutter',
    'Swift UI',
    'Interaction Design',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.sm),
      children: [
        // About
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'About',
                      style: AppTypography.h3.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onEdit,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxs),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                SampleData.userBio,
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),

        // Skills
        AppCard(
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
                children: _skills
                    .map(
                      (s) =>
                          AppBadge(label: s, variant: AppBadgeVariant.primary),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),

        // Contact
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact',
                style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.xs),
              _ContactRow(
                icon: Icons.mail_outline_rounded,
                label: SampleData.userEmail,
              ),
              const AppDivider(),
              _ContactRow(
                icon: Icons.phone_outlined,
                label: SampleData.userPhone,
              ),
              const AppDivider(),
              _ContactRow(
                icon: Icons.location_on_outlined,
                label: SampleData.userLocation,
              ),
              const AppDivider(),
              _ContactRow(
                icon: Icons.alternate_email_rounded,
                label: SampleData.userHandle,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
    child: Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            label,
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          ),
        ),
        const Icon(
          Icons.chevron_right_rounded,
          size: 18,
          color: AppColors.textDisabled,
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------
// Projects tab
// ----------------------------------------------------------
class _ProjectsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.sm),
      children: SampleData.projects.map((p) {
        final color = Color(p.colorHex);
        final pct = (p.progress * 100).toInt();
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: AppCard(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.folder_open_rounded,
                    color: color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          value: p.progress,
                          minHeight: 5,
                          backgroundColor: AppColors.borderDefault,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$pct% · Due ${p.dueDate} · ${p.members} members',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textDisabled,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ----------------------------------------------------------
// Activity tab
// ----------------------------------------------------------
class _ActivityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.sm),
      itemCount: SampleData.activities.length,
      separatorBuilder: (context, index) => const AppDivider(indent: 52),
      itemBuilder: (_, i) {
        final a = SampleData.activities[i];
        return AppListTile(
          title: a.title,
          subtitle: a.subtitle,
          leading: Container(
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
          trailing: Text(
            a.timeAgo,
            style: AppTypography.small.copyWith(color: AppColors.textDisabled),
          ),
          onTap: () {},
        );
      },
    );
  }
}
