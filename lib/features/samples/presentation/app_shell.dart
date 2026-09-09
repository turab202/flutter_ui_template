import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../showcase/presentation/showcase_screen.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'sign_in_screen.dart';

// ============================================================
// APP SHELL
// The root widget that hosts all four sample screens inside
// an IndexedStack (so each tab keeps its scroll position and
// state) and renders a polished custom bottom navigation bar.
//
// A "Components" shortcut button in the nav bar pushes the
// design-system reference (ShowcaseScreen) as a modal route.
// ============================================================

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  // The four persistent tab pages.
  // IndexedStack keeps them alive so scrolling / form state
  // is preserved when the user switches tabs.
  static const List<Widget> _pages = [
    DashboardScreen(),
    SignInScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  static const List<_NavItem> _navItems = [
    _NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.login_outlined,
      activeIcon: Icons.login_rounded,
      label: 'Sign In',
    ),
    _NavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
    ),
    _NavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      label: 'Settings',
    ),
  ];

  void _openComponentReference() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ShowcaseScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Keep status-bar icons dark (light bg) for all tabs.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        // IndexedStack keeps all pages in memory — no rebuild on switch.
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: _AppShellNavBar(
          currentIndex: _currentIndex,
          items: _navItems,
          onTap: (i) => setState(() => _currentIndex = i),
          onComponentsTap: _openComponentReference,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// _AppShellNavBar
// Custom bottom navigation bar that renders the four main
// tabs plus the "⚡ Components" shortcut pill.
// Heights match the design system spec:
//   PDF §7.7 NavBar = 56pt, item = 44pt touch target.
// ----------------------------------------------------------
class _AppShellNavBar extends StatelessWidget {
  const _AppShellNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
    required this.onComponentsTap,
  });

  final int currentIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;
  final VoidCallback onComponentsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.borderDefault, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56, // PDF §7.7: NavBar height = 56pt
          child: Row(
            children: [
              // ── Four main tabs ─────────────────────────
              ...List.generate(items.length, (i) {
                final item = items[i];
                final isActive = i == currentIndex;
                return Expanded(
                  child: _NavTab(
                    item: item,
                    isActive: isActive,
                    onTap: () => onTap(i),
                  ),
                );
              }),

              // ── Divider ────────────────────────────────
              Container(
                width: 1,
                height: 32,
                color: AppColors.borderDefault,
                margin: const EdgeInsets.symmetric(
                  vertical: AppSpacing.xs,
                ),
              ),

              // ── Components shortcut ────────────────────
              _ComponentsButton(onTap: onComponentsTap),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Individual nav tab
// ----------------------------------------------------------
class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textSecondary;

    return Semantics(
      label: item.label,
      selected: isActive,
      button: true,
      child: InkWell(
        onTap: onTap,
        // Entire 56pt column is tappable — meets 44pt minimum
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Active indicator dot
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: isActive ? 20 : 0,
              height: 3,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: Icon(
                isActive ? item.activeIcon : item.icon,
                key: ValueKey(isActive),
                size: 22,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: AppTypography.small.copyWith(
                color: color,
                fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.w400,
                fontSize: 10,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Components shortcut button — compact pill
// ----------------------------------------------------------
class _ComponentsButton extends StatelessWidget {
  const _ComponentsButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Open component reference',
      button: true,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF003A8C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.bolt_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'DS',
                      style: AppTypography.small.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tokens',
                style: AppTypography.small.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
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
// Data class for nav item definitions
// ----------------------------------------------------------
class _NavItem {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
  final IconData icon;
  final IconData activeIcon;
  final String label;
}
