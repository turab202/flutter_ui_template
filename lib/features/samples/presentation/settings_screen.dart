import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_badge.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../../core/widgets/app_divider.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../data/sample_data.dart';

// ============================================================
// SETTINGS SCREEN
// Reference: profile card, APPEARANCE / NOTIFICATIONS /
// ACCOUNT grouped sections, iOS-style toggle rows,
// sign-out + delete-account danger zone.
// ============================================================

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Toggle states (key = label)
  final Map<String, bool> _toggles = {
    'Dark Mode': false,
    'Compact Layout': true,
    'Push Notifications': true,
    'Email Digest': true,
    'Mentions & replies': true,
  };

  double _textScale = 1.0;

  bool _get(String k) => _toggles[k] ?? false;
  void _set(String k, bool v) {
    setState(() => _toggles[k] = v);
    showAppToast(
      context,
      message: '$k ${v ? 'enabled' : 'disabled'}',
      variant: v ? AppToastVariant.success : AppToastVariant.neutral,
    );
  }

  void _confirmSignOut() {
    showAppDialog(
      context: context,
      dialog: AppDialog(
        title: 'Sign out',
        icon: const Icon(
          Icons.logout_rounded,
          size: 40,
          color: AppColors.error,
        ),
        content: const Text(
          'Are you sure you want to sign out? You can sign back in at any time.',
        ),
        primaryLabel: 'Sign out',
        primaryAction: () {
          Navigator.of(context).pop();
          showAppToast(
            context,
            message: 'Signed out (demo)',
            variant: AppToastVariant.neutral,
          );
        },
        secondaryLabel: 'Cancel',
        secondaryAction: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _confirmDelete() {
    showAppDialog(
      context: context,
      dialog: AppDialog(
        title: 'Delete account',
        icon: const Icon(
          Icons.delete_forever_rounded,
          size: 40,
          color: AppColors.error,
        ),
        content: const Text(
          'This will permanently delete your account and all your data. This action cannot be undone.',
        ),
        primaryLabel: 'Delete permanently',
        primaryAction: () {
          Navigator.of(context).pop();
          showAppToast(
            context,
            message: 'Account deletion requested (demo)',
            variant: AppToastVariant.error,
          );
        },
        secondaryLabel: 'Keep account',
        secondaryAction: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayout.isTablet(context);

    Widget body = ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      children: [
        // ── App bar ─────────────────────────────────────
        _SettingsAppBar(),

        // ── Profile card ─────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.xs,
            AppSpacing.sm,
            0,
          ),
          child: _ProfileCard(),
        ),

        // ── APPEARANCE ──────────────────────────────────
        _GroupHeader(label: 'APPEARANCE'),
        _Group(
          children: [
            _ToggleRow(
              icon: Icons.dark_mode_outlined,
              label: 'Dark Mode',
              subtitle: 'Switch to dark theme',
              value: _get('Dark Mode'),
              onChanged: (v) => _set('Dark Mode', v),
            ),
            const AppDivider(indent: 52),
            _ToggleRow(
              icon: Icons.view_compact_outlined,
              label: 'Compact Layout',
              subtitle: 'Reduce spacing in lists',
              value: _get('Compact Layout'),
              onChanged: (v) => _set('Compact Layout', v),
            ),
            const AppDivider(indent: 52),
            // Text size slider
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.text_fields_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Text Size',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _textScale < 0.95
                          ? 'Small'
                          : _textScale > 1.05
                          ? 'Large'
                          : 'Default',
                      style: AppTypography.small.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                0,
                AppSpacing.sm,
                AppSpacing.xs,
              ),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.borderDefault,
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withValues(alpha: 0.12),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: _textScale,
                  min: 0.8,
                  max: 1.4,
                  divisions: 6,
                  onChanged: (v) => setState(() => _textScale = v),
                ),
              ),
            ),
            const AppDivider(indent: 52),
            _NavRow(
              icon: Icons.color_lens_outlined,
              label: 'Accent Color',
              subtitle: 'Blue (default)',
              onTap: () =>
                  showAppToast(context, message: 'Color picker (demo)'),
            ),
          ],
        ),

        // ── NOTIFICATIONS ───────────────────────────────
        _GroupHeader(label: 'NOTIFICATIONS'),
        _Group(
          children: [
            _ToggleRow(
              icon: Icons.notifications_outlined,
              label: 'Push Notifications',
              subtitle: 'Receive alerts on your device',
              value: _get('Push Notifications'),
              onChanged: (v) => _set('Push Notifications', v),
            ),
            const AppDivider(indent: 52),
            _ToggleRow(
              icon: Icons.email_outlined,
              label: 'Email Digest',
              subtitle: 'Daily summary at 9am',
              value: _get('Email Digest'),
              onChanged: (v) => _set('Email Digest', v),
            ),
            const AppDivider(indent: 52),
            _NavRow(
              icon: Icons.tune_outlined,
              label: 'Notify me about',
              onTap: () {},
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textDisabled,
                size: 18,
              ),
            ),
            const AppDivider(indent: 52),
            _ToggleRow(
              icon: Icons.alternate_email_rounded,
              label: 'Mentions & replies',
              value: _get('Mentions & replies'),
              onChanged: (v) => _set('Mentions & replies', v),
            ),
          ],
        ),

        // ── ACCOUNT ────────────────────────────────────
        _GroupHeader(label: 'ACCOUNT'),
        _Group(
          children: [
            _NavRow(
              icon: Icons.security_outlined,
              label: 'Privacy & Security',
              onTap: () =>
                  showAppToast(context, message: 'Privacy & Security (demo)'),
            ),
            const AppDivider(indent: 52),
            _NavRow(
              icon: Icons.help_outline_rounded,
              label: 'Help & Support',
              onTap: () =>
                  showAppToast(context, message: 'Help & Support (demo)'),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        // ── Danger zone ─────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Column(
            children: [
              AppButton(
                label: 'Sign Out',
                onPressed: _confirmSignOut,
                variant: AppButtonVariant.secondary,
                leadingIcon: const Icon(Icons.logout_rounded),
              ),
              const SizedBox(height: AppSpacing.xs),
              AppButton(
                label: 'Delete Account',
                onPressed: _confirmDelete,
                variant: AppButtonVariant.destructive,
                leadingIcon: const Icon(Icons.delete_forever_outlined),
              ),
            ],
          ),
        ),
      ],
    );

    if (isTablet) {
      body = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: body,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(child: body),
    );
  }
}

