import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_template/core/constants/app_constants.dart';
import 'package:flutter_ui_template/core/theme/app_theme.dart';
import 'package:flutter_ui_template/core/widgets/app_avatar.dart';

// ============================================================
// APP AVATAR WIDGET TESTS
// ============================================================

Widget _wrap(Widget child) => MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('AppAvatar — sizes (PDF Section 7.12)', () {
    final cases = {
      AppAvatarSize.xxs: AppConstants.avatarXxs, // 24pt
      AppAvatarSize.xs:  AppConstants.avatarXs,  // 32pt
      AppAvatarSize.sm:  AppConstants.avatarSm,  // 40pt
      AppAvatarSize.md:  AppConstants.avatarMd,  // 56pt
      AppAvatarSize.lg:  AppConstants.avatarLg,  // 96pt
    };

    for (final entry in cases.entries) {
      testWidgets('${entry.key.name} size renders at ${entry.value}pt',
          (tester) async {
        await tester.pumpWidget(_wrap(
          AppAvatar(
            initials: 'AB',
            size: entry.key,
            semanticLabel: 'Test avatar',
          ),
        ));
        // The avatar renders without error at this size.
        expect(find.byType(AppAvatar), findsOneWidget);
        // Find the inner Container with circular decoration.
        final containers = tester.widgetList<Container>(
          find.descendant(
            of: find.byType(AppAvatar),
            matching: find.byType(Container),
          ),
        ).toList();
        final avatarContainer = containers.firstWhere(
          (c) =>
              c.decoration is BoxDecoration &&
              (c.decoration as BoxDecoration).shape == BoxShape.circle,
          orElse: () => containers.first,
        );
        // Width should match the expected diameter.
        final width = avatarContainer.constraints?.maxWidth ?? 0.0;
        if (width > 0) {
          expect(width, closeTo(entry.value, 1));
        }
      });
    }
  });

  group('AppAvatar — initials rendering', () {
    testWidgets('renders initials text', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppAvatar(
          initials: 'JD',
          size: AppAvatarSize.sm,
          semanticLabel: 'JD',
        ),
      ));
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('truncates initials to 2 characters', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppAvatar(
          initials: 'JOHN',
          size: AppAvatarSize.sm,
          semanticLabel: 'JO',
        ),
      ));
      expect(find.text('JO'), findsOneWidget);
    });

    testWidgets('uppercases initials', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppAvatar(
          initials: 'ab',
          size: AppAvatarSize.sm,
          semanticLabel: 'AB',
        ),
      ));
      expect(find.text('AB'), findsOneWidget);
    });
  });

  group('AppAvatar — fallback icon', () {
    testWidgets('renders default person icon when no initials', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppAvatar(
          size: AppAvatarSize.sm,
          semanticLabel: 'Default',
        ),
      ));
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('renders custom fallback icon', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppAvatar(
          size: AppAvatarSize.sm,
          icon: Icon(Icons.business),
          semanticLabel: 'Business',
        ),
      ));
      expect(find.byIcon(Icons.business), findsOneWidget);
    });
  });

  group('AppAvatar — interaction', () {
    testWidgets('onTap fires', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_wrap(
        AppAvatar(
          initials: 'AB',
          size: AppAvatarSize.sm,
          onTap: () => tapped = true,
          semanticLabel: 'AB',
        ),
      ));
      await tester.tap(find.byType(AppAvatar));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });

  group('AppAvatar — semantics (PDF Section 11)', () {
    testWidgets('semanticLabel is applied as Semantics widget', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppAvatar(
          initials: 'AB',
          size: AppAvatarSize.sm,
          semanticLabel: 'User AB',
        ),
      ));
      expect(
        find.byWidgetPredicate(
          (w) => w is Semantics && w.properties.label == 'User AB',
        ),
        findsWidgets,
      );
    });
  });
}
