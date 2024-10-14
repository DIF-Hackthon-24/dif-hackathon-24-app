import 'package:task_manager/task_manager.dart';

import '../constants/string_constants.dart';

abstract class ILanguageDataProvider {
  Future<void> writeIntoLanguageFile(Map<String, dynamic> map);

  Future<Map<String,dynamic>> readFromLanguageFile();
}

class LanguageDataProviderImpl implements ILanguageDataProvider {
  final TaskManager taskManager;

  LanguageDataProviderImpl({
    required this.taskManager,
  });

  @override
  Future<Map<String,dynamic>> readFromLanguageFile() async {
    final localizationData = await taskManager.waitForExecute(
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_GET,
          readValues: [StringConstants.languageFileName],
        ),
      ),
    );

    var fileList = localizationData;
    Map<String,dynamic> value = {};

    if (fileList != null) {
      value = await fileList[StringConstants.languageFileName] ?? {};
    }

    return value;
  }

  @override
  Future<void> writeIntoLanguageFile(Map<String, dynamic> map) async {
    await taskManager.waitForExecute(
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_SET,
          writeValues: map,
        ),
      ),
    );
  }
}