// ----------------------------------------------------------
// App bar
// ----------------------------------------------------------
class _SettingsAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Settings',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Profile summary card
// ----------------------------------------------------------
class _ProfileCard extends StatelessWidget {
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
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const AppAvatar(
            initials: 'AC',
            size: AppAvatarSize.md,
            semanticLabel: 'Alexandra Chen',
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  SampleData.userName,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  SampleData.userEmail,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                const AppBadge(
                  label: 'Pro Plan',
                  variant: AppBadgeVariant.primary,
                  leadingIcon: Icon(Icons.star_rounded),
                ),
              ],
            ),
          ),
          Semantics(
            label: 'Edit profile',
            button: true,
            child: InkWell(
              onTap: () =>
                  showAppToast(context, message: 'Edit profile (demo)'),
              borderRadius: BorderRadius.circular(22),
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Section group header
// ----------------------------------------------------------
class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.sm,
      AppSpacing.sm,
      AppSpacing.sm,
      AppSpacing.xxs,
    ),
    child: Text(
      label,
      style: AppTypography.small.copyWith(
        color: AppColors.textDisabled,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      ),
    ),
  );
}

// ----------------------------------------------------------
// Group card
// ----------------------------------------------------------
class _Group extends StatelessWidget {
  const _Group({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlay.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

// ----------------------------------------------------------
// Toggle row
// ----------------------------------------------------------
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      toggled: value,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 1),
                    Text(
                      subtitle!,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: AppColors.primary,
              thumbColor: WidgetStateProperty.resolveWith(
                (s) => s.contains(WidgetState.selected)
                    ? AppColors.background
                    : null,
              ),
              materialTapTargetSize: MaterialTapTargetSize.padded,
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Navigate row
// ----------------------------------------------------------
class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.onTap,
    this.trailing,
  });
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 1),
                      Text(
                        subtitle!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.textDisabled,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
