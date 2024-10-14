import 'dart:convert';

import 'package:shared_dependencies/config_manager/i_config_manager.dart';
import 'package:task_manager/task_manager.dart';
class _Constants {
  static const configKey = 'config_data';
  static const userDataKey = 'user_data';
}

class ConfigManager implements IConfigManager {
  final TaskManager _taskManager;
  ConfigManager(this._taskManager);

  @override
  Future<Map<String, dynamic>?> retrieveConfigData() async {
    final task = Task(
      taskType: TaskType.CACHE_OPERATION,
      parameters: CacheTaskParams(
        type: TaskManagerCacheType.MEMORY_GET,
        readValues: [_Constants.configKey],
      ),
    );
    var result = await _taskManager.waitForExecute(task);
    if ((result as Map<String, dynamic>).isNotEmpty) {
      final decodedData = jsonDecode(result[_Constants.configKey]) as Map<String, dynamic>? ?? {};
      return decodedData;
    }
    return null;
  }

  @override
  Future<void> storeConfigData(String configData) async {
    final task = Task(
      parameters: CacheTaskParams(
        type: TaskManagerCacheType.MEMORY_SET,
        writeValues: {_Constants.configKey: configData},
      ),
      taskType: TaskType.CACHE_OPERATION,
    );
    await _taskManager.waitForExecute(task);
  }

  @override
  Future<void> clearConfigData() async {
    await _taskManager.waitForExecute(
      Task(
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_CLEAR,
          clearKeys: [
            _Constants.configKey,
          ],
        ),
        taskType: TaskType.CACHE_OPERATION,
      ),
    );
  }

  @override
  Future<void> clearUserData() async {
    await _taskManager.waitForExecute(
      Task(
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_CLEAR,
          clearKeys: [
            _Constants.userDataKey,
          ],
        ),
        taskType: TaskType.CACHE_OPERATION,
      ),
    );
  }

  @override
  Future<void> clearNocData() async {
    await _taskManager.waitForExecute(
      Task(
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_CLEAR,
          clearKeys: [

          ],
        ),
        taskType: TaskType.CACHE_OPERATION,
      ),
    );
  }
}
