import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../showcase_section.dart';

class ShowcaseSpacingSection extends StatelessWidget {
  const ShowcaseSpacingSection({super.key});

  static const _tokens = [
    _SpacingToken('xxs', AppSpacing.xxs, 'Icon padding, micro-adjustments'),
    _SpacingToken('xs',  AppSpacing.xs,  'Small gaps, button padding'),
    _SpacingToken('sm',  AppSpacing.sm,  'Card padding, element spacing'),
    _SpacingToken('md',  AppSpacing.md,  'Section spacing, list gaps'),
    _SpacingToken('lg',  AppSpacing.lg,  'Screen margins'),
    _SpacingToken('xl',  AppSpacing.xl,  'Major section breaks, empty states'),
  ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '1. Spacing System (8pt Grid)',
      subtitle: 'PDF Section 1 — All spacing multiples of 8 (4pt exception for icons)',
      child: Column(
        children: _tokens.map((t) => _SpacingRow(token: t)).toList(),
      ),
    );
  }
}

class _SpacingToken {
  const _SpacingToken(this.name, this.value, this.usage);
  final String name;
  final double value;
  final String usage;
}

class _SpacingRow extends StatelessWidget {
  const _SpacingRow({required this.token});
  final _SpacingToken token;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Token name
          SizedBox(
            width: 36,
            child: Text(
              token.name,
              style: AppTypography.small.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Value
          SizedBox(
            width: 44,
            child: Text(
              '${token.value.toInt()}pt',
              style: AppTypography.small.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          // Visual bar
          Container(
            width: token.value * 1.5,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          // Usage
          Expanded(
            child: Text(
              token.usage,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
