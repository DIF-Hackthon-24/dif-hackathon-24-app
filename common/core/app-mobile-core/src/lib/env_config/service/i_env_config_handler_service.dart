abstract class IEnvConfigHandlerService {
  Future<Map<String, String>> loadEnvironment(String environment);

  String getBuild();

  String getEnvironmentVariable(
    String envName, {
    String defaultValue = '',
    bool isRequired = true,
  });
}
