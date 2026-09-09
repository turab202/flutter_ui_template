import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

// ============================================================
// SAMPLE SCREEN SHELL
// A thin wrapper that adds a "← Design System" back button
// to any sample screen so reviewers can navigate back to the
// showcase. Not part of the core design system.
// ============================================================

class SampleScreenShell extends StatelessWidget {
  const SampleScreenShell({
    super.key,
    required this.child,
    this.label,
  });

  final Widget child;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        // Floating back pill — sits above the sample screen content
        Positioned(
          top: MediaQuery.of(context).padding.top + AppSpacing.xs,
          right: AppSpacing.sm,
          child: _BackPill(label: label),
        ),
      ],
    );
  }
}

class _BackPill extends StatelessWidget {
  const _BackPill({this.label});
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Back to Design System showcase',
      button: true,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: AppColors.textPrimary.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back_ios_new,
                  size: 12, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                label ?? 'Showcase',
                style: AppTypography.small.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SAMPLE CHIP FILTER ROW
// Horizontally scrollable row of selectable filter chips.
// Reused on Dashboard and Profile screens.
// ============================================================

class SampleFilterRow extends StatefulWidget {
  const SampleFilterRow({
    super.key,
    required this.options,
    this.initialIndex = 0,
    this.onChanged,
  });

  final List<String> options;
  final int initialIndex;
  final ValueChanged<int>? onChanged;

  @override
  State<SampleFilterRow> createState() => _SampleFilterRowState();
}

class _SampleFilterRowState extends State<SampleFilterRow> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontalPadding,
      ),
      child: Row(
        children: List.generate(widget.options.length, (i) {
          final isSelected = i == _selected;
          return Padding(
            padding: EdgeInsets.only(
              right: i < widget.options.length - 1 ? AppSpacing.xs : 0,
            ),
            child: _FilterChip(
              label: widget.options[i],
              isSelected: isSelected,
              onTap: () {
                setState(() => _selected = i);
                widget.onChanged?.call(i);
              },
            ),
          );
        }),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      selected: isSelected,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xxs + 2,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : AppColors.surface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.borderDefault,
            ),
          ),
          child: Text(
            label,
            style: AppTypography.small.copyWith(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: isSelected
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SAMPLE SECTION HEADER
// Simple section label with optional action text.
// ============================================================

class SampleSectionHeader extends StatelessWidget {
  const SampleSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTypography.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        if (actionLabel != null)
          Semantics(
            label: actionLabel,
            button: true,
            child: GestureDetector(
              onTap: onAction,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxs,
                  vertical: AppSpacing.xxs,
                ),
                child: Text(
                  actionLabel!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// SAMPLE STAT MINI — compact metric chip
// ============================================================

class SampleStatMini extends StatelessWidget {
  const SampleStatMini({
    super.key,
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
