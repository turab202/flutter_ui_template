import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/core/constants/app_constants.dart';
import 'package:flutter_ui_template/core/theme/app_theme.dart';
import 'package:flutter_ui_template/core/widgets/app_text_field.dart';

// ============================================================
// APP TEXT FIELD WIDGET TESTS
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
  group('AppTextField — rendering', () {
    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextField(label: 'Email', hint: 'Enter email'),
      ));
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('renders hint text', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextField(hint: 'Type here'),
      ));
      expect(find.text('Type here'), findsOneWidget);
    });

    testWidgets('renders error text in error state', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextField(
          label: 'Name',
          errorText: 'Name is required',
        ),
      ));
      expect(find.text('Name is required'), findsOneWidget);
    });

    testWidgets('renders helper text', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextField(
          label: 'Username',
          helperText: 'Letters and numbers only',
        ),
      ));
      expect(find.text('Letters and numbers only'), findsOneWidget);
    });
  });

  group('AppTextField — touch target (PDF Section 4)', () {
    testWidgets('input height meets 48pt minimum', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextField(label: 'Test', hint: 'Test'),
      ));
      final size = tester.getSize(find.byType(AppTextField));
      expect(size.height, greaterThanOrEqualTo(AppConstants.minInputHeight));
    });
  });

  group('AppTextField — disabled state (PDF Section 7.2)', () {
    testWidgets('disabled field is not interactive', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextField(
          label: 'Read only',
          hint: 'Cannot type',
          isEnabled: false,
        ),
      ));
      final textField = tester.widget<TextFormField>(
        find.byType(TextFormField),
      );
      // enabled is determined by the decoration (null when disabled).
      expect(textField.enabled, isFalse);
    });
  });

  group('AppTextField — input interaction', () {
    testWidgets('onChanged fires when text changes', (tester) async {
      String? value;
      await tester.pumpWidget(_wrap(
        AppTextField(
          hint: 'Type something',
          onChanged: (v) => value = v,
        ),
      ));
      await tester.enterText(find.byType(TextFormField), 'Hello');
      expect(value, equals('Hello'));
    });

    testWidgets('obscureText field does not show characters', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextField(
          label: 'Password',
          hint: 'Enter password',
          obscureText: true,
        ),
      ));
      // Enter text and verify obscured rendering exists.
      await tester.enterText(find.byType(TextFormField), 'secret');
      await tester.pump();
      // The EditableText inside will have obscureText = true.
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      expect(editableText.obscureText, isTrue);
    });
  });

  group('AppTextField — semantics (PDF Section 11)', () {
    testWidgets('disabled field semantic label is accessible', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextField(label: 'Off', isEnabled: false),
      ));
      // The outer Semantics widget wraps the field with label and enabled=false.
      // Verify the widget renders and the semantics node exists.
      expect(find.byType(AppTextField), findsOneWidget);
      // The Semantics wrapper with enabled: false is present.
      final semantics = tester.widget<Semantics>(
        find.ancestor(
          of: find.byType(TextFormField),
          matching: find.byType(Semantics),
        ).first,
      );
      expect(semantics.properties.enabled, isFalse);
    });
  });

  group('AppPasswordField', () {
    testWidgets('renders with visibility toggle icon', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppPasswordField(label: 'Password'),
      ));
      expect(find.byType(AppPasswordField), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('toggle switches obscure state', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppPasswordField(label: 'Password'),
      ));

      // Initially obscured.
      EditableText editableText() =>
          tester.widget<EditableText>(find.byType(EditableText));

      expect(editableText().obscureText, isTrue);

      // Tap the toggle.
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(editableText().obscureText, isFalse);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
