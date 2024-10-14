import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

/// Wraps a test widget in the [MaterialApp] and [PSTheme] to enable testing
class PSThemeWrapper extends StatelessWidget {
  final Widget child;
  PSThemeWrapper({required this.child});

  @override
  Widget build(BuildContext context) => MaterialApp(
        key: Key('PSThemeWrapperMaterialApp'),
        debugShowCheckedModeBanner: false,
        // home: PSTheme(
        //   key: Key('PSThemeWrapperPSTheme'),
        //   theme: kTestTheme,
        //   child: child,
        // ),
      );
}

// Callback class for VoidCallback mock
abstract class _Callback {
  void call();
}

/// A Mock that can be used in place of a [VoidCallback] function
class VoidCallbackMock extends Mock implements _Callback {}

ThemeData appTheme = ThemeData(
  primaryColor: Colors.blue,
  canvasColor: Colors.white30,
  colorScheme: ColorScheme(
    primary: Colors.blue,
    background: Colors.white12,
    brightness: Brightness.light,
    error: Colors.red,
    onBackground: Colors.black,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    secondary: Colors.blueAccent,
    surface: Colors.white24,
  ),
  fontFamily: 'AktivGrotesqueRg',
);

