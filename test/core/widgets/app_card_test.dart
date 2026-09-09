import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/core/theme/app_theme.dart';
import 'package:flutter_ui_template/core/widgets/app_card.dart';

// ============================================================
// APP CARD WIDGET TESTS
// ============================================================

Widget _wrap(Widget child) => MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );

void main() {
  group('AppCard — rendering', () {
    testWidgets('renders child content', (tester) async {
      await tester.pumpWidget(_wrap(
        AppCard(child: const Text('Card body')),
      ));
      expect(find.text('Card body'), findsOneWidget);
    });

    testWidgets('renders header and footer when provided', (tester) async {
      await tester.pumpWidget(_wrap(
        AppCard(
          header: const Text('Header'),
          footer: const Text('Footer'),
          child: const Text('Body'),
        ),
      ));
      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
    });
  });

  group('AppCard — pressable state (PDF Section 7.3)', () {
    testWidgets('onTap fires when pressable card is tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        AppCard(
          onTap: () => tapped = true,
          child: const Text('Pressable'),
        ),
      ));
      await tester.tap(find.byType(AppCard));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('pressable card has button semantics label', (tester) async {
      await tester.pumpWidget(_wrap(
        AppCard(
          onTap: () {},
          semanticLabel: 'Open article',
          child: const Text('Article'),
        ),
      ));
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics &&
              (w.properties.label == 'Open article'),
        ),
        findsWidgets,
      );
    });
  });

  group('AppSurfaceCard', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(_wrap(
        AppSurfaceCard(child: const Text('Surface')),
      ));
      expect(find.text('Surface'), findsOneWidget);
    });
  });
}
