import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../showcase_section.dart';

class ShowcaseTypographySection extends StatelessWidget {
  const ShowcaseTypographySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '2. Typography',
      subtitle: 'PDF Section 2 — Type scale with size, line-height, weight',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TypographyRow('H1', '32pt / 1.25× / 600', AppTypography.h1, 'Screen Title'),
          const SizedBox(height: AppSpacing.xs),
          _TypographyRow('H2', '24pt / 1.33× / 600', AppTypography.h2, 'Section Header'),
          const SizedBox(height: AppSpacing.xs),
          _TypographyRow('H3', '20pt / 1.40× / 600', AppTypography.h3, 'Card Title'),
          const SizedBox(height: AppSpacing.xs),
          _TypographyRow('Body', '16pt / 1.50× / 400', AppTypography.body,
              'Primary content text for reading.'),
          const SizedBox(height: AppSpacing.xs),
          _TypographyRow('Caption', '14pt / 1.43× / 400', AppTypography.caption,
              'Labels and metadata'),
          const SizedBox(height: AppSpacing.xs),
          _TypographyRow('Small', '12pt / 1.33× / 500', AppTypography.small,
              'Badges, timestamps — minimum size'),
        ],
      ),
    );
  }
}

class _TypographyRow extends StatelessWidget {
  const _TypographyRow(this.name, this.spec, this.style, this.sample);

  final String name;
  final String spec;
  final TextStyle style;
  final String sample;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTypography.small.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                spec,
                style: AppTypography.small.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            sample,
            style: style.copyWith(color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
