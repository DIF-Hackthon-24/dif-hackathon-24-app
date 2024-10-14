import 'package:core/env_config/service/i_env_config_handler_service.dart';
import 'package:core/environment/environment_service_params.dart';
import 'package:core/task/i_task.dart';
import 'package:core/task/task_params.dart';

class EnvConfigHandlerTask implements ITask {
  static const identifier = 'environment_service';
  final IEnvConfigHandlerService _service;

  const EnvConfigHandlerTask(this._service);

  @override
  Future waitOnTask<T>(TaskParams? parameters) async {
    final params = parameters as EnvironmentServiceParams;

    switch (params.type) {
      case EnvironmentServiceTaskType.load:
        return _service.loadEnvironment(params.environment);

      case EnvironmentServiceTaskType.getBuildVersion:
        return _service.getBuild();

      case EnvironmentServiceTaskType.readEnvironmentVariable:
        print(params.defaultValue);
        return _service.getEnvironmentVariable(
          params.environment,
          defaultValue: params.defaultValue,
          isRequired: params.isRequired,
        );
    }
  }
}
