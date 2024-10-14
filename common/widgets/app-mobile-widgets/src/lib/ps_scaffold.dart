import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class PSScaffold extends StatelessWidget {
  final String? themeName;
  final PSAppBarAttributes? appBarAttributes;
  final PreferredSizeWidget? Function(BuildContext)? appBarBuilder;
  final bool resizeToAvoidBottomInset;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendedBodyClip;
  final bool extendBodyBehindAppBar;
  final PSBrightness themeBrightness;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;

  PSScaffold({
    this.themeName,
    this.appBarAttributes,
    this.appBarBuilder,
    this.resizeToAvoidBottomInset = true,
    this.extendedBodyClip = false,
    this.extendBodyBehindAppBar = false,
    required this.body,
    this.bottomNavigationBar,
    this.themeBrightness = PSBrightness.light,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PSTheme().themeFor(themeName);
    return Theme(
      key: Key('PSScaffold_PSTheme'),
      data: theme,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          // For Android.
          // Use [light] for white status bar and [dark] for black status bar.
          statusBarIconBrightness: themeBrightness == PSBrightness.dark ? Brightness.dark : Brightness.light,
          // For iOS.
          // Use [dark] for white status bar and [light] for black status bar.
          statusBarBrightness: themeBrightness == PSBrightness.dark ? Brightness.dark : Brightness.light,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          // backgroundColor: Theme.of(context).backgroundColor,
          drawer: drawer,

          appBar: _buildAppBar(context, theme),
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          extendBody: extendedBodyClip,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context, ThemeData theme) {
    if (appBarBuilder != null) {
      return appBarBuilder!(context);
    }

    if (appBarAttributes != null) {
      return psDefaultAppBar(context, appBarAttributes!, theme);
    }

    return null;
  }
}

enum PSBrightness { dark, light }
