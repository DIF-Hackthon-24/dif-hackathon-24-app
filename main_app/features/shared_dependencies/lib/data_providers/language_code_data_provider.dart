import 'package:task_manager/task_manager.dart';

import '../constants/string_constants.dart';

abstract class ILanguageCodeDataProvider {
  Future<void> storeLanguageKey(String key);
  Future<String> getLanguageKey();
}

class LanguageCodeDataProviderImpl implements ILanguageCodeDataProvider {
  final TaskManager taskManager;
  LanguageCodeDataProviderImpl({
    required this.taskManager,
  });

  @override
  Future<void> storeLanguageKey(String key) async {
    await taskManager.waitForExecute(
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.SET,
          writeValues: {StringConstants.languageKey: key},
        ),
      ),
    );
  }

  @override
  Future<String> getLanguageKey() async {
    var value = "";
    final keyData = await taskManager.waitForExecute(
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.GET,
          readValues: [StringConstants.languageKey],
        ),
      ),
    );
    if (keyData != null) {
      value = keyData[StringConstants.languageKey] as String? ?? "";
    }
    return value;
  }
}
