import 'package:core/logging/logger.dart';
import 'package:core/logging/logger_level.dart';
import 'package:core/task/i_task.dart';
import 'package:core/task/task_params.dart';

enum PSLoggerServiceType {
  getLogs,
  setLevel,
  getLevel,
}

class PSLoggerServiceParams extends TaskParams {
  final PSLoggerServiceType type;
  final LoggerLevel? level;

  PSLoggerServiceParams({required this.type, this.level});
}

class PSLoggerService extends ITask {
  static const identifier = 'logger_service';

  final PSLogger instance;

  PSLoggerService({required this.instance});

  @override
  Future waitOnTask<T>(TaskParams? args) async {
    final params = args as PSLoggerServiceParams;

    switch (params.type) {
      case PSLoggerServiceType.getLogs:
        return Future.value(PSLogger.logs);

      case PSLoggerServiceType.setLevel:
        instance.setLogLevels(params.level!);
        return Future.value(true);

      default:
        throw UnimplementedError();
    }
  }
}
