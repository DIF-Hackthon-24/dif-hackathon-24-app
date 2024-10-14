import 'package:core/task/task_params.dart';

typedef OnEnvironmentSelected = Function(String);

enum EnvironmentServiceTaskType {
  load,
  getBuildVersion,
  readEnvironmentVariable,
}

const builds = [
  'development',
  'production',
];

class EnvironmentServiceParams extends TaskParams {
  final String environment;
  final String defaultValue;
  final bool isRequired;
  final EnvironmentServiceTaskType type;

  EnvironmentServiceParams({
    required this.environment,
    required this.type,
    this.defaultValue = '',
    this.isRequired = true,
  });
}
