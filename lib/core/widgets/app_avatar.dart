import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

// ============================================================
// APP AVATAR
// Source: Mobile App UI Consistency Guide v2.0 — Section 7.12
// ============================================================
//
// PDF Specifications:
//   Sizes:  24 / 32 / 40 / 56 / 96pt
//   Shape:  Circular (implied by standard avatar convention)
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT (sizes)
//
// ============================================================

// ----------------------------------------------------------
// Avatar size enum — maps to PDF-specified sizes.
// ----------------------------------------------------------

enum AppAvatarSize {
  /// 24pt — inline / compact contexts.
  xxs,

  /// 32pt — list items, chips.
  xs,

  /// 40pt — standard list tiles.
  sm,

  /// 56pt — profile headers, prominent lists.
  md,

  /// 96pt — profile screens, hero sections.
  lg,
}

// ----------------------------------------------------------
// AppAvatar
// ----------------------------------------------------------

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.size = AppAvatarSize.sm,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.semanticLabel,
    this.badge,
  });

  /// Remote image URL. Takes priority over [initials] and [icon].
  final String? imageUrl;

  /// 1–2 character initials shown when no image is available.
  final String? initials;

  /// Fallback icon shown when neither image nor initials are provided.
  final Widget? icon;

  /// Avatar size from the PDF scale.
  final AppAvatarSize size;

  /// Background color for initials/icon avatar.
  final Color? backgroundColor;

  /// Text/icon color for initials/icon avatar.
  final Color? foregroundColor;

  /// Tap callback. When non-null, wraps in InkWell.
  final VoidCallback? onTap;

  /// Screen-reader label.
  final String? semanticLabel;

  /// Optional badge overlay (e.g. online indicator, notification dot).
  /// ⚙️ OPTIONAL — not specified in PDF.
  final Widget? badge;

  double get _diameter {
    switch (size) {
      case AppAvatarSize.xxs: return AppConstants.avatarXxs; // 24pt
      case AppAvatarSize.xs:  return AppConstants.avatarXs;  // 32pt
      case AppAvatarSize.sm:  return AppConstants.avatarSm;  // 40pt
      case AppAvatarSize.md:  return AppConstants.avatarMd;  // 56pt
      case AppAvatarSize.lg:  return AppConstants.avatarLg;  // 96pt
    }
  }

  double get _fontSize {
    switch (size) {
      case AppAvatarSize.xxs: return 10;
      case AppAvatarSize.xs:  return 12;
      case AppAvatarSize.sm:  return 14;
      case AppAvatarSize.md:  return 20;
      case AppAvatarSize.lg:  return 32;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppAvatarSize.xxs: return 12;
      case AppAvatarSize.xs:  return 16;
      case AppAvatarSize.sm:  return 20;
      case AppAvatarSize.md:  return 28;
      case AppAvatarSize.lg:  return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = _diameter;
    final bg = backgroundColor ?? AppColors.primary.withValues(alpha: 0.15);
    final fg = foregroundColor ?? AppColors.primary;

    Widget avatar = _buildAvatarContent(d, bg, fg);

    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: avatar,
      );
    }

    if (badge != null) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            bottom: 0,
            right: 0,
            child: badge!,
          ),
        ],
      );
    }

    return Semantics(
      label: semanticLabel,
      image: imageUrl != null,
      child: avatar,
    );
  }

  Widget _buildAvatarContent(double d, Color bg, Color fg) {
    // Image avatar
    if (imageUrl != null) {
      return ClipOval(
        child: SizedBox(
          width: d,
          height: d,
          child: Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _buildFallback(d, bg, fg),
          ),
        ),
      );
    }

    return _buildFallback(d, bg, fg);
  }

  Widget _buildFallback(double d, Color bg, Color fg) {
    // Initials avatar
    if (initials != null && initials!.isNotEmpty) {
      final text = initials!.length > 2
          ? initials!.substring(0, 2).toUpperCase()
          : initials!.toUpperCase();

      return Container(
        width: d,
        height: d,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTypography.small.copyWith(
              fontSize: _fontSize,
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    // Icon avatar
    return Container(
      width: d,
      height: d,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconTheme(
          data: IconThemeData(size: _iconSize, color: fg),
          child: icon ?? const Icon(Icons.person),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// AvatarGroup — overlapping row of avatars.
// ⚙️ OPTIONAL — common pattern, not specified in PDF.
// ----------------------------------------------------------

class AvatarGroup extends StatelessWidget {
  const AvatarGroup({
    super.key,
    required this.avatars,
    this.maxVisible = 4,
    this.size = AppAvatarSize.xs,
    this.overlap = 10.0,
  });

  final List<AppAvatar> avatars;
  final int maxVisible;
  final AppAvatarSize size;
  final double overlap;

  @override
  Widget build(BuildContext context) {
    final visible = avatars.take(maxVisible).toList();
    final overflow = avatars.length - visible.length;
    final double d = visible.isNotEmpty
        ? (visible.first._diameter)
        : AppConstants.avatarXs;

    return SizedBox(
      height: d,
      child: Stack(
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * (d - overlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 2),
                ),
                child: visible[i],
              ),
            ),
          if (overflow > 0)
            Positioned(
              left: visible.length * (d - overlap),
              child: AppAvatar(
                initials: '+$overflow',
                size: size,
                backgroundColor: AppColors.borderStrong,
                foregroundColor: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
