import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/main.dart';

// ============================================================
// SMOKE TEST — verifies the app launches without crashing.
// ============================================================

void main() {
  testWidgets('App smoke test — launches without error', (tester) async {
    await tester.pumpWidget(const FlutterUITemplateApp());

    // DashboardScreen starts a 1400ms skeleton timer. Pump past
    // it so the test runner has no pending timers on teardown.
    await tester.pump(const Duration(milliseconds: 1500));

    // App renders — no uncaught exceptions.
    expect(find.byType(FlutterUITemplateApp), findsOneWidget);
  });
}
