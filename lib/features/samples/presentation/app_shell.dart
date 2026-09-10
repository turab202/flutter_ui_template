import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_bottom_navigation.dart';
import '../../showcase/presentation/showcase_screen.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'sign_in_screen.dart';

// ============================================================
// APP SHELL
// Shared navigation host for all four sample screens.
// ONE navigation implementation, ONE navigation state.
// Background and safe-area handling are centralized here.
// ============================================================

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  // Pages are kept alive via IndexedStack — no rebuild on tab switch.
  static const List<Widget> _pages = [
    DashboardScreen(),
    SignInScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void _openTokens() => Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const ShowcaseScreen()),
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      // Scaffold background comes from AppTheme → AppColors.background.
      // Individual screens do NOT set their own background.
      child: Scaffold(
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: _index,
          onTap: (i) {
            if (i == 4) {
              _openTokens();
              return;
            }
            setState(() => _index = i);
          },
          items: [
            const AppBottomNavItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            const AppBottomNavItem(
              icon: Icon(Icons.login_outlined),
              activeIcon: Icon(Icons.login_rounded),
              label: 'Sign In',
            ),
            const AppBottomNavItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
            const AppBottomNavItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
            AppBottomNavItem(
              icon: const Icon(Icons.auto_awesome_outlined),
              activeIcon: const Icon(Icons.auto_awesome_rounded),
              label: 'Tokens',
              badge: SizedBox(
                width: 8,
                height: 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
