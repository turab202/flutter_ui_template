import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_shadows.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

// ============================================================
// APP THEME
// Source: Mobile App UI Consistency Guide v2.0 — All sections
// ============================================================
//
// Central ThemeData factory. All design token values flow from
// the token files (AppColors, AppSpacing, AppTypography, etc.).
// Do NOT hard-code any value here — reference the token classes.
//
// 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
//   The light() factory uses the PDF-defined tokens.
//   The dark() factory uses engineering-added dark tokens
//   (not from PDF — clearly marked in AppColors).
//
// ============================================================

abstract final class AppTheme {
  // ----------------------------------------------------------
  // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
  // Light Theme — built from PDF-defined tokens.
  // ----------------------------------------------------------
  static ThemeData light() {
    final textTheme = AppTypography.buildTextTheme(
      color: AppColors.textPrimary,
    );

    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      // 🎨 PROJECT-SPECIFIC: matches AppColors.primary / secondary
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary.withValues(alpha: 0.1),
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondary.withValues(alpha: 0.1),
      onSecondaryContainer: AppColors.secondary,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: AppColors.error.withValues(alpha: 0.1),
      onErrorContainer: AppColors.error,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surface,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.borderDefault,
      outlineVariant: AppColors.borderStrong,
      shadow: Colors.black,
      scrim: AppColors.overlay,
      inverseSurface: AppColors.textPrimary,
      onInverseSurface: AppColors.background,
      inversePrimary: AppColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.background,

      // --------------------------------------------------------
      // AppBar (Fixed Header — PDF Section 8)
      // Height 56pt, horizontal padding 16pt.
      // --------------------------------------------------------
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black12,
        titleTextStyle: AppTypography.h3.copyWith(
          color: AppColors.textPrimary,
        ),
        toolbarHeight: 56,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // --------------------------------------------------------
      // ElevatedButton (Primary Button — PDF Section 7.1)
      // Large: height 48pt minimum.
      // --------------------------------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.disabledButton,
          disabledForegroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.smAll,
          ),
          textStyle: AppTypography.bodyMedium,
          elevation: 0,
        ),
      ),

      // --------------------------------------------------------
      // OutlinedButton (Secondary Button — PDF Section 7.1)
      // Small: height 40pt.
      // --------------------------------------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textDisabled,
          minimumSize: const Size(double.infinity, 40),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          side: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.smAll,
          ),
          textStyle: AppTypography.bodyMedium,
        ),
      ),

      // --------------------------------------------------------
      // TextButton
      // ⚙️ OPTIONAL — not explicitly specified in PDF.
      // --------------------------------------------------------
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.bodyMedium,
          minimumSize: const Size(44, 44),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
        ),
      ),

      // --------------------------------------------------------
      // InputDecoration (PDF Section 7.2)
      // Height 48pt, padding 12pt.
      // --------------------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.inputPaddingHorizontal,
          vertical: AppSpacing.inputPaddingVertical,
        ),
        constraints: const BoxConstraints(minHeight: 48),
        border: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.borderDefault),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.borderDefault),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.borderDefault),
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.textDisabled),
        labelStyle: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
        ),
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
        helperStyle: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // --------------------------------------------------------
      // Card (PDF Section 7.3)
      // Padding 16pt, radius 12pt, elevation-1.
      // --------------------------------------------------------
      cardTheme: const CardThemeData(
        color: AppColors.background,
        elevation: AppShadows.elevationValue1,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        margin: EdgeInsets.zero,
        shadowColor: Color(0x0F000000),
      ),

      // --------------------------------------------------------
      // Chip (Badges/Chips — PDF Section 7.6)
      // Height 24pt, padding 8pt, full/pill radius.
      // --------------------------------------------------------
      chipTheme: ChipThemeData(
        labelStyle: AppTypography.small,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.badgePadding,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.fullAll,
        ),
        backgroundColor: AppColors.surface,
        labelPadding: EdgeInsets.zero,
      ),

      // --------------------------------------------------------
      // BottomNavigationBar (PDF Section 7.7)
      // NavBar height 56pt, item height 44pt.
      // --------------------------------------------------------
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.small,
        unselectedLabelStyle: AppTypography.small,
      ),

      // --------------------------------------------------------
      // Divider (PDF Section 7.5)
      // Height 1pt, color = border-default.
      // --------------------------------------------------------
      dividerTheme: const DividerThemeData(
        color: AppColors.borderDefault,
        thickness: 1,
        space: 1,
      ),

      // --------------------------------------------------------
      // Dialog / Modal (PDF Section 7.8)
      // radius 20pt, elevation-3.
      // --------------------------------------------------------
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.background,
        elevation: AppShadows.elevationValue3,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
        titleTextStyle: AppTypography.h3,
        contentTextStyle: AppTypography.body,
      ),

      // --------------------------------------------------------
      // SnackBar / Toast (PDF Section 7.9)
      // radius 8pt, elevation-4, bottom-anchored, floating.
      // --------------------------------------------------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTypography.body.copyWith(color: Colors.white),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        behavior: SnackBarBehavior.floating,
        elevation: AppShadows.elevationValue4,
      ),

      // --------------------------------------------------------
      // ListTile (PDF Section 7.4)
      // --------------------------------------------------------
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.listItemHorizontalPadding,
        ),
        minLeadingWidth: 24,
        horizontalTitleGap: AppSpacing.xs,
        minVerticalPadding: AppSpacing.xs,
      ),

      // --------------------------------------------------------
      // BottomSheet (PDF Section 7.8)
      // radius 20pt top, elevation-3.
      // --------------------------------------------------------
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lgTop),
        elevation: AppShadows.elevationValue3,
        modalElevation: AppShadows.elevationValue3,
        modalBackgroundColor: AppColors.background,
      ),

      // --------------------------------------------------------
      // Focus / keyboard accessibility (PDF Section 11)
      // Visible focus state using border-strong outline, 2pt.
      // --------------------------------------------------------
      focusColor: AppColors.primary.withValues(alpha: 0.15),
    );
  }

  // ----------------------------------------------------------
  // ⚙️ OPTIONAL — Dark Theme
  // NOT from the PDF (which defines a light palette only).
  // Uses engineering-added dark colors from AppColors.
  // ----------------------------------------------------------
  static ThemeData dark() {
    final textTheme = AppTypography.buildTextTheme(
      color: AppColors.darkTextPrimary,
    );

    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary.withValues(alpha: 0.2),
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondary.withValues(alpha: 0.2),
      onSecondaryContainer: AppColors.secondary,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: AppColors.error.withValues(alpha: 0.2),
      onErrorContainer: AppColors.error,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkTextPrimary,
      surfaceContainerHighest: AppColors.darkSurface,
      onSurfaceVariant: AppColors.darkTextSecondary,
      outline: AppColors.darkBorderDefault,
      outlineVariant: AppColors.darkBorderStrong,
      shadow: Colors.black,
      scrim: AppColors.overlay,
      inverseSurface: AppColors.darkTextPrimary,
      onInverseSurface: AppColors.darkBackground,
      inversePrimary: AppColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        titleTextStyle: AppTypography.h3.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        toolbarHeight: 56,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.darkSurface,
        elevation: AppShadows.elevationValue1,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorderDefault,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.inputPaddingHorizontal,
          vertical: AppSpacing.inputPaddingVertical,
        ),
        constraints: const BoxConstraints(minHeight: 48),
        border: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.darkBorderDefault),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.darkBorderDefault),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.smAll,
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        hintStyle: AppTypography.body.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurface,
        contentTextStyle: AppTypography.body.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lgTop),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
