import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

// ============================================================
// APP SCREEN LAYOUT
// Source: Mobile App UI Consistency Guide v2.0 — Section 8
// ============================================================
//
// PDF Specifications (Section 8 — Screen Layout Template):
//
//   SafeAreaView
//   ├── StatusBar
//   ├── Fixed Header      height = 56pt, paddingHorizontal = 16pt
//   ├── Scrollable Content paddingHorizontal = 16pt
//   └── Fixed Footer      height = 56pt, paddingHorizontal = 16pt
//
// 🔒 DESIGN SYSTEM — KEEP CONSISTENT
//
// ============================================================

class AppScreenLayout extends StatelessWidget {
  const AppScreenLayout({
    super.key,
    required this.body,
    this.header,
    this.footer,
    this.floatingActionButton,
    this.backgroundColor,
    this.statusBarBrightness = Brightness.dark,
    this.resizeToAvoidBottomInset = true,
    this.scrollPhysics,
    this.bodyPadding,
    this.centerBody = false,
  });

  /// Scrollable main body content.
  final Widget body;

  /// Optional fixed header (renders below the status bar).
  /// When null, no header is rendered — the body fills from the top.
  final Widget? header;

  /// Optional fixed footer / action bar.
  final Widget? footer;

  /// Optional FAB.
  final Widget? floatingActionButton;

  /// Screen background color. Defaults to AppColors.background.
  final Color? backgroundColor;

  /// Controls the status bar icon brightness.
  /// Brightness.dark = dark icons (for light backgrounds — default).
  final Brightness statusBarBrightness;

  /// Whether to resize when the keyboard appears.
  final bool resizeToAvoidBottomInset;

  /// Scroll physics for the body ScrollView.
  final ScrollPhysics? scrollPhysics;

  /// Override body content padding. Defaults to 16pt horizontal per PDF.
  final EdgeInsetsGeometry? bodyPadding;

  /// When true, centers the body content column. Useful for forms.
  final bool centerBody;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.background;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarBrightness == Brightness.dark
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            ),
      child: Scaffold(
        backgroundColor: bg,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        floatingActionButton: floatingActionButton,
        body: SafeArea(
          // PDF: SafeAreaView wraps everything
          child: Column(
            children: [
              // ------------------------------------------------
              // Fixed Header — PDF Section 8: height 56pt, padding 16pt
              // ------------------------------------------------
              if (header != null)
                _FixedHeader(child: header!),

              // ------------------------------------------------
              // Scrollable Content — PDF Section 8: padding 16pt
              // ------------------------------------------------
              Expanded(
                child: _buildBody(context),
              ),

              // ------------------------------------------------
              // Fixed Footer — PDF Section 8: height 56pt, padding 16pt
              // ------------------------------------------------
              if (footer != null)
                _FixedFooter(child: footer!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final effectivePadding = bodyPadding ??
        const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontalPadding, // PDF: 16pt
        );

    Widget content = SingleChildScrollView(
      physics: scrollPhysics ?? const BouncingScrollPhysics(),
      // PDF Section 8: contentInset bottom = 20 (we use bottom padding)
      padding: effectivePadding.add(
        const EdgeInsets.only(bottom: 20),
      ),
      child: centerBody
          ? Center(child: ResponsiveConstrainedBox(child: body))
          : ResponsiveConstrainedBox(child: body),
    );

    return content;
  }
}

// ----------------------------------------------------------
// _FixedHeader — internal header container.
// PDF Section 8: height = 56pt, paddingHorizontal = 16pt.
// ----------------------------------------------------------

class _FixedHeader extends StatelessWidget {
  const _FixedHeader({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 56, // PDF: height = 56pt
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontalPadding, // PDF: 16pt
      ),
      color: AppColors.background,
      child: child,
    );
  }
}

// ----------------------------------------------------------
// _FixedFooter — internal footer container.
// PDF Section 8: height = 56pt, paddingHorizontal = 16pt.
// ----------------------------------------------------------

class _FixedFooter extends StatelessWidget {
  const _FixedFooter({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 56, // PDF: height = 56pt
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontalPadding, // PDF: 16pt
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.borderDefault,
            width: 1, // PDF Section 7.5: divider = 1pt
          ),
        ),
      ),
      child: child,
    );
  }
}

// ----------------------------------------------------------
// AppSliverScreenLayout
// A variant using CustomScrollView with SliverAppBar for
// screens that need collapsible headers.
// ⚙️ OPTIONAL — engineering addition.
// ----------------------------------------------------------

class AppSliverScreenLayout extends StatelessWidget {
  const AppSliverScreenLayout({
    super.key,
    required this.slivers,
    this.title,
    this.expandedHeight = 200,
    this.backgroundColor,
    this.floatingHeader,
    this.footer,
  });

  final List<Widget> slivers;
  final String? title;
  final double expandedHeight;
  final Color? backgroundColor;
  final Widget? floatingHeader;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.background;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (title != null)
                    SliverAppBar(
                      title: title != null ? Text(title!) : null,
                      floating: true,
                      snap: true,
                      backgroundColor: bg,
                      expandedHeight: expandedHeight,
                      flexibleSpace: floatingHeader != null
                          ? FlexibleSpaceBar(background: floatingHeader)
                          : null,
                    ),
                  ...slivers,
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                ],
              ),
            ),
            if (footer != null) _FixedFooter(child: footer!),
          ],
        ),
      ),
    );
  }
}
