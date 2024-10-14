import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';
import 'package:widget_library/common_widget/buttons/link_button.dart';

import '../test_helpers.dart';

void main() {
  testWidgets('PSLinkButton renders with correct text', (tester) async {
    var text = 'Button text';

    var linkButton = PSLinkButton(
      onPressed: () {},
      text: text,
    );

    await tester.pumpWidget(PSThemeWrapper(child: linkButton));

    expect(find.byWidget(linkButton), findsOneWidget);
    expect(find.text(text.toUpperCase()), findsOneWidget);
  });

  testWidgets('PSLinkButton can be pressed', (tester) async {
    final callbackMock = VoidCallbackMock();

    var linkButton = PSLinkButton(
      onPressed: callbackMock,
      text: 'text',
    );

    var linkButtonFinder = find.byWidget(linkButton);

    await tester.pumpWidget(PSThemeWrapper(child: linkButton));
    await tester.tap(linkButtonFinder);

    expect(linkButtonFinder, findsOneWidget);
    verify(callbackMock()).called(1);
  });

  group('Golden Tests', () {
    testGoldens('Docked buttons should render correctly', (tester) async {
      final builder = GoldenBuilder.column()
        ..addScenario(
          'Default',
          PSLinkButton(
            onPressed: () {},
            text: 'DEFAULT',
          ),
        )
        ..addScenario(
          'Disabled',
          PSLinkButton(
            onPressed: null,
            text: 'DISABLED',
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: (child) => PSThemeWrapper(child: child),
      );
      await screenMatchesGolden(tester, 'link_button');
    });
  });
}
