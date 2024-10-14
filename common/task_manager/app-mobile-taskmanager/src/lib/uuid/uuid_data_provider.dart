import 'package:task_manager/task_manager.dart';
import 'package:task_manager/uuid/uuid_manager.dart';

abstract class UUIDDataProvider {
  Future<String> getUuidFromSecureStorage();
}

class UUIDDataProviderImpl implements UUIDDataProvider {
  final TaskManager taskManager;
  final UUIDManager uuidManager;
  UUIDDataProviderImpl({
    required this.taskManager,
    required this.uuidManager,
  });
  @override
  Future<String> getUuidFromSecureStorage() async {
    String uuid = "";
    final keyData = await taskManager.waitForExecute(
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_GET,
          readValues: ['uuidKey'],
        ),
      ),
    );
    if (keyData != null) {
      if (keyData['uuidKey'] == null) {
        var uuidGenerated = uuidManager.getUUIDForDevice();
        bool isSet = await _storeUuidFromSecureStorage(uuidGenerated);
        if (isSet) {
          uuid = uuidGenerated;
        }
      } else {
        uuid = keyData['uuidKey'];
      }
    }
    return uuid;
  }

  Future<bool> _storeUuidFromSecureStorage(String key) async {
    return await taskManager.waitForExecute(
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.MEMORY_SET,
          writeValues: {'uuid': key},
        ),
      ),
    );
  }
}
