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
import '../widgets/sample_screen_shell.dart';

// ============================================================
// PROFILE SCREEN — Sample Screen
// Demonstrates: hero avatar with badge, stat strip, skill chips,
// info cards, contact list tiles, project links, edit dialog,
// share bottom sheet, responsive layout, skeleton for images.
// ============================================================

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showEditDialog() {
    showAppDialog(
      context: context,
      dialog: AppDialog(
        title: 'Edit Profile',
        showCloseButton: true,
        content: const _EditProfileContent(),
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

  void _showShareSheet() {
    showAppBottomSheet(
      context: context,
      sheet: AppBottomSheet(
        title: 'Share Profile',
        showCloseButton: true,
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xxs),
            _ShareOption(
              icon: Icons.link_rounded,
              label: 'Copy profile link',
              onTap: () {
                Navigator.of(context).pop();
                showAppToast(context, message: 'Link copied to clipboard');
              },
            ),
            const AppDivider(),
            _ShareOption(
              icon: Icons.mail_outline_rounded,
              label: 'Share via email',
              onTap: () {
                Navigator.of(context).pop();
                showAppToast(context, message: 'Opened email (demo)');
              },
            ),
            const AppDivider(),
            _ShareOption(
              icon: Icons.qr_code_rounded,
              label: 'Show QR code',
              onTap: () {
                Navigator.of(context).pop();
                showAppToast(context, message: 'QR code (demo)');
              },
            ),
            const AppDivider(),
            _ShareOption(
              icon: Icons.ios_share_rounded,
              label: 'More options',
              onTap: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SampleScreenShell(
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            _ProfileSliverHeader(
              onEdit: _showEditDialog,
              onShare: _showShareSheet,
              onMessage: () => showAppToast(
                context,
                message: 'Message sent (demo)',
                variant: AppToastVariant.success,
              ),
            ),
          ],
          body: Column(
            children: [
              // Tab bar
              Container(
                color: AppColors.background,
                child: TabBar(
                  controller: _tabController,
                  labelStyle: AppTypography.bodyMedium,
                  unselectedLabelStyle: AppTypography.body,
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
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _OverviewTab(onEdit: _showEditDialog),
                    _ProjectsTab(),
                    _ActivityTab(),
                  ],
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
// Sliver header — hero section
// ----------------------------------------------------------
class _ProfileSliverHeader extends StatelessWidget {
  const _ProfileSliverHeader({
    required this.onEdit,
    required this.onShare,
    required this.onMessage,
  });
  final VoidCallback onEdit;
  final VoidCallback onShare;
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            // Cover / gradient banner
            Container(
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    Color(0xFF004499),
                    Color(0xFF002266),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    right: -20,
                    top: -30,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    bottom: -20,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                    ),
                  ),
                  // Back button
                  Positioned(
                    top: AppSpacing.xs,
                    left: AppSpacing.xs,
                    child: Semantics(
                      label: 'Go back',
                      button: true,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Action buttons
                  Positioned(
                    top: AppSpacing.xs,
                    right: AppSpacing.xs,
                    child: Row(
                      children: [
                        _HeaderIconButton(
                          icon: Icons.ios_share_outlined,
                          label: 'Share profile',
                          onTap: onShare,
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        _HeaderIconButton(
                          icon: Icons.edit_outlined,
                          label: 'Edit profile',
                          onTap: onEdit,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Avatar + info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0, -36),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Avatar with online badge
                        Container(
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
                              width: 18,
                              height: 18,
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
                        const Spacer(),
                        // Message button
                        AppButton(
                          label: 'Message',
                          onPressed: onMessage,
                          isFullWidth: false,
                          size: AppButtonSize.small,
                          leadingIcon: const Icon(
                            Icons.chat_bubble_outline_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Offset to pull content up after avatar shift
                  Transform.translate(
                    offset: const Offset(0, -28),
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
                              leadingIcon: Icon(Icons.verified_rounded),
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
                              size: 14,
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
                              size: 14,
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

                        // Stat strip
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderDefault),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              _ProfileStat(value: '24', label: 'Projects'),
                              _StatDivider(),
                              _ProfileStat(value: '142', label: 'Tasks'),
                              _StatDivider(),
                              _ProfileStat(value: '4.9', label: 'Rating'),
                              _StatDivider(),
                              _ProfileStat(value: '4y', label: 'Tenure'),
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
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTypography.h3.copyWith(
            color: AppColors.textPrimary,
            fontSize: 18,
          ),
        ),
        Text(
          label,
          style: AppTypography.small.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: AppColors.borderDefault);
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Overview tab
// ----------------------------------------------------------
class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.onEdit});
  final VoidCallback onEdit;

  static const List<String> _skills = [
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
        // Bio card
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'About',
                    style: AppTypography.h3.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Semantics(
                    label: 'Edit bio',
                    button: true,
                    child: InkWell(
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

        // Skills / Tags
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

        // Contact info card
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
                icon: Icons.calendar_today_outlined,
                label: 'Joined ${SampleData.userJoinDate}',
              ),
              const AppDivider(),
              _ContactRow(
                icon: Icons.alternate_email_rounded,
                label: SampleData.userHandle,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xs),

        // Quick links
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Links',
                style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.xxs),
              ...SampleData.profileLinks.map((link) {
                final isLast = link == SampleData.profileLinks.last;
                return Column(
                  children: [
                    AppListTile(
                      title: link.label,
                      leading: Icon(
                        IconData(link.icon, fontFamily: 'MaterialIcons'),
                        color: AppColors.primary,
                      ),
                      trailing: AppBadge(
                        label: '${link.count}',
                        variant: AppBadgeVariant.secondary,
                      ),
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxs,
                      ),
                    ),
                    if (!isLast) const AppDivider(indent: 40),
                  ],
                );
              }),
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              label,
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Projects tab
// ----------------------------------------------------------
class _ProjectsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.sm),
      children: [
        ...SampleData.projects.map((p) {
          final color = Color(p.colorHex);
          final pct = (p.progress * 100).toInt();
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: AppCard(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
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
                            Text(
                              'Due ${p.dueDate} · ${p.members} members',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textDisabled,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: LinearProgressIndicator(
                            value: p.progress,
                            backgroundColor: AppColors.borderDefault,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '$pct%',
                        style: AppTypography.small.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
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
      itemBuilder: (context, i) {
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
            child: Icon(
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

// ----------------------------------------------------------
// Edit profile dialog content
// ----------------------------------------------------------
class _EditProfileContent extends StatelessWidget {
  const _EditProfileContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
          hint: 'A short bio about yourself...',
          maxLines: 3,
          minLines: 3,
        ),
      ],
    );
  }
}

// ----------------------------------------------------------
// Share option tile
// ----------------------------------------------------------
class _ShareOption extends StatelessWidget {
  const _ShareOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: label,
      leading: Icon(icon, color: AppColors.primary),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textDisabled,
      ),
      onTap: onTap,
    );
  }
}
