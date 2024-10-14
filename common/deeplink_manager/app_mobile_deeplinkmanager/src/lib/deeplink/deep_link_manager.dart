import 'dart:convert';

import 'package:core/navigation/navigation_manager.dart';
import 'package:deeplink_manager/deeplink/datamodel/deeplink_config.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/task_manager.dart';

class _Constant {
  static const configFilePath = "assets/deeplink/deeplink_config.json";
  static const authenticatedUser = "authenticated_user";
  static const homeScreenName = "global-home";
}

class DeepLinkManager {
  final TaskManager taskManager;
  DeepLinkConfigData? _deepLinkConfigData;

  DeepLinkManager({required this.taskManager});

  void initialize() async {
    var jsonString = await rootBundle.loadString(_Constant.configFilePath);
    final deepLinkJSON = json.decode(jsonString) as Map<String, dynamic>;
    _deepLinkConfigData = DeepLinkConfigData.fromJson(deepLinkJSON);
  }

  void processDeeplink(bool isUserAuthenticated, String? deeplinkUrl) async {
    if (deeplinkUrl != null) {
      assert(isDeepLinkValid(deeplinkUrl), '$deeplinkUrl is not a valid deeplink.');
      var deepLink = deeplinkUrl.replaceFirst(_deepLinkConfigData!.deepLinkBaseUrl, '');

      List<String> deepLinkArray = deepLink.split('/');
      assert(deepLinkArray.isNotEmpty, '$deeplinkUrl is not having sufficient data to be processed.');

      var screenName = deepLinkArray.removeAt(0);
      assert(screenName.isNotEmpty, '$deeplinkUrl is not having screen name to be navigated.');

      DeepLinkConfig? _configForScreen = getConfigsForScreenName(screenName);
      Map<String, String> _arguments = {};
      fetchArgumentsFromDeeplink(_configForScreen, deepLinkArray, screenName, _arguments);

      if (_configForScreen!.prerequisite == _Constant.authenticatedUser) {
        if (isUserAuthenticated) {
          await routeToTargetedScreen(screenName, _arguments);
        } else {
          navigateToLoginPage(deeplinkUrl);
        }
      } else {
        await routeToTargetedScreen(screenName, _arguments);
      }
    }
  }

  void navigateToLoginPage(String deeplinkUrl) {
    NavigationManager.navigateTo(
      'login-login',
      NavigationType.ReplaceCurrent,
      arguments: {'deep_link_url': deeplinkUrl},
    );
  }

  Future<void> routeToTargetedScreen(String screenName, Map<String, String> _arguments) async {
    if (screenName == _Constant.homeScreenName) {
      var _index = _arguments['tabIndex'];
      int index = _index != null ? int.parse(_index) : 0;
      moveToTabOnHome(index);
    } else {
      await NavigationManager.navigateTo(
        screenName,
        NavigationType.Push,
        arguments: _arguments,
      );
    }
  }

  void moveToTabOnHome(index) {
    taskManager.waitForExecute(Task(
      paramsInMap: {
        DATA_KEY: [
          'homeview',
        ],
        DATA_NOTIFIER_TYPE_KEY: DataNotifierTaskType.SET,
        DATA_NOTIFIER_PARAM_VALUES: {
          'index': index,
        },
      },
      taskType: TaskType.DATA_NOTIFIER,
    ));
  }

  void fetchArgumentsFromDeeplink(
    DeepLinkConfig? _configForScreen,
    List<String> deepLinkArray,
    String screenName,
    Map<String, String> _arguments,
  ) {
    if (_configForScreen != null) {
      assert(_configForScreen.arguments.length == deepLinkArray.length,
          'Received deeplink parameters for $screenName does not match with the parameter defined in the deeplink_config.json file.');
      for (var index = 0; index < deepLinkArray.length; index++) {
        var argKey = _configForScreen.arguments[index];
        var argValue = deepLinkArray[index];
        _arguments[argKey as String] = argValue;
      }
    }
  }

  DeepLinkConfig? getConfigsForScreenName(String screenName) {
    bool screenFoundInConfig = false;
    DeepLinkConfig? _configForScreen;
    for (var deepLinkConfig in _deepLinkConfigData!.deepLinkConfigs) {
      if (deepLinkConfig.screen == screenName) {
        screenFoundInConfig = true;
        _configForScreen = deepLinkConfig;
        break;
      }
    }
    assert(screenFoundInConfig, 'No matching screen name found with $screenName in the deeplink_config.json file.');
    return _configForScreen;
  }

  bool isDeepLinkValid(String deepLink) {
    if (deepLink.startsWith(_deepLinkConfigData!.deepLinkBaseUrl)) {
      return true;
    } else {
      return false;
    }
  }
}
