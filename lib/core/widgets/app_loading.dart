import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP LOADING
// Source: Mobile App UI Consistency Guide v2.0
// ============================================================
//
// PDF does not define a specific full-screen loading component,
// but the Loading state is referenced in button (Section 7.1)
// and skeleton (Section 7.11) specs.
//
// ⚙️ OPTIONAL — This widget is an engineering addition for
// full-screen and inline loading patterns.
//
// ============================================================

// ----------------------------------------------------------
// AppLoadingIndicator — inline spinner for use anywhere.
// Used in: buttons (loading state), overlays, list footers.
// ----------------------------------------------------------

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = 24.0,
    this.strokeWidth = 2.5,
    this.color,
  });

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.primary,
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// AppFullScreenLoading — covers entire screen with overlay.
// Use while an async operation blocks the UI.
// ⚙️ OPTIONAL — engineering addition.
// ----------------------------------------------------------

class AppFullScreenLoading extends StatelessWidget {
  const AppFullScreenLoading({
    super.key,
    this.message,
  });

  /// Optional loading message.
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: message ?? 'Loading',
      liveRegion: true,
      child: Container(
        color: AppColors.overlay,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLoadingIndicator(size: 40, strokeWidth: 3),
                if (message != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message!,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// AppLoadingOverlay — wraps a child and conditionally shows
// a loading overlay above it without replacing the content.
// ⚙️ OPTIONAL — engineering addition.
// ----------------------------------------------------------

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  final bool isLoading;
  final Widget child;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: AppFullScreenLoading(message: message),
          ),
      ],
    );
  }
}

// ----------------------------------------------------------
// AppPaginationLoader — small inline loader for list footers.
// ⚙️ OPTIONAL — engineering addition for paginated lists.
// ----------------------------------------------------------

class AppPaginationLoader extends StatelessWidget {
  const AppPaginationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(
        child: AppLoadingIndicator(size: 20, strokeWidth: 2),
      ),
    );
  }
}
