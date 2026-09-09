import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/showcase/presentation/showcase_screen.dart';

// ============================================================
// MAIN ENTRY POINT
// ============================================================
//
// 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
//
// Replace ShowcaseScreen with your application's root screen
// when reusing this template in a new project.
//
// ThemeData is provided by AppTheme.light() / AppTheme.dark()
// which are built entirely from design tokens.
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
      // Theme comes entirely from centralized AppTheme factory.
      // Do NOT override individual ThemeData values here.
      // --------------------------------------------------------
      theme: AppTheme.light(),

      // ⚙️ OPTIONAL — dark mode support
      darkTheme: AppTheme.dark(),

      // ⚙️ OPTIONAL — set to ThemeMode.dark or ThemeMode.system
      themeMode: ThemeMode.system,

      // --------------------------------------------------------
      // 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
      // TODO: Replace ShowcaseScreen with your home screen.
      // --------------------------------------------------------
      home: const ShowcaseScreen(),
    );
  }
}
