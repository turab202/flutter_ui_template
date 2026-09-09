import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../showcase_section.dart';

class ShowcaseColorsSection extends StatelessWidget {
  const ShowcaseColorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '3. Color System',
      subtitle: 'PDF Section 3 — Core & Text/Structural Palette tokens',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel('Core Palette'),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _ColorSwatch(color: AppColors.primary,    label: 'primary\n#0066CC'),
              _ColorSwatch(color: AppColors.secondary,  label: 'secondary\n#6B7280'),
              _ColorSwatch(color: AppColors.background, label: 'background\n#FFFFFF', bordered: true),
              _ColorSwatch(color: AppColors.surface,    label: 'surface\n#F3F4F6',   bordered: true),
              _ColorSwatch(color: AppColors.error,      label: 'error\n#DC2626'),
              _ColorSwatch(color: AppColors.success,    label: 'success\n#059669'),
              _ColorSwatch(color: AppColors.warning,    label: 'warning\n#D97706'),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _SectionLabel('Text & Structural Palette'),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _ColorSwatch(color: AppColors.textPrimary,   label: 'text-primary\n#111827'),
              _ColorSwatch(color: AppColors.textSecondary, label: 'text-secondary\n#6B7280'),
              _ColorSwatch(color: AppColors.textDisabled,  label: 'text-disabled\n#9CA3AF'),
              _ColorSwatch(color: AppColors.borderDefault, label: 'border-default\n#E5E7EB', bordered: true),
              _ColorSwatch(color: AppColors.borderStrong,  label: 'border-strong\n#D1D5DB',  bordered: true),
              _ColorSwatch(color: AppColors.overlay,       label: 'overlay\nrgba(0,0,0,0.5)'),
              _ColorSwatch(color: AppColors.disabledBg,    label: 'disabled-bg\n#F3F4F6',    bordered: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      );
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.color,
    required this.label,
    this.bordered = false,
  });

  final Color color;
  final String label;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: bordered
                ? Border.all(color: AppColors.borderDefault)
                : null,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: AppTypography.small.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
