import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/main.dart';

// ============================================================
// SMOKE TEST — verifies the app launches without crashing.
// ============================================================

void main() {
  testWidgets('App smoke test — launches without error', (tester) async {
    await tester.pumpWidget(const FlutterUITemplateApp());
    // SignInScreen.initState schedules a 60ms animation start timer.
    // Pump past it so no pending timers remain on teardown.
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(FlutterUITemplateApp), findsOneWidget);
  });
}
