import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_divider.dart';
import '../../../core/widgets/app_snackbar.dart';

// ============================================================
// SETTINGS SCREEN
// 🎨 PROJECT-SPECIFIC — sample content only
// Matches reference: title + subtitle header, grouped sections
// (Appearance, Notifications, Account, Privacy & Security)
// with toggle rows and navigate rows.
// ============================================================

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Map<String, bool> _toggles = {
    'Push Notifications': true,
    'Email Notifications': true,
    'Biometric Authentication': true,
  };

  bool _get(String k) => _toggles[k] ?? false;

  void _set(String k, bool v) {
    setState(() => _toggles[k] = v);
    showAppToast(
      context,
      message: '$k ${v ? 'enabled' : 'disabled'}',
      variant: v ? AppToastVariant.success : AppToastVariant.neutral,
    );
  }

  void _navigate(String label) =>
      showAppToast(context, message: '$label (demo)');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveConstrainedBox(
        child: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          children: [
            // ── Header ──────────────────────────────────────
            _SettingsHeader(),

            // ── Appearance ──────────────────────────────────
            _SectionLabel(label: 'Appearance'),
            _SettingsGroup(
              children: [
                _NavRow(
                  icon: Icons.light_mode_outlined,
                  label: 'Theme',
                  value: 'Light',
                  onTap: () => _navigate('Theme'),
                ),
                const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
                _NavRow(
                  icon: Icons.text_fields_outlined,
                  label: 'Text Size',
                  value: 'Normal',
                  onTap: () => _navigate('Text Size'),
                ),
                const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
                _NavRow(
                  icon: Icons.language_outlined,
                  label: 'Language',
                  value: 'English',
                  onTap: () => _navigate('Language'),
                ),
              ],
            ),

            // ── Notifications ────────────────────────────────
            _SectionLabel(label: 'Notifications'),
            _SettingsGroup(
              children: [
                _ToggleRow(
                  icon: Icons.notifications_outlined,
                  label: 'Push Notifications',
                  subtitle: 'Get notified about project updates,\ntasks and team activity',
                  value: _get('Push Notifications'),
                  onChanged: (v) => _set('Push Notifications', v),
                ),
                const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
                _ToggleRow(
                  icon: Icons.mail_outline_rounded,
                  label: 'Email Notifications',
                  subtitle: 'Important updates and reminders',
                  value: _get('Email Notifications'),
                  onChanged: (v) => _set('Email Notifications', v),
                ),
                const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
                _NavRow(
                  icon: Icons.alarm_outlined,
                  label: 'Reminders',
                  subtitle: 'Daily goals and deadlines',
                  onTap: () => _navigate('Reminders'),
                ),
              ],
            ),

            // ── Account ──────────────────────────────────────
            _SectionLabel(label: 'Account'),
            _SettingsGroup(
              children: [
                _NavRow(
                  icon: Icons.person_outline_rounded,
                  label: 'Personal Information',
                  subtitle: 'Update your profile details',
                  onTap: () => _navigate('Personal Information'),
                ),
                const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
                _NavRow(
                  icon: Icons.lock_outline_rounded,
                  label: 'Change Password',
                  subtitle: 'Keep your account secure',
                  onTap: () => _navigate('Change Password'),
                ),
                const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
                _NavRow(
                  icon: Icons.g_mobiledata_rounded,
                  label: 'Connected Accounts',
                  subtitle: 'Google, Apple and more',
                  onTap: () => _navigate('Connected Accounts'),
                ),
              ],
            ),

            // ── Privacy & Security ───────────────────────────
            _SectionLabel(label: 'Privacy & Security'),
            _SettingsGroup(
              children: [
                _ToggleRow(
                  icon: Icons.fingerprint_rounded,
                  label: 'Biometric Authentication',
                  subtitle: 'Use fingerprint or Face ID',
                  value: _get('Biometric Authentication'),
                  onChanged: (v) => _set('Biometric Authentication', v),
                ),
                const AppDivider(indent: AppSpacing.xl + AppSpacing.sm),
                _NavRow(
                  icon: Icons.security_outlined,
                  label: 'Two-Factor Authentication',
                  subtitle: 'Add an extra layer of security',
                  onTap: () => _navigate('Two-Factor Authentication'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SETTINGS HEADER
// ============================================================

class _SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Manage your account and app preferences.',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION LABEL
// ============================================================

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.xxs,
      ),
      child: Text(
        label,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: AppTypography.weightSemibold,
        ),
      ),
    );
  }
}

// ============================================================
// SETTINGS GROUP CARD
// ============================================================

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.borderDefault),
        boxShadow: AppShadows.elevation1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

// ============================================================
// TOGGLE ROW
// ============================================================

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                icon,
                size: AppConstants.iconSm,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
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
                    const SizedBox(height: 2),
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

// ============================================================
// NAVIGATE ROW
// ============================================================

class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.icon,
    required this.label,
    this.subtitle,
    this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final String? value;
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
            vertical: AppSpacing.xs,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: AppConstants.iconSm,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
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
                      const SizedBox(height: 2),
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
              if (value != null) ...[
                Text(
                  value!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xxs),
              ],
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
