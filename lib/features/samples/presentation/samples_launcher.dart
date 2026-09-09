import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../showcase/presentation/showcase_screen.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'sign_in_screen.dart';

// ============================================================
// SAMPLES LANDING SCREEN
// The app's default home screen.
// Shows the 4 sample screens as launch cards, plus a link to
// the full component-reference showcase.
// ============================================================

class SamplesLandingScreen extends StatelessWidget {
  const SamplesLandingScreen({super.key});

  static const List<_SampleEntry> _entries = [
    _SampleEntry(
      title: 'Sign In',
      subtitle: 'Auth form, validation, social login, loading states',
      icon: Icons.login_rounded,
      colorHex: 0xFF0066CC,
      tags: ['Form', 'Auth', 'Validation'],
    ),
    _SampleEntry(
      title: 'Dashboard',
      subtitle: 'Stats, activity feed, projects, bottom nav, responsive',
      icon: Icons.dashboard_rounded,
      colorHex: 0xFF059669,
      tags: ['Cards', 'List', 'Navigation'],
    ),
    _SampleEntry(
      title: 'Profile',
      subtitle: 'Avatar, tabs, dialog, bottom sheet, skill chips',
      icon: Icons.person_rounded,
      colorHex: 0xFF7C3AED,
      tags: ['Avatar', 'Tabs', 'Dialog'],
    ),
    _SampleEntry(
      title: 'Settings',
      subtitle: 'Toggles, checkboxes, slider, account actions',
      icon: Icons.settings_rounded,
      colorHex: 0xFFD97706,
      tags: ['Toggle', 'Controls', 'Forms'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayout.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // ── App bar ──────────────────────────────────────
          SliverAppBar(
            pinned: true,
            expandedHeight: 140,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            // No back button — this is the root screen
            automaticallyImplyLeading: false,
            actions: [
              // Component reference link
              Semantics(
                label: 'Open component reference',
                button: true,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ShowcaseScreen(),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    margin: const EdgeInsets.only(right: AppSpacing.xs),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.widgets_outlined,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Components',
                          style: AppTypography.small.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, Color(0xFF003A8C)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      56,
                      AppSpacing.sm,
                      AppSpacing.xs,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.bolt_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              'Flutter UI Template',
                              style: AppTypography.h2.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'Enterprise design system · v2.0',
                          style: AppTypography.caption.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Intro text
                _IntroBlock(),
                const SizedBox(height: AppSpacing.sm),

                // Sample screen cards
                Text(
                  'Sample Screens',
                  style: AppTypography.h3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'Tap any card to open a fully interactive demo.',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),

                if (isTablet)
                  _TwoColumnGrid(entries: _entries)
                else
                  _SingleColumnList(entries: _entries),

                const SizedBox(height: AppSpacing.sm),

                // Component reference card
                _ComponentReferenceCard(),

                const SizedBox(height: AppSpacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Intro block
// ----------------------------------------------------------
class _IntroBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.07),
            AppColors.primary.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.verified_rounded,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Production-ready design system',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Built from the Mobile App UI Consistency Guide v2.0. '
            'Every value is a named token — no hard-coded colors, '
            'spacing, or sizes.',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xxs,
            runSpacing: AppSpacing.xxs,
            children: const [
              _Pill('8pt Grid'),
              _Pill('WCAG AA'),
              _Pill('44pt Targets'),
              _Pill('Reduce Motion'),
              _Pill('Semantic Labels'),
              _Pill('Dark Mode'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: AppTypography.small.copyWith(
          color: AppColors.primary,
          fontSize: 11,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Component reference card — navigates to ShowcaseScreen
// ----------------------------------------------------------
class _ComponentReferenceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Open component reference',
      button: true,
      child: GestureDetector(
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => const ShowcaseScreen())),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x29000000),
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.widgets_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Component Reference',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'All tokens, states, and variants in one place',
                      style: AppTypography.caption.copyWith(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white54,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Grid layouts
// ----------------------------------------------------------
class _TwoColumnGrid extends StatelessWidget {
  const _TwoColumnGrid({required this.entries});
  final List<_SampleEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < entries.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _SampleCard(entry: entries[i])),
                const SizedBox(width: AppSpacing.xs),
                if (i + 1 < entries.length)
                  Expanded(child: _SampleCard(entry: entries[i + 1]))
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
      ],
    );
  }
}

class _SingleColumnList extends StatelessWidget {
  const _SingleColumnList({required this.entries});
  final List<_SampleEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: _SampleCard(entry: e),
            ),
          )
          .toList(),
    );
  }
}

// ----------------------------------------------------------
// Sample card
// ----------------------------------------------------------
class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.entry});
  final _SampleEntry entry;

  Widget _screenForEntry() {
    switch (entry.title) {
      case 'Sign In':
        return const SignInScreen();
      case 'Dashboard':
        return const DashboardScreen();
      case 'Profile':
        return const ProfileScreen();
      case 'Settings':
        return const SettingsScreen();
      default:
        return const SignInScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(entry.colorHex);

    return Semantics(
      label: '${entry.title} sample screen',
      button: true,
      child: GestureDetector(
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => _screenForEntry())),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: AppRadius.mdAll,
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
            border: Border.all(color: AppColors.borderDefault),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Colour band ─────────────────────────────
              Container(
                height: 88,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color, Color.lerp(color, Colors.black, 0.25)!],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -16,
                      top: -16,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.20),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              entry.icon,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.20),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.play_arrow_rounded,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'Preview',
                                  style: AppTypography.small.copyWith(
                                    color: Colors.white,
                                    fontSize: 11,
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

              // ── Text + tags ──────────────────────────────
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      style: AppTypography.h3.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      entry.subtitle,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.xxs,
                      runSpacing: AppSpacing.xxs,
                      children: entry.tags
                          .map(
                            (t) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: color.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Text(
                                t,
                                style: AppTypography.small.copyWith(
                                  color: color,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
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
// Data class
// ----------------------------------------------------------
class _SampleEntry {
  const _SampleEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colorHex,
    required this.tags,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final int colorHex;
  final List<String> tags;
}

// ----------------------------------------------------------
// SamplesLauncherSection — kept for backward compat with
// ShowcaseScreen (no longer embedded there, but class name
// still referenced; can be cleaned up later).
// This is now just an alias to SamplesLandingScreen content.
// ----------------------------------------------------------
@Deprecated('Use SamplesLandingScreen directly as the app home.')
class SamplesLauncherSection extends StatelessWidget {
  const SamplesLauncherSection({super.key});

  @override
  Widget build(BuildContext context) => const SamplesLandingScreen();
}
