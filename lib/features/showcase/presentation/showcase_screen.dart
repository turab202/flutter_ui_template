import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import 'sections/showcase_avatars_icons_section.dart';
import 'sections/showcase_badges_section.dart';
import 'sections/showcase_bottom_nav_section.dart';
import 'sections/showcase_buttons_section.dart';
import 'sections/showcase_cards_section.dart';
import 'sections/showcase_colors_section.dart';
import 'sections/showcase_inputs_section.dart';
import 'sections/showcase_overlays_section.dart';
import 'sections/showcase_responsive_section.dart';
import 'sections/showcase_spacing_section.dart';
import 'sections/showcase_states_section.dart';
import 'sections/showcase_typography_section.dart';

// ============================================================
// SHOWCASE SCREEN
// ============================================================
//
// A visual component library that demonstrates the entire
// Flutter UI Design System in one scrollable screen.
//
// This is NOT a production application screen.
// It exists solely to preview and validate the design system.
//
// Sections covered (per user requirement):
//  1.  Colors
//  2.  Typography
//  3.  Spacing
//  4.  Buttons
//  5.  Text fields
//  6.  Cards
//  7.  List items
//  8.  Badges/chips
//  9.  Bottom navigation
//  10. Dialog
//  11. Bottom sheet
//  12. Snackbar/toast
//  13. Loading/skeleton
//  14. Empty state
//  15. Error state
//  16. Icons
//  17. Avatars
//  18. Responsive behavior
//
// ============================================================

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // ------------------------------------------------
          // App bar
          // ------------------------------------------------
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            title: Text(
              'UI Design System',
              style: AppTypography.h3.copyWith(color: Colors.white),
            ),
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      Color(0xFF004499),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.sm, 56, AppSpacing.sm, AppSpacing.xs),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Flutter UI Template',
                          style: AppTypography.h2.copyWith(
                              color: Colors.white),
                        ),
                        Text(
                          'Mobile App UI Consistency Guide v2.0',
                          style: AppTypography.caption.copyWith(
                              color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ------------------------------------------------
          // Body sections
          // ------------------------------------------------
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                _buildSections(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSections(BuildContext context) {
    const gap = SizedBox(height: AppSpacing.sm);

    return [
      // --------------------------------------------------------
      // Intro banner
      // --------------------------------------------------------
      _IntroBanner(),
      gap,

      // --------------------------------------------------------
      // 1. Spacing (PDF Section 1)
      // --------------------------------------------------------
      const ShowcaseSpacingSection(),
      gap,

      // --------------------------------------------------------
      // 2. Typography (PDF Section 2)
      // --------------------------------------------------------
      const ShowcaseTypographySection(),
      gap,

      // --------------------------------------------------------
      // 3. Colors (PDF Section 3)
      // --------------------------------------------------------
      const ShowcaseColorsSection(),
      gap,

      // --------------------------------------------------------
      // 4. Buttons (PDF Section 7.1)
      // --------------------------------------------------------
      const ShowcaseButtonsSection(),
      gap,

      // --------------------------------------------------------
      // 5. Text Fields (PDF Section 7.2)
      // --------------------------------------------------------
      const ShowcaseInputsSection(),
      gap,

      // --------------------------------------------------------
      // 6. Cards + 7. List Items (PDF Sections 7.3–7.4)
      // --------------------------------------------------------
      const ShowcaseCardsSection(),
      gap,

      // --------------------------------------------------------
      // 8. Badges/Chips (PDF Section 7.6)
      // --------------------------------------------------------
      const ShowcaseBadgesSection(),
      gap,

      // --------------------------------------------------------
      // 9. Bottom Navigation (PDF Section 7.7)
      // --------------------------------------------------------
      const ShowcaseBottomNavSection(),
      gap,

      // --------------------------------------------------------
      // 10–12. Dialog, Bottom Sheet, Snackbar (PDF 7.8–7.9)
      // --------------------------------------------------------
      const ShowcaseOverlaysSection(),
      gap,

      // --------------------------------------------------------
      // 13–15. Loading, Skeleton, Empty, Error (PDF 7.10–7.11)
      // --------------------------------------------------------
      const ShowcaseStatesSection(),
      gap,

      // --------------------------------------------------------
      // 16–17. Icons & Avatars (PDF Section 7.12)
      // --------------------------------------------------------
      const ShowcaseAvatarsIconsSection(),
      gap,

      // --------------------------------------------------------
      // 18. Responsive Behavior (PDF Section 9)
      // --------------------------------------------------------
      const ShowcaseResponsiveSection(),

      // Bottom padding
      const SizedBox(height: AppSpacing.xl),
    ];
  }
}

// ----------------------------------------------------------
// Intro banner
// ----------------------------------------------------------

class _IntroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveConstrainedBox(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.08),
              AppColors.primary.withValues(alpha: 0.03),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.design_services,
                    color: AppColors.primary, size: 20),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Design System Showcase',
                  style: AppTypography.h3.copyWith(
                      color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              'All components, tokens, and patterns from the '
              'Mobile App UI Consistency Guide v2.0. '
              'Every value traces back to a PDF specification or is '
              'clearly marked as an implementation decision.',
              style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xxs,
              runSpacing: AppSpacing.xxs,
              children: const [
                _Tag('8pt Grid'),
                _Tag('WCAG AA'),
                _Tag('44pt Touch Targets'),
                _Tag('Reduce Motion'),
                _Tag('Semantic Labels'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: AppTypography.small.copyWith(
            color: AppColors.primary, fontSize: 11),
      ),
    );
  }
}
