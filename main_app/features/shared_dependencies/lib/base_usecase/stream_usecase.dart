import 'package:task_manager/stream_observer/data_change_observer_resolver.dart';
import 'package:task_manager/task_manager.dart';


abstract class IStreamUsecase{
  Future<Stream?> getStream(String key);
  Future<void> disposeStream(String key);
  Future<void> notifyStream(Map<String,dynamic> key);
}
class StreamUsecase implements IStreamUsecase{
  final TaskManager _taskManager;

  StreamUsecase(this._taskManager);

  @override
  Future<Stream?> getStream(String key) async {
    var values = await _taskManager.waitForExecute(
      Task(
        parameters: DataChangeObserverTaskParams(
          type: DataNotifierTaskType.ADD,
          keys: [key],
        ),
        taskType: TaskType.DATA_NOTIFIER,
      ),
    );

    if (values != null && values[key] != null) {
      final _stream = values[key].stream;
      return _stream as Stream;
    }
    return Future.value(null);
  }

  @override
  Future<void> disposeStream(String key) async {
    await _taskManager.waitForExecute(Task(
      parameters: DataChangeObserverTaskParams(
        type: DataNotifierTaskType.DELETE,
        keys: [key],
      ),
      taskType: TaskType.DATA_NOTIFIER,
    ));
  }
  
  @override
  Future<void> notifyStream(Map<String,dynamic> key) async {
    await _taskManager.waitForExecute(Task(
      parameters: DataChangeObserverTaskParams(
        type: DataNotifierTaskType.SET,
        setKeys: key,
      ),
      taskType: TaskType.DATA_NOTIFIER,
    ));
  }
}