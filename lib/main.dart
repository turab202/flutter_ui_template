import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/samples/presentation/app_shell.dart';

// ============================================================
// MAIN ENTRY POINT
// ============================================================
//
// 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
//
// Replace AppShell with your application's root widget when
// reusing this template in a new project.
//
// AppShell hosts four sample screens in a bottom-nav layout.
// The design-system component reference (ShowcaseScreen) is
// accessible via the "⚡ DS / Tokens" shortcut in the nav bar.
//
// ThemeData is provided by AppTheme.light() / AppTheme.dark()
// which are built entirely from design tokens — no values are
// hard-coded in this file.
//
// ============================================================

void main() {
  runApp(const FlutterUITemplateApp());
}

class FlutterUITemplateApp extends StatelessWidget {
  const FlutterUITemplateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // --------------------------------------------------------
      // 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
      // TODO: Replace with your application title.
      // --------------------------------------------------------
      title: 'Flutter UI Template',

      debugShowCheckedModeBanner: false,

      // --------------------------------------------------------
      // 🔒 DESIGN SYSTEM — KEEP CONSISTENT
      // Theme is built entirely from centralized AppTheme factory.
      // Do NOT override individual ThemeData values here.
      // --------------------------------------------------------
      theme: AppTheme.light(),

      // ⚙️ OPTIONAL — dark mode support (engineering addition)
      darkTheme: AppTheme.dark(),

      // ⚙️ OPTIONAL — set to ThemeMode.dark or ThemeMode.light
      themeMode: ThemeMode.system,

      // --------------------------------------------------------
      // 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
      // AppShell is the sample / demo entry point.
      // Replace with your application's real home screen.
      // --------------------------------------------------------
      home: const AppShell(),
    );
  }
}
