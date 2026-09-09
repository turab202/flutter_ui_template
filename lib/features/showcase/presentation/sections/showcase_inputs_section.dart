import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../showcase_section.dart';

class ShowcaseInputsSection extends StatelessWidget {
  const ShowcaseInputsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseSection(
      title: '7.2 Text Fields',
      subtitle:
          'PDF Section 7.2 — 48pt height, 12pt padding, all states',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Default — border = border-default'),
          const SizedBox(height: AppSpacing.xxs),
          const AppTextField(
            label: 'Email address',
            hint: 'Enter your email',
          ),
          const SizedBox(height: AppSpacing.sm),

          _label('Focused — border = primary, 2pt (tap to see)'),
          const SizedBox(height: AppSpacing.xxs),
          const AppTextField(
            label: 'Full name',
            hint: 'Enter your full name',
          ),
          const SizedBox(height: AppSpacing.sm),

          _label('Error state — border = error, helper below in error color'),
          const SizedBox(height: AppSpacing.xxs),
          const AppTextField(
            label: 'Username',
            hint: 'Pick a username',
            errorText: 'Username is already taken',
          ),
          const SizedBox(height: AppSpacing.sm),

          _label('With helper text'),
          const SizedBox(height: AppSpacing.xxs),
          const AppTextField(
            label: 'Password',
            hint: 'Minimum 8 characters',
            helperText: 'Use uppercase, lowercase, and numbers',
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.sm),

          _label('Disabled — bg = disabled-bg, text = text-disabled'),
          const SizedBox(height: AppSpacing.xxs),
          const AppTextField(
            label: 'Read-only field',
            hint: 'Cannot be edited',
            isEnabled: false,
          ),
          const SizedBox(height: AppSpacing.sm),

          _label('With leading/trailing icons'),
          const SizedBox(height: AppSpacing.xxs),
          const AppTextField(
            label: 'Search',
            hint: 'Search anything...',
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.mic_outlined),
          ),
          const SizedBox(height: AppSpacing.sm),

          _label('Password field — built-in visibility toggle'),
          const SizedBox(height: AppSpacing.xxs),
          const AppPasswordField(label: 'Password'),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
      );
}
