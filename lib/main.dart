import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/samples/presentation/samples_launcher.dart';

// ============================================================
// MAIN ENTRY POINT
// ============================================================
//
// 🎨 PROJECT-SPECIFIC — CUSTOMIZE FOR EACH APP
//
// Replace SamplesLandingScreen with your application's root
// screen when reusing this template in a new project.
//
// The component-reference showcase (ShowcaseScreen) is still
// accessible via the "Components" button in the landing app bar.
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
      // Landing screen: the sample screens gallery.
      // TODO: Replace with your application's home screen.
      // --------------------------------------------------------
      home: const SamplesLandingScreen(),
    );
  }
}
