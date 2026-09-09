import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/main.dart';

// ============================================================
// SMOKE TEST — verifies the app launches without crashing.
// ============================================================

void main() {
  testWidgets('App smoke test — launches without error', (tester) async {
    await tester.pumpWidget(const FlutterUITemplateApp());
    // App renders — no uncaught exceptions.
    expect(find.byType(FlutterUITemplateApp), findsOneWidget);
  });
}
