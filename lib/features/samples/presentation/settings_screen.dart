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
import '../widgets/sample_screen_shell.dart';

// ============================================================
// SETTINGS SCREEN — Sample Screen
// Demonstrates: settings sections, list tiles with icons,
// toggle/switch controls, radio buttons, sliders, checkboxes,
// dividers, section headers, account actions, sign out dialog,
// responsive layout.
// ============================================================

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Toggle states
  final Map<String, bool> _toggles = {};
  // Notification frequency radio
  int _notifFrequency = 1; // 0=instant, 1=hourly, 2=daily
  // Text size slider
  double _textScale = 1.0;
  // Checkboxes for notification types
  bool _notifMentions = true;
  bool _notifComments = true;
  bool _notifTasks = false;
  bool _notifUpdates = false;

  bool _getToggle(String key, bool defaultVal) => _toggles[key] ?? defaultVal;

  void _setToggle(String key, bool val) {
    setState(() => _toggles[key] = val);
    showAppToast(
      context,
      message: val ? '$key enabled' : '$key disabled',
      variant: val ? AppToastVariant.success : AppToastVariant.neutral,
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
          'Are you sure you want to sign out? '
          'You can sign back in at any time.',
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

  void _confirmDeleteAccount() {
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
          'This will permanently delete your account and all your data. '
          'This action cannot be undone.',
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

    return SampleScreenShell(
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Column(
            children: [
              // App bar
              _SettingsAppBar(),
              Expanded(
                child: isTablet
                    ? _TabletLayout(child: _buildScrollBody(context))
                    : _buildScrollBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      children: [
        // ── Profile card ───────────────────────────────────
        _ProfileCard(),
        const SizedBox(height: AppSpacing.xs),

        // ── Appearance ─────────────────────────────────────
        _SectionHeader(title: 'Appearance'),
        _SettingsGroup(
          children: [
            _ToggleTile(
              icon: Icons.dark_mode_outlined,
              label: 'Dark Mode',
              subtitle: 'Switch to dark theme',
              value: _getToggle('darkMode', false),
              onChanged: (v) => _setToggle('darkMode', v),
            ),
            const AppDivider(indent: 52),
            _ToggleTile(
              icon: Icons.view_compact_outlined,
              label: 'Compact Layout',
              subtitle: 'Reduce spacing in lists',
              value: _getToggle('compactLayout', true),
              onChanged: (v) => _setToggle('compactLayout', v),
            ),
            const AppDivider(indent: 52),
            // Text size slider
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.text_fields_rounded,
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
                          horizontal: AppSpacing.xs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _textScale == 1.0
                              ? 'Default'
                              : _textScale < 1.0
                              ? 'Small'
                              : 'Large',
                          style: AppTypography.small.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Semantics(
                    label: 'Text size slider',
                    child: Slider(
                      value: _textScale,
                      min: 0.8,
                      max: 1.4,
                      divisions: 6,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.borderDefault,
                      onChanged: (v) => setState(() => _textScale = v),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'A',
                        style: AppTypography.small.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                      Text(
                        'A',
                        style: AppTypography.h3.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const AppDivider(indent: 52),
            _NavigateTile(
              icon: Icons.color_lens_outlined,
              label: 'Accent Color',
              subtitle: 'Blue (default)',
              onTap: () => showAppToast(
                context,
                message: 'Color picker (demo)',
                variant: AppToastVariant.neutral,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xs),

        // ── Notifications ──────────────────────────────────
        _SectionHeader(title: 'Notifications'),
        _SettingsGroup(
          children: [
            _ToggleTile(
              icon: Icons.notifications_outlined,
              label: 'Push Notifications',
              subtitle: 'Receive alerts on your device',
              value: _getToggle('pushNotif', true),
              onChanged: (v) => _setToggle('pushNotif', v),
            ),
            const AppDivider(indent: 52),
            _ToggleTile(
              icon: Icons.email_outlined,
              label: 'Email Digest',
              subtitle: 'Daily summary at 9am',
              value: _getToggle('emailDigest', true),
              onChanged: (v) => _setToggle('emailDigest', v),
            ),
            const AppDivider(indent: 52),

            // Notification type checkboxes
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.tune_outlined,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Notify me about',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _CheckboxRow(
                    label: 'Mentions & replies',
                    value: _notifMentions,
                    onChanged: (v) =>
                        setState(() => _notifMentions = v ?? false),
                  ),
                  _CheckboxRow(
                    label: 'Comments on my work',
                    value: _notifComments,
                    onChanged: (v) =>
                        setState(() => _notifComments = v ?? false),
                  ),
                  _CheckboxRow(
                    label: 'Task assignments',
                    value: _notifTasks,
                    onChanged: (v) => setState(() => _notifTasks = v ?? false),
                  ),
                  _CheckboxRow(
                    label: 'Product updates',
                    value: _notifUpdates,
                    onChanged: (v) =>
                        setState(() => _notifUpdates = v ?? false),
                  ),
                ],
              ),
            ),
            const AppDivider(indent: 52),

            // Frequency radio
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_outlined,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Delivery frequency',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  _RadioRow(
                    label: 'Instant',
                    value: 0,
                    groupValue: _notifFrequency,
                    onChanged: (v) => setState(() => _notifFrequency = v ?? 0),
                  ),
                  _RadioRow(
                    label: 'Every hour',
                    value: 1,
                    groupValue: _notifFrequency,
                    onChanged: (v) => setState(() => _notifFrequency = v ?? 1),
                  ),
                  _RadioRow(
                    label: 'Once a day',
                    value: 2,
                    groupValue: _notifFrequency,
                    onChanged: (v) => setState(() => _notifFrequency = v ?? 2),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xs),

        // ── Privacy & Security ─────────────────────────────
        _SectionHeader(title: 'Privacy & Security'),
        _SettingsGroup(
          children: [
            _NavigateTile(
              icon: Icons.security_outlined,
              label: 'Two-Factor Authentication',
              subtitle: 'Enabled via authenticator app',
              badge: const AppBadge(
                label: 'On',
                variant: AppBadgeVariant.success,
              ),
              onTap: () =>
                  showAppToast(context, message: '2FA settings (demo)'),
            ),
            const AppDivider(indent: 52),
            _NavigateTile(
              icon: Icons.history_outlined,
              label: 'Login Activity',
              subtitle: 'View recent sign-ins',
              onTap: () =>
                  showAppToast(context, message: 'Login activity (demo)'),
            ),
            const AppDivider(indent: 52),
            _NavigateTile(
              icon: Icons.privacy_tip_outlined,
              label: 'Data & Privacy',
              subtitle: 'Manage your data',
              onTap: () =>
                  showAppToast(context, message: 'Privacy settings (demo)'),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xs),

        // ── About ──────────────────────────────────────────
        _SectionHeader(title: 'About'),
        _SettingsGroup(
          children: [
            _InfoTile(
              icon: Icons.info_outline_rounded,
              label: 'Version',
              value: '2.4.1 (build 1042)',
            ),
            const AppDivider(indent: 52),
            _NavigateTile(
              icon: Icons.description_outlined,
              label: 'Terms of Service',
              onTap: () => showAppToast(context, message: 'Terms (demo)'),
            ),
            const AppDivider(indent: 52),
            _NavigateTile(
              icon: Icons.policy_outlined,
              label: 'Privacy Policy',
              onTap: () =>
                  showAppToast(context, message: 'Privacy policy (demo)'),
            ),
            const AppDivider(indent: 52),
            _NavigateTile(
              icon: Icons.code_outlined,
              label: 'Open Source Licenses',
              onTap: () => showAppToast(context, message: 'Licenses (demo)'),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        // ── Account actions ────────────────────────────────
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
                onPressed: _confirmDeleteAccount,
                variant: AppButtonVariant.destructive,
                leadingIcon: const Icon(Icons.delete_forever_outlined),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.xl),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Row(
        children: [
          Semantics(
            label: 'Go back',
            button: true,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: BorderRadius.circular(22),
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.textPrimary,
                  size: 22,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Settings',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Semantics(
            label: 'Help',
            button: true,
            child: InkWell(
              onTap: () => showAppToast(
                context,
                message: 'Help center (demo)',
                variant: AppToastVariant.neutral,
              ),
              borderRadius: BorderRadius.circular(22),
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(
                  Icons.help_outline_rounded,
                  color: AppColors.textSecondary,
                  size: 22,
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
// Tablet layout (two-column)
// ----------------------------------------------------------
class _TabletLayout extends StatelessWidget {
  const _TabletLayout({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680),
        child: child,
      ),
    );
  }
}

// ----------------------------------------------------------
// Profile summary card at top
// ----------------------------------------------------------
class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 2,
            offset: Offset(0, 1),
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
// Section header
// ----------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.xs,
        AppSpacing.sm,
        AppSpacing.xxs,
      ),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.small.copyWith(
          color: AppColors.textDisabled,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Settings group (white card)
// ----------------------------------------------------------
class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 2,
            offset: Offset(0, 1),
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
// Toggle tile
// ----------------------------------------------------------
class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
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
              thumbColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return Colors.white;
                return null;
              }),
              materialTapTargetSize: MaterialTapTargetSize.padded,
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Navigate tile
// ----------------------------------------------------------
class _NavigateTile extends StatelessWidget {
  const _NavigateTile({
    required this.icon,
    required this.label,
    this.subtitle,
    this.badge,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? badge;
  final VoidCallback onTap;

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
              if (badge != null) ...[
                badge!,
                const SizedBox(width: AppSpacing.xs),
              ],
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

// ----------------------------------------------------------
// Info tile (no interaction, just displays a value)
// ----------------------------------------------------------
class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
            ),
          ),
          Text(
            value,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Checkbox row
// ----------------------------------------------------------
class _CheckboxRow extends StatelessWidget {
  const _CheckboxRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 44,
          height: 44,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        Text(
          label,
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

// ----------------------------------------------------------
// Radio row — uses RadioListTile to avoid deprecated Radio API
// ----------------------------------------------------------
class _RadioRow extends StatelessWidget {
  const _RadioRow({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });
  final String label;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: groupValue == value
                        ? AppColors.primary
                        : AppColors.borderStrong,
                    width: groupValue == value ? 6 : 2,
                  ),
                ),
              ),
            ),
          ),
          Text(
            label,
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
