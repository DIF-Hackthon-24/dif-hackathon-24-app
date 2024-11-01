import 'package:core/app/ps_material_app.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/translation/app_localization.dart';
import 'package:core/translation/app_localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

// ignore: must_be_immutable

typedef OnContextBuildListener = void Function(BuildContext context);

class MyApp extends StatefulWidget {
  final List<String> supportedLanguangesCode;
  final Map<String, String> packages;
  final String appTitle;
  final Widget homeWidget;
  final ThemeData theme;
  final OnContextBuildListener onContextBuildListener;
  final Function onApplicationDetach;

  MyApp({
    Key? key,
    required this.appTitle,
    required this.packages,
    this.supportedLanguangesCode = const ['en', 'ar'],
    required this.homeWidget,
    required this.theme,
    required this.onContextBuildListener,
    required this.onApplicationDetach,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _listener;
  Locale? _locale;

  void setLocale(String value) {
    setState(() {
      _locale = Locale(value);
    });
  }

  var _textDirection = TextDirection.ltr;

  @override
  void initState() {
    _listener = AppLifecycleListener(
      onShow: () => () {},
      onResume: () => () {},
      onHide: () => () {},
      onInactive: () => () {},
      onPause: () => () {},
      onDetach: () => widget.onApplicationDetach,
      onRestart: () => () {},
      // This fires for each state change. Callbacks above fire only for
      // specific state transitions.
      onStateChange: _handleStateChange,
    );
    super.initState();
  }

  void _handleStateChange(AppLifecycleState state) {}

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.onContextBuildListener(context);
    AppLocalizations.packages = widget.packages;
    AppLocalizations.localeList = widget.supportedLanguangesCode;
    return GestureDetector(
      onTap: () {
        // allows the user to dismiss the keyboard by tapping away from any input.
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: OverlaySupport.global(
        child: PSMaterialApp(
          key: Key('app'),
          title: widget.appTitle,
          theme: widget.theme, // Set the theme Here
          home: widget.homeWidget,
          navigatorKey: NavigationManager.navigatorKey,
          onGenerateRoute: NavigationManager.getRoute,
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
          ],
          defaultTransition: Transition.fadeIn,
          locale: _locale,
          navigationObservers: [],
          localizationsDelegates: [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            return _getLocale(
                locale: locale!, supportedLocales: supportedLocales);
          },
          builder: (context, child) {
            AppLocalizationService.context = context;
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: Directionality(
                textDirection: _textDirection,
                child: child ?? Container(),
              ),
            );
          },
        ),
      ),
    );
  }

  Locale _getLocale(
      {required Locale locale, required Iterable<Locale> supportedLocales}) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        if (supportedLocale.languageCode == 'ar') {
          _textDirection = TextDirection.rtl;
        } else {
          _textDirection = TextDirection.ltr;
        }

        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}
