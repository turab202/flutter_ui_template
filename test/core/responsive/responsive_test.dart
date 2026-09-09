import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/core/responsive/responsive.dart';

// ============================================================
// RESPONSIVE HELPERS TESTS
// PDF Section 9 — breakpoints: mobile 0–375, mobile-large 376–428,
// tablet 429–1024.
// ============================================================

Widget _buildAtWidth(double width, Widget child) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(size: Size(width, 800)),
      child: Scaffold(body: child),
    ),
  );
}

void main() {
  group('ResponsiveLayout.breakpointOf — PDF Section 9', () {
    testWidgets('375pt wide → mobile', (tester) async {
      AppBreakpoint? result;
      await tester.pumpWidget(
        _buildAtWidth(375, Builder(builder: (ctx) {
          result = ResponsiveLayout.breakpointOf(ctx);
          return const SizedBox();
        })),
      );
      expect(result, equals(AppBreakpoint.mobile));
    });

    testWidgets('400pt wide → mobileLarge', (tester) async {
      AppBreakpoint? result;
      await tester.pumpWidget(
        _buildAtWidth(400, Builder(builder: (ctx) {
          result = ResponsiveLayout.breakpointOf(ctx);
          return const SizedBox();
        })),
      );
      expect(result, equals(AppBreakpoint.mobileLarge));
    });

    testWidgets('800pt wide → tablet', (tester) async {
      AppBreakpoint? result;
      await tester.pumpWidget(
        _buildAtWidth(800, Builder(builder: (ctx) {
          result = ResponsiveLayout.breakpointOf(ctx);
          return const SizedBox();
        })),
      );
      expect(result, equals(AppBreakpoint.tablet));
    });

    testWidgets('exact boundary 428pt → mobileLarge', (tester) async {
      AppBreakpoint? result;
      await tester.pumpWidget(
        _buildAtWidth(428, Builder(builder: (ctx) {
          result = ResponsiveLayout.breakpointOf(ctx);
          return const SizedBox();
        })),
      );
      expect(result, equals(AppBreakpoint.mobileLarge));
    });

    testWidgets('exact boundary 429pt → tablet', (tester) async {
      AppBreakpoint? result;
      await tester.pumpWidget(
        _buildAtWidth(429, Builder(builder: (ctx) {
          result = ResponsiveLayout.breakpointOf(ctx);
          return const SizedBox();
        })),
      );
      expect(result, equals(AppBreakpoint.tablet));
    });
  });

  group('ResponsiveLayout.isTablet', () {
    testWidgets('returns true on tablet width', (tester) async {
      bool? result;
      await tester.pumpWidget(
        _buildAtWidth(768, Builder(builder: (ctx) {
          result = ResponsiveLayout.isTablet(ctx);
          return const SizedBox();
        })),
      );
      expect(result, isTrue);
    });

    testWidgets('returns false on mobile width', (tester) async {
      bool? result;
      await tester.pumpWidget(
        _buildAtWidth(375, Builder(builder: (ctx) {
          result = ResponsiveLayout.isTablet(ctx);
          return const SizedBox();
        })),
      );
      expect(result, isFalse);
    });
  });

  group('ResponsiveLayout.contentMaxWidth — PDF Section 2 & 9', () {
    testWidgets('mobile returns full screen width', (tester) async {
      double? result;
      await tester.pumpWidget(
        _buildAtWidth(375, Builder(builder: (ctx) {
          result = ResponsiveLayout.contentMaxWidth(ctx);
          return const SizedBox();
        })),
      );
      expect(result, equals(375.0));
    });

    testWidgets('tablet caps at maxContentWidth (640pt)', (tester) async {
      double? result;
      await tester.pumpWidget(
        _buildAtWidth(1024, Builder(builder: (ctx) {
          result = ResponsiveLayout.contentMaxWidth(ctx);
          return const SizedBox();
        })),
      );
      // Should be capped at 640, not 1024.
      expect(result, lessThanOrEqualTo(640.0));
      expect(result, greaterThan(0));
    });
  });

  group('ResponsiveLayout.resolve', () {
    testWidgets('returns mobile value on mobile screen', (tester) async {
      int? result;
      await tester.pumpWidget(
        _buildAtWidth(375, Builder(builder: (ctx) {
          result = ResponsiveLayout.resolve(ctx, mobile: 1, tablet: 2);
          return const SizedBox();
        })),
      );
      expect(result, equals(1));
    });

    testWidgets('returns tablet value on tablet screen', (tester) async {
      int? result;
      await tester.pumpWidget(
        _buildAtWidth(768, Builder(builder: (ctx) {
          result = ResponsiveLayout.resolve(ctx, mobile: 1, tablet: 2);
          return const SizedBox();
        })),
      );
      expect(result, equals(2));
    });

    testWidgets('returns mobileLarge override when provided', (tester) async {
      int? result;
      await tester.pumpWidget(
        _buildAtWidth(400, Builder(builder: (ctx) {
          result = ResponsiveLayout.resolve(ctx,
              mobile: 1, mobileLarge: 3, tablet: 2);
          return const SizedBox();
        })),
      );
      expect(result, equals(3));
    });

    testWidgets('falls back to mobile when mobileLarge not provided',
        (tester) async {
      int? result;
      await tester.pumpWidget(
        _buildAtWidth(400, Builder(builder: (ctx) {
          result = ResponsiveLayout.resolve(ctx, mobile: 1, tablet: 2);
          return const SizedBox();
        })),
      );
      expect(result, equals(1));
    });
  });

  group('AppBreakpoints constants', () {
    test('mobileMax is 375', () {
      expect(AppBreakpoints.mobileMax, equals(375.0));
    });

    test('mobileLargeMax is 428', () {
      expect(AppBreakpoints.mobileLargeMax, equals(428.0));
    });
  });
}
