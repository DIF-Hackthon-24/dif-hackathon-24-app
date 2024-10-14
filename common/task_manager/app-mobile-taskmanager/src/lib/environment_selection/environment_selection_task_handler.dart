import 'package:core/environment/i_environment_selection_handler.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/logging/logger_level.dart';
import 'package:core/logging/ps_logger_service.dart';
import 'package:task_manager/task_manager.dart';

class EnvironmentSelectionTaskHandler implements IEnvironmentSelectionHandler {
  @override
  Future<void> enableReadingOAuthToken(bool status) {
    final taskManager = DIContainer.container<TaskManager>();
    return taskManager.waitForExecute(
      Task(
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_SET,
          writeValues: {'show_oAuth_token': status},
        ),
        taskType: TaskType.CACHE_OPERATION,
      ),
    );
  }

  @override
  Future<bool> getEnableOauthToken() async {
    final taskManager = DIContainer.container<TaskManager>();
    final mapData = await taskManager.waitForExecute(Task(
      parameters: CacheTaskParams(
        type: TaskManagerCacheType.MEMORY_GET,
        readValues: ['show_oAuth_token'],
      ),
      taskType: TaskType.CACHE_OPERATION,
    )) as Map<String, dynamic>;

    return mapData['show_oAuth_token'] == true;
  }

  @override
  Future setLogLevels(LoggerLevel loggerLevel) async {
    final taskManager = DIContainer.container<TaskManager>();
    return await taskManager.waitForExecute(
      Task(
        parameters: PSLoggerServiceParams(type: PSLoggerServiceType.setLevel, level: loggerLevel),
        apiIdentifier: PSLoggerService.identifier,
        taskType: TaskType.OPERATION,
      ),
    );
  }
}
