import 'package:core/core.dart';
import 'package:core/environment/environment_service_params.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/storage/i_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:network_manager/network_manager.dart';
import 'package:task_manager/env_config/task/env_config_handler_task.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_manager_impl/task_manager_impl.dart';

class GlobalAppInitializer {
  Future<void> initializeEnvironmentBasedDependencies(Core core, String environment) async {
    final storageService = DIContainer.container.resolve<IStorageService>();
    await _readEnvironmentVars(environment);
    await NetworkManager.registerDependencies(
      secureStorage: storageService,
      accessTokenKey: '',
      environment: environment,
    );

    (kIsWeb)
        ? core.registerEnvironmentBasedDependencies()
        : core.registerEnvironmentBasedDependencies();
  }

   Future _readEnvironmentVars(String environment) async {
    final taskManager = DIContainer.container.resolve<TaskManager>();

    final envValues = await taskManager.waitForExecute<Map<String, String>>(
      Task(
        apiIdentifier: EnvConfigHandlerTask.identifier,
        parameters: EnvironmentServiceParams(
          environment: environment,
          type: EnvironmentServiceTaskType.load,
        ),
        taskType: TaskType.OPERATION,
      ),
    );
    return envValues;
  }
}
