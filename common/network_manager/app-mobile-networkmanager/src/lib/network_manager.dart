library network_manager;

import 'dart:convert';

// Package imports:
import 'package:core/ioc/di_container.dart';
import 'package:core/storage/i_storage_service.dart';
// import 'package:core/storage/secure_storage/secure_storage_service.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/services.dart';
// Project imports:
import 'package:network_manager/auth/auth_manager.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/client/network_client.dart';
import 'package:network_manager/configuration/config.dart';

/// A class to manage the initialisation of the [NetworkManager] module
class NetworkManager {
  // public keys for di
  static const networkClientKey = 'network_client';

  /// Registers all of the dependencies for the network manager's dependency
  /// injection system.
  static Future<void> registerDependencies({
    required IStorageService secureStorage,
    required String accessTokenKey,
    String? environment,
    Map<String, String>? header,
    List<int>? certificateBytes,
  }) async {
    // Read Network Configuration
    final config = await _readNetworkConfiguration(environment);

    ///we need refresh token for biometrics login
    ///secureStorage.delete('refresh_token');
    final authManager = AuthManager(
      //secureStorage as SecureStorageService,
    );
    DIContainer.container.registerSingleton<IAuthManager>((container) => authManager);

    final networkClient = NetworkClient(
      authManager,
    );

    // register a network client and its dependencies
    DIContainer.container.registerSingleton<INetworkClient>(
      (c) => networkClient,
      name: networkClientKey,
    );

    await networkClient.initializeNetworkClients(
      config: config,
      accessTokenKey: accessTokenKey,
      headers: config.headers,
      certificateBytes: certificateBytes,
    );
  }

  static Future<Config> _readNetworkConfiguration(String? environment) async {
    var commonNetworkConfigFilePath = 'assets/configuration/common_network_configuration.json';

    final commonNetworkConfigString = await rootBundle.loadString(commonNetworkConfigFilePath);
    var networkConfigJson = jsonDecode(commonNetworkConfigString) as Map<String, dynamic>;

    var envNetworkConfigFilePath = 'assets/configuration/network_configuration';

    if (environment?.isNotBlank() ?? false) {
      envNetworkConfigFilePath = "${envNetworkConfigFilePath}_${environment!}";
    }
    final envNetworkConfigString = await rootBundle.loadString(
      '$envNetworkConfigFilePath.json',
    );

    final envNetworkConfigJSON = jsonDecode(envNetworkConfigString) as Map<String, dynamic>;

    networkConfigJson = updateConfig(networkConfigJson, envNetworkConfigJSON);

    final config = Config.fromJson(networkConfigJson);

    return config;
  }

  static Map<String, dynamic> updateConfig(Map<String, dynamic> commonConfig, Map<String, dynamic> envConfig) {
    // Iterate over all the environment specific configurations (overridden configurations and new configurations).
    for (var key in envConfig.keys) {
      // Check if the environment configuration is present in the common configurations.
      if (commonConfig.containsKey(key)) {
        if (envConfig[key] is List<dynamic>) {
          // Handle the List type configurations.
          Map<String, dynamic> listMap = {}; // holder for the final configurations.
          List<dynamic> leftOverEnvConfigs = [...envConfig[key]]; // make a copy of the envConfig to track new configurations.
          // Compare common configurations and environment configurations to find out overridden configurations and new configurations.
          for (var env in envConfig[key]) {
            for (var common in commonConfig[key]) {
              bool isOverriddenCase = false;
              if (env is Map<String, dynamic> && common is Map<String, dynamic> && env['name'] == common['name']) {
                // If same name configuration exist in the common and environment configuration then this is the case of overridden config.
                isOverriddenCase = true;
                leftOverEnvConfigs.remove(env); // Remove the overridden configuration from the left over so the newly added config are left.
                var updatedMap = updateConfig(common, env);
                listMap.update(common['name'] as String, (value) => updatedMap, ifAbsent: () => updatedMap); // add updated config to the place holder list.
              }
              if (!isOverriddenCase) {
                // If config is not overridden then simply add to the placeholder list.
                listMap.update(common['name'] as String, (value) => common, ifAbsent: () => common);
              }
            }
          }
          var list = listMap.entries.map((e) => e.value).toList();
          list.addAll(leftOverEnvConfigs); // Add left over configs that are new configs to the place holder list.
          commonConfig.update(key, (value) => list);
        } else if (envConfig[key] is Map<String, dynamic>) {
          // Handle map type configurations.
          var updatedMap = updateConfig(commonConfig[key] as Map<String, dynamic>, envConfig[key] as Map<String, dynamic>);
          commonConfig.update(key, (value) => updatedMap);
        } else {
          commonConfig.update(key, (value) => envConfig[key], ifAbsent: () => envConfig[key]);
        }
      } else {
        // Environment configuration are not present in the common configuration, So it is new configuration for this environment. Add it.
        commonConfig.putIfAbsent(key, () => envConfig[key]);
      }
    }
    return commonConfig;
  }
}
