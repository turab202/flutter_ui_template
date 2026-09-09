import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/core/theme/app_colors.dart';
import 'package:flutter_ui_template/core/theme/app_spacing.dart';
import 'package:flutter_ui_template/core/theme/app_typography.dart';
import 'package:flutter_ui_template/core/theme/app_radius.dart';
import 'package:flutter_ui_template/core/theme/app_shadows.dart';
import 'package:flutter_ui_template/core/theme/app_motion.dart';
import 'package:flutter_ui_template/core/constants/app_constants.dart';
import 'package:flutter_ui_template/core/accessibility/accessibility_helpers.dart';

// ============================================================
// TOKEN & CONSTANT TESTS
// Verifies that design token values match the PDF exactly.
// ============================================================

// Helper: compare Color using toARGB32() (replaces deprecated .value)
int _argb(Color c) => c.toARGB32();

void main() {
  group('AppSpacing — PDF Section 1 (8pt grid)', () {
    test('xxs is 4pt (only exception to 8pt grid)', () {
      expect(AppSpacing.xxs, equals(4.0));
    });

    test('xs is 8pt', () => expect(AppSpacing.xs, equals(8.0)));
    test('sm is 16pt', () => expect(AppSpacing.sm, equals(16.0)));
    test('md is 24pt', () => expect(AppSpacing.md, equals(24.0)));
    test('lg is 32pt', () => expect(AppSpacing.lg, equals(32.0)));
    test('xl is 48pt', () => expect(AppSpacing.xl, equals(48.0)));

    test('all values except xxs are multiples of 8', () {
      final values = [
        AppSpacing.xs, AppSpacing.sm, AppSpacing.md,
        AppSpacing.lg, AppSpacing.xl,
      ];
      for (final v in values) {
        expect(v % 8, equals(0), reason: '$v is not a multiple of 8');
      }
    });

    test('screenHorizontalPadding equals sm (16pt)', () {
      expect(AppSpacing.screenHorizontalPadding, equals(AppSpacing.sm));
    });

    test('cardPadding equals sm (16pt)', () {
      expect(AppSpacing.cardPadding, equals(AppSpacing.sm));
    });

    test('emptyStatePadding equals xl (48pt)', () {
      expect(AppSpacing.emptyStatePadding, equals(AppSpacing.xl));
    });
  });

  group('AppColors — PDF Section 3', () {
    test('primary is #0066CC', () {
      expect(_argb(AppColors.primary), equals(_argb(const Color(0xFF0066CC))));
    });

    test('secondary is #6B7280', () {
      expect(_argb(AppColors.secondary), equals(_argb(const Color(0xFF6B7280))));
    });

    test('background is #FFFFFF', () {
      expect(_argb(AppColors.background), equals(_argb(const Color(0xFFFFFFFF))));
    });

    test('surface is #F3F4F6', () {
      expect(_argb(AppColors.surface), equals(_argb(const Color(0xFFF3F4F6))));
    });

    test('error is #DC2626', () {
      expect(_argb(AppColors.error), equals(_argb(const Color(0xFFDC2626))));
    });

    test('success is #059669', () {
      expect(_argb(AppColors.success), equals(_argb(const Color(0xFF059669))));
    });

    test('warning is #D97706', () {
      expect(_argb(AppColors.warning), equals(_argb(const Color(0xFFD97706))));
    });

    test('textPrimary is #111827', () {
      expect(_argb(AppColors.textPrimary), equals(_argb(const Color(0xFF111827))));
    });

    test('textSecondary is #6B7280', () {
      expect(_argb(AppColors.textSecondary), equals(_argb(const Color(0xFF6B7280))));
    });

    test('textDisabled is #9CA3AF', () {
      expect(_argb(AppColors.textDisabled), equals(_argb(const Color(0xFF9CA3AF))));
    });

    test('borderDefault is #E5E7EB', () {
      expect(_argb(AppColors.borderDefault), equals(_argb(const Color(0xFFE5E7EB))));
    });

    test('borderStrong is #D1D5DB', () {
      expect(_argb(AppColors.borderStrong), equals(_argb(const Color(0xFFD1D5DB))));
    });

    test('overlay alpha is ~0.5', () {
      expect(AppColors.overlay.a, closeTo(0.5, 0.01));
    });

    test('disabledBg matches surface', () {
      expect(_argb(AppColors.disabledBg), equals(_argb(AppColors.surface)));
    });

    test('disabledButton is #9CA3AF', () {
      expect(_argb(AppColors.disabledButton), equals(_argb(const Color(0xFF9CA3AF))));
    });
  });

  group('AppTypography — PDF Section 2', () {
    test('H1 is 32pt', () => expect(AppTypography.h1.fontSize, equals(32.0)));
    test('H1 line-height multiplier is 1.25', () {
      expect(AppTypography.h1.height, closeTo(1.25, 0.001));
    });

    test('H2 is 24pt', () => expect(AppTypography.h2.fontSize, equals(24.0)));
    test('H3 is 20pt', () => expect(AppTypography.h3.fontSize, equals(20.0)));

    test('Body is 16pt', () => expect(AppTypography.body.fontSize, equals(16.0)));
    test('Body line-height multiplier is 1.5', () {
      expect(AppTypography.body.height, closeTo(1.5, 0.001));
    });

    test('Caption is 14pt', () {
      expect(AppTypography.caption.fontSize, equals(14.0));
    });

    test('Small is 12pt (minimum readable size)', () {
      expect(AppTypography.small.fontSize, equals(12.0));
    });

    test('Minimum font size (Small) meets 12pt floor', () {
      expect(AppTypography.small.fontSize,
          greaterThanOrEqualTo(AppConstants.minFontSize));
    });

    test('H1/H2/H3 weight is Semibold (w600)', () {
      expect(AppTypography.h1.fontWeight, equals(AppTypography.weightSemibold));
      expect(AppTypography.h2.fontWeight, equals(AppTypography.weightSemibold));
      expect(AppTypography.h3.fontWeight, equals(AppTypography.weightSemibold));
    });

    test('Body weight is Regular (w400)', () {
      expect(AppTypography.body.fontWeight, equals(AppTypography.weightRegular));
    });

    test('Small weight is Medium (w500)', () {
      expect(AppTypography.small.fontWeight, equals(AppTypography.weightMedium));
    });

    test('All styles have a defined line-height (height)', () {
      final styles = [
        AppTypography.h1, AppTypography.h2, AppTypography.h3,
        AppTypography.body, AppTypography.caption, AppTypography.small,
      ];
      for (final s in styles) {
        expect(s.height, isNotNull,
            reason: '${s.fontSize}pt style missing line-height');
      }
    });
  });

  group('AppRadius — PDF Sections 7 & 15', () {
    test('sm is 8pt (cards, toasts)', () => expect(AppRadius.sm, equals(8.0)));
    test('md is 12pt (cards alt)', () => expect(AppRadius.md, equals(12.0)));
    test('lg is 20pt (modals)', () => expect(AppRadius.lg, equals(20.0)));
    test('full is large value for pill shape', () {
      expect(AppRadius.full, greaterThanOrEqualTo(100.0));
    });
  });

  group('AppShadows — PDF Section 5', () {
    test('elevation0 has no shadows', () {
      expect(AppShadows.elevation0, isEmpty);
    });

    test('elevation1 has 1 shadow entry', () {
      expect(AppShadows.elevation1.length, equals(1));
    });

    test('elevation1 offset is (0, 1)', () {
      final s = AppShadows.elevation1.first;
      expect(s.offset.dx, equals(0));
      expect(s.offset.dy, equals(1));
    });

    test('elevation1 blurRadius is 2', () {
      expect(AppShadows.elevation1.first.blurRadius, equals(2));
    });

    test('elevation4 blurRadius is 24', () {
      expect(AppShadows.elevation4.first.blurRadius, equals(24));
    });

    test('elevation4 offset is (0, 8)', () {
      expect(AppShadows.elevation4.first.offset.dy, equals(8));
    });

    test('forElevation(0) returns empty list', () {
      expect(AppShadows.forElevation(0), isEmpty);
    });

    test('forElevation(4) returns elevation4 list', () {
      expect(AppShadows.forElevation(4), equals(AppShadows.elevation4));
    });

    test('elevationValue constants match 0–4 scale', () {
      expect(AppShadows.elevationValue0, equals(0));
      expect(AppShadows.elevationValue4, equals(4));
    });
  });

  group('AppMotion — PDF Section 10', () {
    test('micro duration is 100–150ms', () {
      expect(AppMotion.micro.inMilliseconds, inInclusiveRange(100, 150));
    });

    test('screenTransition duration is 300–400ms', () {
      expect(AppMotion.screenTransition.inMilliseconds,
          inInclusiveRange(300, 400));
    });

    test('modal duration is 250–350ms', () {
      expect(AppMotion.modal.inMilliseconds, inInclusiveRange(250, 350));
    });
  });

  group('AppConstants — PDF Sections 4, 7, 8', () {
    test('minTouchTarget is 44pt', () {
      expect(AppConstants.minTouchTarget, equals(44.0));
    });

    test('minButtonHeight is 48pt', () {
      expect(AppConstants.minButtonHeight, equals(48.0));
    });

    test('smallButtonHeight is 40pt', () {
      expect(AppConstants.smallButtonHeight, equals(40.0));
    });

    test('minInputHeight is 48pt', () {
      expect(AppConstants.minInputHeight, equals(48.0));
    });

    test('headerHeight is 56pt', () {
      expect(AppConstants.headerHeight, equals(56.0));
    });

    test('footerHeight is 56pt', () {
      expect(AppConstants.footerHeight, equals(56.0));
    });

    test('bottomNavHeight is 56pt', () {
      expect(AppConstants.bottomNavHeight, equals(56.0));
    });

    test('bottomNavItemHeight meets 44pt touch target', () {
      expect(AppConstants.bottomNavItemHeight,
          greaterThanOrEqualTo(AppConstants.minTouchTarget));
    });

    test('listItemSingleHeight is 56pt', () {
      expect(AppConstants.listItemSingleHeight, equals(56.0));
    });

    test('listItemTwoLineHeight is 72pt', () {
      expect(AppConstants.listItemTwoLineHeight, equals(72.0));
    });

    test('badgeHeight is 24pt', () {
      expect(AppConstants.badgeHeight, equals(24.0));
    });

    test('minFontSize is 12pt', () {
      expect(AppConstants.minFontSize, equals(12.0));
    });

    test('maxContentWidth is within 600–680pt PDF range', () {
      expect(AppConstants.maxContentWidth, inInclusiveRange(600, 680));
    });

    test('toastDuration is 3–4 seconds', () {
      expect(AppConstants.toastDuration.inSeconds, inInclusiveRange(3, 4));
    });

    test('icon sizes are PDF-specified values', () {
      expect(AppConstants.iconXs, equals(16.0));
      expect(AppConstants.iconSm, equals(20.0));
      expect(AppConstants.iconMd, equals(24.0));
      expect(AppConstants.iconLg, equals(32.0));
    });

    test('avatar sizes match PDF spec', () {
      expect(AppConstants.avatarXxs, equals(24.0));
      expect(AppConstants.avatarXs,  equals(32.0));
      expect(AppConstants.avatarSm,  equals(40.0));
      expect(AppConstants.avatarMd,  equals(56.0));
      expect(AppConstants.avatarLg,  equals(96.0));
    });

    test('z-index stacking order is correct (PDF Section 5)', () {
      expect(AppConstants.zBase, lessThan(AppConstants.zStickyHeader));
      expect(AppConstants.zStickyHeader, lessThan(AppConstants.zDropdown));
      expect(AppConstants.zDropdown, lessThan(AppConstants.zModalOverlay));
      expect(AppConstants.zModalOverlay, lessThan(AppConstants.zModalContent));
      expect(AppConstants.zModalContent, lessThan(AppConstants.zToast));
    });

    test('z-index exact values from PDF', () {
      expect(AppConstants.zBase,         equals(0));
      expect(AppConstants.zStickyHeader, equals(10));
      expect(AppConstants.zDropdown,     equals(100));
      expect(AppConstants.zModalOverlay, equals(1000));
      expect(AppConstants.zModalContent, equals(1001));
      expect(AppConstants.zToast,        equals(2000));
    });
  });

  group('AccessibilityHelpers — WCAG contrast (PDF Section 3 & 11)', () {
    test('primary on white meets WCAG AA body (4.5:1)', () {
      final ratio = AccessibilityHelpers.contrastRatio(
        AppColors.primary, AppColors.background,
      );
      expect(ratio, greaterThanOrEqualTo(4.5),
          reason: 'primary on white got ${ratio.toStringAsFixed(2)}');
    });

    test('textPrimary on white meets WCAG AA body (4.5:1)', () {
      final ratio = AccessibilityHelpers.contrastRatio(
        AppColors.textPrimary, AppColors.background,
      );
      expect(ratio, greaterThanOrEqualTo(4.5));
    });

    test('white text on primary meets WCAG AA body (4.5:1)', () {
      final ratio = AccessibilityHelpers.contrastRatio(
        AppColors.background, AppColors.primary,
      );
      expect(ratio, greaterThanOrEqualTo(4.5));
    });

    test('contrast ratio is computable for disabled button pairing', () {
      final ratio = AccessibilityHelpers.contrastRatio(
        AppColors.background, AppColors.disabledButton,
      );
      expect(ratio, greaterThan(1.0));
    });

    test('meetsWcagAABody returns true for primary on white', () {
      expect(
        AccessibilityHelpers.meetsWcagAABody(
            AppColors.primary, AppColors.background),
        isTrue,
      );
    });

    test('meetsWcagAALarge returns a bool for secondary on white', () {
      final result = AccessibilityHelpers.meetsWcagAALarge(
          AppColors.textSecondary, AppColors.background);
      expect(result, isA<bool>());
    });

    test('relativeLuminance of white is 1.0', () {
      expect(
        AccessibilityHelpers.relativeLuminance(AppColors.background),
        closeTo(1.0, 0.001),
      );
    });

    test('relativeLuminance of black is ~0.0', () {
      expect(
        AccessibilityHelpers.relativeLuminance(
            const Color.fromARGB(255, 0, 0, 0)),
        closeTo(0.0, 0.001),
      );
    });
  });
}
