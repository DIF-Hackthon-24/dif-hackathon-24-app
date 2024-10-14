import 'package:core/env_config/service/i_env_config_handler_service.dart';
import 'package:core/environment/environment_service_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfigHandlerService implements IEnvConfigHandlerService {
  @override
  Future<Map<String, String>> loadEnvironment(String environment) async {
    
    final commonEnvironmentFilePath = 'assets/environment/.env.default';
    var overrideEnvFileValid = await _envFileValid(commonEnvironmentFilePath);

    if (!overrideEnvFileValid) {
      throw _invalidEnvironmentFile(commonEnvironmentFilePath);
    }

    var selectedEnv = DotEnv();
    final environmentFilePath = 'assets/environment/.env.$environment';
    overrideEnvFileValid = await _envFileValid(commonEnvironmentFilePath);

    if (!overrideEnvFileValid) {
      throw _invalidEnvironmentFile(commonEnvironmentFilePath);
    }
    
    // if (dotenv.isInitialized && dotenv.env.isNotEmpty) return {};

    await selectedEnv.load(fileName: environmentFilePath);
    // Load the env file based on the environment (eg .env.develop)
    await dotenv.load(fileName: commonEnvironmentFilePath, mergeWith: selectedEnv.env);
    final environmentEnv = {...dotenv.env};
    dotenv.env.addAll(environmentEnv);

    return dotenv.env;
  }

  Future<bool> _envFileValid(String path) async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      final str = await rootBundle.loadString(path);

      return str.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Exception _invalidEnvironmentFile(String path) {
    return Exception('Failed to load in .env file. '
        "Please ensure that you have a properly configured environment file located at '$path' "
        "and that it's been added to the pubspec.yaml");
  }

  @override
  String getBuild() {
    const build = String.fromEnvironment('ADHA_BUILD', defaultValue: '');

    if (!builds.contains(build.toLowerCase())) {
      throw Exception("Unknown ADHA_BUILD '$build', please choose one of ${builds.join(', ')}");
    }

    return build;
  }

  @override
  String getEnvironmentVariable(
    String envName, {
    String defaultValue = '',
    bool isRequired = true,
  }) {
    final value = dotenv.env[envName];

    if (isRequired && value == null) {
      throw Exception("Expected required environment variable '$envName' but got 'null'.");
    }

    return value ?? defaultValue;
  }
}
