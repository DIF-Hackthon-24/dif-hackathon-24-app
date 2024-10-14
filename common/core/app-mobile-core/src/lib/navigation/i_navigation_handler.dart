import 'dart:async';

import 'package:core/analytics/i_analytics.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/navigation/i_route_manager.dart';
import 'package:core/navigation/navigation_arguments.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class INavigationHandler {
  static final Map<String, IRouteManager> _routeManagers = <String, IRouteManager>{};

  void registerRouteManager(
    String featureName,
    IRouteManager routeManager,
  ) {
    _routeManagers[featureName] = routeManager;
  }

  Route getRoute(RouteSettings settings) {
    // and redirect to login and then to the deep-link. *Danger, Will Robinson!*.
    final uri = Uri.parse(settings.name!);
    final names = uri.pathSegments[0].split('-');
    final featureName = names[0];
    final viewName = names[1];
    final navigationArguments = NavigationArguments.getNavigationArguments(
      settings,
    );
    final routeSettings = RouteSettings(
      name: viewName,
      arguments: navigationArguments.newScreenArguments ?? uri.queryParameters,
    );
    final view = _routeManagers[featureName]!.getView(routeSettings);
    return GetPageRoute(
      page: () => view,
      fullscreenDialog: navigationArguments.presentAsModal,
      settings: routeSettings,
    );
  }

  // ignore: long-method
  Future<dynamic> navigateTo(
    String routeName,
    NavigationType navigationType, {
    dynamic arguments,
    bool barrierDismissiable = true,
    @deprecated Function(dynamic value)? onScreenReload,
    VoidCallback? whenComplete,
  }) async {
    if (!(routeName.contains('busy_modal'))) {
      final analytics = DIContainer.container.resolve<IAnalytics>();
      analytics.logScreen(routeName.split('-')[1]);

      var properties = {'Name': routeName};

      if (routeName.contains('errorview')) {
        var map = arguments as Map<String, dynamic>?;
        properties['Code'] = map?['code'] as String? ?? '';
      }
      PerformanceMonitor.startScreenLoadTimedEvent('$routeName', properties: properties);
    }
    var future;
    switch (navigationType) {
      case NavigationType.Push:
        future = _push(routeName, arguments: arguments);
        break;
      case NavigationType.FullScreenDialog:
        future = _push(
          routeName,
          arguments: arguments,
          presentAsModal: true,
        );
        break;
      case NavigationType.Replace:
        future = _replaceTo(routeName, arguments: arguments);
        break;
      case NavigationType.ReplaceCurrent:
        future = _replaceCurrent(routeName, arguments: arguments);
        break;
      case NavigationType.Dialog:
        future = _showDialogNamed(
          routeName,
          arguments: arguments,
          barrierDismissiable: barrierDismissiable,
        );
        break;
      case NavigationType.BottomSheet:
        future = _showBottomSheetNamed(
          routeName,
          arguments: arguments,
          isDismissible: barrierDismissiable,
          whenComplete: whenComplete,
        );
        break;
      case NavigationType.PopUntil:
        return _popUntil(routeName);
      default:
        throw Exception(
          'Navigation type $navigationType does not exist',
        );
    }
    if (onScreenReload != null) {
      return await future.then(onScreenReload);
    } else {
      return await future;
    }
  }

  void _popUntil(String routeName) {
    final names = routeName.split('-');
    Get.until((route) => route.settings.name == names[1]);
  }

  Future<dynamic> _push(
    String routeName, {
    dynamic arguments,
    bool presentAsModal = false,
  }) {
    return Get.toNamed(routeName, arguments: NavigationArguments(presentAsModal, arguments)) ?? Future.value();
  }

  Future<dynamic> _replaceTo(String routeName, {dynamic arguments}) {
    final names = routeName.split('-');

    // We need to pop _past_ the named route, so use this to track it.
    var replaceNow = false;

    return Get.offNamedUntil(
          routeName,
          (route) {
            final prevReplaceNow = replaceNow;
            replaceNow = names[1] == route.settings.name;
            return prevReplaceNow;
          },
          arguments: NavigationArguments(
            false,
            arguments,
          ),
        ) ??
        Future.value();
  }

  Future<dynamic> _replaceCurrent(String routeName, {dynamic arguments}) {
    return Get.offNamed(
          routeName,
          arguments: NavigationArguments(
            false,
            arguments,
          ),
        ) ??
        Future.value();
  }

  void goBack({arguments}) {
    Get.back(result: arguments);
  }

  void popDialog({arguments}) {
    goBack(arguments: arguments);
  }

  bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  String getCurrentRouteName() => Get.currentRoute;

  String getPreviousRouteName() => Get.previousRoute;

  Future _showDialogNamed(
    String dialogName, {
    dynamic arguments,
    bool barrierDismissiable = true,
  }) {
    final names = dialogName.split('-');
    final featureName = names[0];
    final widgetName = names[1];
    bool isSafeArea = true;
    final arg = arguments as Map<String,dynamic>? ?? <String, dynamic>{};
    if(arg.containsKey('isSafeArea')){
       isSafeArea = arg['isSafeArea'] as bool? ?? false;
    } else {
      isSafeArea = _checkSafeAreaExceptions(widgetName);
    }
    final dialogWidget = _routeManagers[featureName]!.getDialog(widgetName, arguments);
    final isTransparentBarrier = arg['transparentBarrier'] == null ? false : arg['transparentBarrier'] as String == 'true';
    return Get.dialog(
      dialogWidget,
      useSafeArea: isSafeArea,
      barrierColor: isTransparentBarrier ? Colors.transparent : null,
      barrierDismissible: barrierDismissiable,
    );
  }

  Future _showBottomSheetNamed(
    String bottomsheetName, {
    dynamic arguments,
    bool isDismissible = true,
    bool enableDrag = true,
    VoidCallback? whenComplete,
  }) {
    final names = bottomsheetName.split('-');
    final featureName = names[0];
    final widgetName = names[1];
    final dialogWidget = _routeManagers[featureName]!.getBottomSheet(widgetName, arguments);

    if (arguments != null && arguments is Map<String, dynamic> && arguments.isNotEmpty) {
      return Get.bottomSheet(
        dialogWidget,
        isScrollControlled: arguments['isScrollControlled'] as bool? ?? false,
        backgroundColor: arguments['backgroundColor'] as Color? ?? Colors.white,
        isDismissible: arguments['isDismissible'] as bool? ?? isDismissible,
        shape: arguments['shape'] as ShapeBorder?,
        enableDrag: arguments['enableDrag'] as bool? ?? enableDrag,
      ).whenComplete((){
        if (whenComplete != null) {
          whenComplete.call();
        }
      });
    }

    return Get.bottomSheet(
      dialogWidget,
      isScrollControlled: false,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    ).whenComplete(() {
      if (whenComplete != null) {
        whenComplete.call();
      }
    });
  }

  bool _checkSafeAreaExceptions(String widgetName) {
    const exceptions = ['busy_modal'];
    return !exceptions.contains(widgetName);
  }
}

@immutable
class DefaultNavigationHandler extends INavigationHandler {}
