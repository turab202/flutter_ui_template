import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/widgets/app_bottom_navigation.dart';
import '../showcase_section.dart';

class ShowcaseBottomNavSection extends StatefulWidget {
  const ShowcaseBottomNavSection({super.key});

  @override
  State<ShowcaseBottomNavSection> createState() =>
      _ShowcaseBottomNavSectionState();
}

class _ShowcaseBottomNavSectionState extends State<ShowcaseBottomNavSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '7.7 Bottom Navigation',
      subtitle:
          'PDF Section 7.7 — NavBar height 56pt, item height 44pt (touch target)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive preview — tap items to change selection',
            style: AppTypography.caption
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppBottomNavigation(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                const AppBottomNavItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavItem(
                  icon: const Icon(Icons.search_outlined),
                  label: 'Search',
                  badge: NotificationDot(count: 2),
                ),
                const AppBottomNavItem(
                  icon: Icon(Icons.favorite_border),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Saved',
                ),
                const AppBottomNavItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
