// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';

import 'package:core/navigation/i_navigation_handler.dart';
import 'package:core/navigation/i_route_manager.dart';
import 'package:flutter/material.dart';

enum NavigationType {
  Push,
  Replace,
  ReplaceCurrent,
  FullScreenDialog,
  Dialog,
  BottomSheet,
  PopUntil,
}

class NavigationManager {
  static INavigationHandler? _navigationHandler;
  static var navigatorKey = GlobalKey<NavigatorState>();

  NavigationManager(INavigationHandler navigationHandler) {
    _navigationHandler = navigationHandler;
  }

  static void registerRouteManager(
    String featureName,
    IRouteManager routeManager,
  ) {
    _navigationHandler?.registerRouteManager(featureName, routeManager);
  }

  static Route getRoute(RouteSettings settings) {
    return _navigationHandler!.getRoute(settings);
  }

  /// Navigates to a view/widget based on the Navigation type
  /// Push, Fullscreen Dialog, Remove stack and Push, Dialog, Bottomsheet are supported

  static Future<dynamic> navigateTo(
    String routeName,
    NavigationType navigationType, {
    dynamic arguments,
    bool barrierDismissiable = true,
    @deprecated Function(dynamic value)? onScreenReload,
    VoidCallback? whenComplete,
  }) async {
    return _navigationHandler?.navigateTo(
          routeName,
          navigationType,
          arguments: arguments,
          barrierDismissiable: barrierDismissiable,
          onScreenReload: onScreenReload,
          whenComplete: whenComplete,
        ) ??
        Future.value();
  }

  static void goBack({arguments}) {
    _navigationHandler?.goBack(arguments: arguments);
  }

  static void popDialog({arguments}) {
    _navigationHandler?.popDialog(arguments: arguments);
  }

  static bool canPop(BuildContext context) {
    return _navigationHandler?.canPop(context) ?? false;
  }

  static String getCurrentRouteName() {
    return _navigationHandler?.getCurrentRouteName() ?? '';
  }

  static String getPreviousRouteName() {
    return _navigationHandler?.getPreviousRouteName() ?? '';
  }
}
