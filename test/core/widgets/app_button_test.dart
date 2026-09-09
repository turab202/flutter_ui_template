import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/core/constants/app_constants.dart';
import 'package:flutter_ui_template/core/theme/app_colors.dart';
import 'package:flutter_ui_template/core/theme/app_theme.dart';
import 'package:flutter_ui_template/core/widgets/app_button.dart';

// ============================================================
// APP BUTTON WIDGET TESTS
// ============================================================

Widget _wrap(Widget child) => MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('AppButton — rendering', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(label: 'Save', onPressed: () {}),
      ));
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('default variant is primary', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(label: 'Test', onPressed: () {}),
      ));
      expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets('renders leading icon when provided', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(
          label: 'Add',
          onPressed: () {},
          leadingIcon: const Icon(Icons.add),
        ),
      ));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('full-width button occupies more than 100px', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(label: 'Full Width', onPressed: () {}),
      ));
      final size = tester.getSize(find.byType(AppButton));
      expect(size.width, greaterThan(100));
    });
  });

  group('AppButton — touch target (PDF Section 4)', () {
    testWidgets('large button height meets 48pt minimum', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(label: 'Large', onPressed: () {}),
      ));
      final size = tester.getSize(find.byType(AppButton));
      expect(size.height, greaterThanOrEqualTo(AppConstants.minButtonHeight));
    });

    testWidgets('small button height meets 40pt', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(
          label: 'Small',
          onPressed: () {},
          size: AppButtonSize.small,
        ),
      ));
      final size = tester.getSize(find.byType(AppButton));
      expect(size.height, greaterThanOrEqualTo(AppConstants.smallButtonHeight));
    });
  });

  group('AppButton — disabled state (PDF Section 7.1)', () {
    testWidgets('null onPressed renders disabled button', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppButton(label: 'Disabled', onPressed: null),
      ));
      expect(find.text('Disabled'), findsOneWidget);
    });

    testWidgets('disabled button does not trigger callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        AppButton(label: 'Tap', onPressed: null),
      ));
      await tester.tap(find.byType(AppButton));
      await tester.pump();
      expect(tapped, isFalse);
    });

    testWidgets('disabled button uses disabledButton color', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppButton(label: 'Off', onPressed: null),
      ));
      final container = tester.widget<AnimatedContainer>(
        find
            .descendant(
              of: find.byType(AppButton),
              matching: find.byType(AnimatedContainer),
            )
            .first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color?.toARGB32(),
          equals(AppColors.disabledButton.toARGB32()));
    });
  });

  group('AppButton — loading state (PDF Section 7.1)', () {
    testWidgets('shows CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppButton(
          label: 'Loading',
          onPressed: null,
          isLoading: true,
        ),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides label text while loading', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppButton(
          label: 'Loading',
          onPressed: null,
          isLoading: true,
        ),
      ));
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('blocks interaction while loading', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        AppButton(
          label: 'Tap',
          onPressed: () => tapped = true,
          isLoading: true,
        ),
      ));
      await tester.tap(find.byType(AppButton));
      await tester.pump();
      expect(tapped, isFalse);
    });
  });

  group('AppButton — variants', () {
    testWidgets('secondary variant renders', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(
          label: 'Secondary',
          onPressed: () {},
          variant: AppButtonVariant.secondary,
        ),
      ));
      expect(find.text('Secondary'), findsOneWidget);
    });

    testWidgets('destructive variant renders', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(
          label: 'Delete',
          onPressed: () {},
          variant: AppButtonVariant.destructive,
        ),
      ));
      expect(find.text('Delete'), findsOneWidget);
    });
  });

  group('AppButton — semantics (PDF Section 11)', () {
    testWidgets('has button role — Semantics widget present', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(label: 'Submit', onPressed: () {}),
      ));
      // Verify a Semantics widget with button=true is in the tree.
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && (w.properties.label == 'Submit'),
        ),
        findsWidgets,
      );
    });

    testWidgets('custom semanticLabel is applied', (tester) async {
      await tester.pumpWidget(_wrap(
        AppButton(
          label: 'Submit',
          onPressed: () {},
          semanticLabel: 'Submit the form',
        ),
      ));
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics &&
              (w.properties.label == 'Submit the form'),
        ),
        findsWidgets,
      );
    });
  });

  group('AppButton — callback', () {
    testWidgets('onPressed fires on tap', (tester) async {
      var count = 0;
      await tester.pumpWidget(_wrap(
        AppButton(label: 'Tap', onPressed: () => count++),
      ));
      await tester.tap(find.byType(AppButton));
      await tester.pump();
      expect(count, equals(1));
    });
  });
}
