import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../showcase_section.dart';

class ShowcaseResponsiveSection extends StatelessWidget {
  const ShowcaseResponsiveSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveLayout.breakpointOf(context);
    final width = MediaQuery.of(context).size.width;
    final isTablet = ResponsiveLayout.isTablet(context);

    return ShowcaseSection(
      title: '9. Responsive Rules',
      subtitle:
          'PDF Section 9 — mobile 0–375pt, mobile-large 376–428pt, tablet 429–1024pt',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current breakpoint indicator
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(
                  isTablet ? Icons.tablet_mac : Icons.smartphone,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current: ${bp.name} (${width.toStringAsFixed(0)}pt wide)',
                        style: AppTypography.body.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        isTablet
                            ? 'Content capped at ${AppConstants.maxContentWidth.toInt()}pt, centered layout preferred'
                            : 'Full-width layout active',
                        style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // Breakpoint table
          _BreakpointRow('mobile',       '0–375pt',    'iPhone SE',   bp == AppBreakpoint.mobile),
          const SizedBox(height: AppSpacing.xxs),
          _BreakpointRow('mobile-large', '376–428pt',  'iPhone Pro',  bp == AppBreakpoint.mobileLarge),
          const SizedBox(height: AppSpacing.xxs),
          _BreakpointRow('tablet',       '429–1024pt', 'iPad',        bp == AppBreakpoint.tablet),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Adaptive value example:',
            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Columns = ${ResponsiveLayout.resolve(context, mobile: 1, tablet: 2)}',
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          ),

          const SizedBox(height: AppSpacing.sm),

          // ResponsiveConstrainedBox demo
          Text(
            'ResponsiveConstrainedBox — content capped at 640pt on tablet:',
            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xxs),
          ResponsiveConstrainedBox(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Center(
                child: Text(
                  'Constrained content area',
                  style: AppTypography.body.copyWith(
                      color: AppColors.primary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakpointRow extends StatelessWidget {
  const _BreakpointRow(
      this.name, this.range, this.device, this.isCurrent);

  final String name;
  final String range;
  final String device;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: isCurrent
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCurrent
              ? AppColors.primary.withValues(alpha: 0.3)
              : AppColors.borderDefault,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: Text(
              name,
              style: AppTypography.small.copyWith(
                color: isCurrent ? AppColors.primary : AppColors.textPrimary,
                fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              range,
              style: AppTypography.small.copyWith(
                  color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              device,
              style: AppTypography.small.copyWith(
                  color: AppColors.textSecondary),
            ),
          ),
          if (isCurrent)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                'current',
                style: AppTypography.small.copyWith(
                    color: Colors.white, fontSize: 10),
              ),
            ),
        ],
      ),
    );
  }
}
