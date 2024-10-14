void main() {
/*  testWidgets('PSInPageButton renders with correct text', (tester) async {
    var text = 'Button text';

    var inPageButton = PSInPageButton(
      key: Key('PSInPageButton'),
      onPressed: () {},
      text: text,
    );

    await tester.pumpWidget(PSThemeWrapper(child: inPageButton));

    expect(find.byWidget(inPageButton), findsOneWidget);
    expect(find.text(text.toUpperCase()), findsOneWidget);
  });

  testWidgets('PSInPageButton can be pressed', (tester) async {
    final callbackMock = VoidCallbackMock();

    var inPageButton = PSInPageButton(
      key: Key('testWidgetsPSInPageButton'),
      onPressed: callbackMock,
      text: 'text',
    );

    var inPageButtonFinder = find.byWidget(inPageButton);

    await tester.pumpWidget(PSThemeWrapper(child: inPageButton));
    await tester.tap(inPageButtonFinder);

    expect(inPageButtonFinder, findsOneWidget);
    verify(callbackMock()).called(1);
  });

  group('Golden Tests', () {
    testGoldens('Primary buttons should render correctly', (tester) async {
      final builder = GoldenBuilder.column()
        ..addScenario(
          'Default',
          PSInPageButton(
            key: Key('testGoldensPSInPageButton'),
            onPressed: () {},
            text: 'Default',
          ),
        )
        ..addScenario(
          'Disabled',
          PSInPageButton(
            key: Key('addScenarioPSInPageButton'),
            onPressed: null,
            text: 'Disabled',
          ),
        )
        ..addScenario(
          'Small',
          PSInPageButton(
            key: Key('SmallPSInPageButton'),
            onPressed: () {},
            visualDensity: VisualDensity.compact,
            text: 'Small',
          ),
        );
      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: (child) => PSThemeWrapper(child: child),
      );
      await screenMatchesGolden(tester, 'in_place_button_primary');
    });

    testGoldens('Secondary buttons should render correctly', (tester) async {
      final builder = GoldenBuilder.column()
        ..addScenario(
          'Default',
          PSInPageButton(
            key: Key('DefaultPSInPageButton'),
            onPressed: () {},
            variant: PSButtonThemeVariant.secondary,
            text: 'Default',
          ),
        )
        ..addScenario(
          'Disabled',
          PSInPageButton(
            key: Key('DisabledPSInPageButton'),
            onPressed: null,
            variant: PSButtonThemeVariant.secondary,
            text: 'Disabled',
          ),
        )
        ..addScenario(
          'Small',
          PSInPageButton(
            key: Key('SmallPSInPageButton'),
            onPressed: () {},
            visualDensity: VisualDensity.compact,
            variant: PSButtonThemeVariant.secondary,
            text: 'Small',
          ),
        );
      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: (child) => PSThemeWrapper(child: child),
      );
      await screenMatchesGolden(tester, 'in_place_button_secondary');
    });

    testGoldens('Tertiary buttons should render correctly', (tester) async {
      final builder = GoldenBuilder.column()
        ..addScenario(
          'Default',
          PSInPageButton(
            key: Key('addScenarioDefaultPSInPageButton'),
            onPressed: () {},
            variant: PSButtonThemeVariant.tertiary,
            text: 'Default',
          ),
        )
        ..addScenario(
          'Disabled',
          PSInPageButton(
            key: Key('addScenarioDisabledPSInPageButton'),
            onPressed: null,
            variant: PSButtonThemeVariant.tertiary,
            // extendedColorScheme: ExtendedColorScheme(
            //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
            //   pressed: Colors.orange,
            //   disabled: Colors.black,
            // ),
            text: 'Disabled',
          ),
        )
        ..addScenario(
          'Small',
          PSInPageButton(
            key: Key('addScenarioSmallPSInPageButton'),
            onPressed: () {},
            visualDensity: VisualDensity.compact,
            variant: PSButtonThemeVariant.tertiary,
            text: 'Small',
          ),
        );
      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: (child) => PSThemeWrapper(child: child),
      );
      await screenMatchesGolden(tester, 'in_place_button_tertiary');
    });
  });*/
}
