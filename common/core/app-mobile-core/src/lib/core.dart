library core;

import 'dart:async';
import 'package:core/analytics/AnalyticsLogger.dart';
import 'package:core/analytics/i_analytics.dart';
import 'package:core/app/my_app.dart';
import 'package:core/encryption/encryption.dart';
import 'package:core/encryption/i_encryption.dart';
import 'package:core/inactivity_watcher/inactivity_watcher.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/navigation/i_navigation_handler.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/storage/i_storage_service.dart';
import 'package:core/storage/secure_storage/secure_storage_service.dart';
import 'package:core/translation/app_localization_service.dart';
import 'package:core/translation/i_app_localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'biometrics_auth/biometrics_auth.dart';
import 'package:core/module/module.dart';
import 'package:core/core_initialization_params.dart';

export './utils/extensions/date_time_extensions.dart';
export './utils/extensions/object_extensions.dart';
export './utils/extensions/string_extensions.dart';

typedef AppInitializer = Future<ThemeData> Function();

class Core {
  // Map<String, ICrashListener>? _crashListeners;

  Future<void> registerMinimalDependencies({
    required List<int> secretSalt,
    required INavigationHandler navigationHandler,
    required AppInitializer appInitializer,
    required Widget homeWidget,
    required String appTitle,
    required Map<String, String> packages,
    required List<CoreInitializationParams> moduleList,
    List<String> supportedLanguangesCode = const ['en', 'ar'],
    required void Function(BuildContext context) onContextBuild,
    required void Function() onApplicationDetach,
    required String sdkPackageName,
  }) async {
    await runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        NavigationManager(navigationHandler);

        // Encryption Key
        DIContainer.container.registerSingleton<IEncryption>((container) => Encryption(secretSalt));

        // Register Secure Storage
        final secureStorageService = SecureStorageService();
        DIContainer.container.registerSingleton<IStorageService>((container) => secureStorageService);

        // Register App Localization
        DIContainer.container.registerSingleton<IAppLocalizationService>((container) => AppLocalizationService());
        DIContainer.container
            .registerSingleton((container) => BiometricsAuth(container.resolve<IAppLocalizationService>()));

        /* 
        /// Push notification
        // Register PushNotification Registration Service.
        DIContainer.container.registerSingleton((container) => NotificationRegistrationService());

        
        DIContainer.container.registerSingleton<INotificationManager>(
          (container) => NotificationManager(
            container.resolve<TaskManager>(),
          ),
        ); 

        // Register PushNotification Action Service.
        DIContainer.container.registerSingleton((container) => NotificationActionService());

        // Register PushNotificationManager
        DIContainer.container.registerSingleton(
          (container) => PushNotificationManager(
            DIContainer.container.resolve<INotificationManager>(),
            DIContainer.container.resolve<NotificationRegistrationService>(),
            DIContainer.container.resolve<NotificationActionService>(),
            container.resolve<TaskManager>(),
          ),
        ); */
        
        _registerFeatureModules(moduleList);

        FlutterError.onError = (FlutterErrorDetails details) {
          /* _crashListeners?.keys.forEach(
            (key) {
              final crashMonitor = DIContainer.container.resolve<ICrashListener>(key);
              crashMonitor.unhandledErrors(
                details,
              );
            },
          ); */
        };

        // await SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.landscapeLeft,
        //   DeviceOrientation.landscapeRight,
        // ]);

        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

        final theme = await appInitializer();
        _bootStrapTheApp(
          homeWidget: homeWidget,
          appTitle: appTitle,
          packages: packages,
          supportedLanguangesCode: supportedLanguangesCode,
          theme: theme,
          onContextBuild: onContextBuild,
          onApplicationDetach: onApplicationDetach,
        );
      },
      (error, stackTrace) {
        /* _crashListeners?.keys.forEach(
          (key) {
            final crashMonitor = DIContainer.container.resolve<ICrashListener>(key);
            crashMonitor.unhandledExceptions(
              error,
              stackTrace,
            );
          },
        ); */
      },
    );
  }

  void _bootStrapTheApp({
    required Widget homeWidget,
    required String appTitle,
    required Map<String, String> packages,
    required List<String> supportedLanguangesCode,
    required ThemeData theme,
    required void Function(BuildContext context) onContextBuild,
    required void Function() onApplicationDetach,
  }) {
    final app = InactivityWatcher(
      inactivityService: DIContainer.container.resolve(),
      child: MyApp(
        appTitle: appTitle,
        packages: packages,
        supportedLanguangesCode: supportedLanguangesCode,
        homeWidget: homeWidget,
        theme: theme,
        onContextBuildListener: onContextBuild,
        onApplicationDetach: onApplicationDetach,
      ),
    );
    runApp(
      ProviderScope(
        key: Key('ProviderScope'),
        child: app,
      ),);
      
  }

  void registerEnvironmentBasedDependencies(/* {
    required List<IAnalytics> analyticsHandlers,
    required Map<String, ICrashListener> crashListeners,
  } */) {
    // _crashListeners = crashListeners;

    // Register Analytics
    DIContainer.container.registerSingleton<IAnalytics>(
      //(container) => AnalyticsLogger(analyticsHandlers),
      (container) => AnalyticsLogger(<IAnalytics>[]),
    );

    /* crashListeners.keys.forEach(
      (key) {
        final listener = crashListeners[key]!;
        DIContainer.container.registerSingleton<ICrashListener>(
          (container) => listener,
          name: key,
        );
      },
    ); */

    PerformanceMonitor.startCollecting();
  }

  void _registerFeatureModules(List<CoreInitializationParams> moduleList) {
    moduleList.forEach(
      (module) {
        DIContainer.container.registerInstance<Module>(module.moduleInstance, name: module.identifier);
        module.moduleInstance.registerModules();
        NavigationManager.registerRouteManager(module.identifier, module.routeManager);
      },
    );
  }
}
