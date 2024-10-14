import 'package:core/logging/logger_level.dart';

abstract class IEnvironmentSelectionHandler {
  Future<void> enableReadingOAuthToken(bool status);
  Future<bool> getEnableOauthToken();

  Future setLogLevels(LoggerLevel loggerLevel);
}
