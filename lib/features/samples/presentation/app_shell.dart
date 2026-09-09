import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../showcase/presentation/showcase_screen.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'sign_in_screen.dart';

// ============================================================
// APP SHELL — bottom-nav host matching reference design
// ============================================================

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const List<Widget> _pages = [
    DashboardScreen(),
    SignInScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void _openTokens() => Navigator.of(
    context,
  ).push(MaterialPageRoute<void>(builder: (_) => const ShowcaseScreen()));

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: _ShellNavBar(
          index: _index,
          onTap: (i) => setState(() => _index = i),
          onTokensTap: _openTokens,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Nav bar — exactly matches reference design:
//   Home · Sign In · Profile · Settings | ⚡S (tokens pill)
//   Active item: icon + label in primary blue
//   Active indicator: short bold line below label (not above)
//   Inactive: textSecondary icon + label
// ----------------------------------------------------------
class _ShellNavBar extends StatelessWidget {
  const _ShellNavBar({
    required this.index,
    required this.onTap,
    required this.onTokensTap,
  });

  final int index;
  final ValueChanged<int> onTap;
  final VoidCallback onTokensTap;

  static const _items = [
    (icon: Icons.home_outlined, filled: Icons.home_rounded, label: 'Home'),
    (icon: Icons.login_outlined, filled: Icons.login_rounded, label: 'Sign In'),
    (
      icon: Icons.person_outlined,
      filled: Icons.person_rounded,
      label: 'Profile',
    ),
    (
      icon: Icons.settings_outlined,
      filled: Icons.settings_rounded,
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.borderDefault)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56, // PDF §7.7
          child: Row(
            children: [
              // ── 4 tabs ────────────────────────────────
              for (int i = 0; i < _items.length; i++)
                Expanded(
                  child: _NavTab(
                    icon: _items[i].icon,
                    filledIcon: _items[i].filled,
                    label: _items[i].label,
                    isActive: i == index,
                    onTap: () => onTap(i),
                  ),
                ),

              // ── Vertical separator ────────────────────
              const _VDivider(),

              // ── Tokens shortcut ───────────────────────
              _TokensButton(onTap: onTokensTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.icon,
    required this.filledIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData filledIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textSecondary;

    return Semantics(
      label: label,
      selected: isActive,
      button: true,
      child: InkWell(
        onTap: onTap,
        highlightColor: AppColors.primary.withValues(alpha: 0.06),
        splashColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: Icon(
                isActive ? filledIcon : icon,
                key: ValueKey(isActive),
                size: 22,
                color: color,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: color,
                height: 1.2,
              ),
            ),
            // Active underline — matches reference exactly
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isActive ? 24 : 0,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 28, color: AppColors.borderDefault);
  }
}

/// Tokens shortcut pill — reference shows a rounded blue pill with "S" letter.
class _TokensButton extends StatelessWidget {
  const _TokensButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Open design tokens reference',
      button: true,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: SizedBox(
          width: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'S',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Tokens',
                style: AppTypography.small.copyWith(
                  fontSize: 10,
                  color: const Color(0xFF7C3AED),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5), // align baseline with tabs
            ],
          ),
        ),
      ),
    );
  }
}
