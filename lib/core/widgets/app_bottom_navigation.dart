import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP BOTTOM NAVIGATION
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.7
// ============================================================
//
// PDF Specifications:
//   NavBar height:  56pt
//   Item height:    44pt (meets touch target minimum per PDF Sec. 4)
//
// PDF Section 4: "Minimum touch area: 44×44pt — non-negotiable."
// Each nav item is 44pt tall, satisfying this requirement.
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT (heights, touch targets)
// 🎨 PROJECT-SPECIFIC — items, labels, and icons will vary per app.
//
// ============================================================

// ----------------------------------------------------------
// AppBottomNavItem — data model for a single nav entry.
// ----------------------------------------------------------

class AppBottomNavItem {
  const AppBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badge,
  });

  final Widget icon;
  final String label;

  /// Optional icon shown when this item is selected.
  final Widget? activeIcon;

  /// Optional notification dot/count overlay.
  final Widget? badge;
}

// ----------------------------------------------------------
// AppBottomNavigation
// A custom bottom navigation bar that matches the exact PDF
// height spec (56pt bar, 44pt items) and supports badges.
// ----------------------------------------------------------

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.elevation = 8,
  });

  /// 🎨 PROJECT-SPECIFIC: Replace with your app's navigation items.
  final List<AppBottomNavItem> items;

  /// Index of the currently selected item.
  final int currentIndex;

  final ValueChanged<int> onTap;

  /// Defaults to AppColors.background (white).
  final Color? backgroundColor;

  /// Defaults to AppColors.primary.
  final Color? selectedColor;

  /// Defaults to AppColors.textSecondary.
  final Color? unselectedColor;

  /// Show text labels under icons.
  final bool showLabels;

  /// Shadow elevation above the bar.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.background;
    final selected = selectedColor ?? AppColors.primary;
    final unselected = unselectedColor ?? AppColors.textSecondary;

    return Material(
      elevation: elevation,
      color: bg,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppConstants.bottomNavHeight, // PDF: 56pt
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isActive = index == currentIndex;
              final color = isActive ? selected : unselected;

              return Expanded(
                child: Semantics(
                  label: item.label,
                  button: true,
                  selected: isActive,
                  child: InkWell(
                    onTap: () => onTap(index),
                    child: SizedBox(
                      height: AppConstants.bottomNavItemHeight, // PDF: 44pt
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Icon with optional badge
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 150),
                                child: IconTheme(
                                  key: ValueKey(isActive),
                                  data: IconThemeData(
                                    color: color,
                                    size: AppConstants.iconMd, // 24pt
                                  ),
                                  child: isActive && item.activeIcon != null
                                      ? item.activeIcon!
                                      : item.icon,
                                ),
                              ),
                              if (item.badge != null)
                                Positioned(
                                  top: -4,
                                  right: -6,
                                  child: item.badge!,
                                ),
                            ],
                          ),
                          if (showLabels) ...[
                            const SizedBox(height: 2),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 150),
                              style: AppTypography.small.copyWith(
                                color: color,
                                fontWeight: isActive
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              child: Text(
                                item.label,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
