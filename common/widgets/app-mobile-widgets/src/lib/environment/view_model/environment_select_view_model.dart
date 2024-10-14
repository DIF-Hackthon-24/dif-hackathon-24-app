import 'package:core/base_classes/base_coordinator.dart';
import 'package:core/environment/environment_resolver.dart';
import 'package:core/environment/environment_service_params.dart';
import 'package:core/environment/i_environment_selection_handler.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:widget_library/environment/state/environment_select_state.dart';

class EnvironmentSelectViewModel extends BaseCoordinator<EnvironmentSelectState> {
  late OnEnvironmentSelected onEnvironmentSelected;
  final IEnvironmentSelectionHandler _service;

  EnvironmentSelectViewModel(this._service)
      : super(EnvironmentSelectState(
          appVersion: '',
        ));

  Future initialize(OnEnvironmentSelected onEnvironmentSelected) async {
    this.onEnvironmentSelected = onEnvironmentSelected;

    // Get appVersion
    final packageInfo = await PackageInfo.fromPlatform();
    state = state.copyWith(
      appVersion: '${packageInfo.version} (${packageInfo.buildNumber})',
    );
  }

  int environmentsLength = PSEnvironments.values.length;

  String environment(int index) {
    return PSEnvironments.values[index].name;
  }

  void disableCertificatePinningStatus(bool status) {
    state = state.copyWith(disableCertificatePinning: status);
  }

  void mockLogin(bool status) {
    state = state.copyWith(mockLogin: status);
  }

  void onSelectEnvironment(String environment) async {
    if (
        environment.toLowerCase() == 'dev' ||
        environment.toLowerCase() == 'preprod') {
      if (state.enableOauthToken) {
        await setEnableOauthToken();
      }
    }

    await onEnvironmentSelected(environment);

    await NavigationManager.navigateTo(
      'global-splash',
      NavigationType.ReplaceCurrent,
      arguments: {
        'mock_login': state.mockLogin,
      },
    );
  }

  void updateEnableoAuthToken() {
    state = state.copyWith(enableOauthToken: !state.enableOauthToken);
  }

  Future setEnableOauthToken() async {
    await _service.enableReadingOAuthToken(state.disableCertificatePinning);
  }

  // Future<bool> getEnableOauthToken() async {
  //   final mapData = await _taskManager.execute(Task(
  //     parameters: CacheTaskParams(
  //       type: TaskManagerCacheType.MEMORY_GET,
  //       readValues: ['show_oAuth_token'],
  //     ),
  //     taskType: TaskType.CACHE_OPERATION,
  //   )) as Map<String, dynamic>;

  //   return mapData['show_oAuth_token'] == true;
  // }

  // Future setLogLevels(LoggerLevel loggerLevel) async {
  //   return await _taskManager.execute(
  //     Task(
  //       parameters: PSLoggerServiceParams(type: PSLoggerServiceType.setLevel, level: loggerLevel),
  //       apiIdentifier: PSLoggerService.identifier,
  //       taskType: TaskType.OPERATION,
  //     ),
  //   );
  // }
}
