import 'dart:convert';

import 'package:main_app/global_app_initializer.dart';
import 'package:main_app/module_register/shared_dependencies/shared_dependencies_module.dart';
import 'package:main_app/route/global_route_manager.dart';
import 'package:main_app/splash/screen/splash_view.dart';
import 'package:core/core.dart';
import 'package:core/core_initialization_params.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/media_query/ps_media_query.dart';
import 'package:core/navigation/i_navigation_handler.dart';
import 'package:core/storage/i_storage_service.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_dependencies/constants/color_constants.dart';
import 'package:shared_dependencies/constants/string_constants.dart';
import 'package:shared_dependencies/module_identifiers.dart';
import 'package:shared_dependencies/routes/api_errors_route_manager.dart';
import 'package:task_manager/task_manager_module.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';
import 'module_register/global/global_module.dart';

Future<void> initializeApp(Widget homeWidget, {String? environment, String? token, }) async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorConstants.COLOR_FFDDD7D6,
      systemNavigationBarColor: ColorConstants.COLOR_WHITE_10, // status bar color
    ),
  );


  final core = Core();
  DIContainer.container.registerSingleton<Core>((container) => core);


  await DIContainer.container.resolve<Core>().registerMinimalDependencies(
      secretSalt: await _getSecretSalt(),
      navigationHandler: DefaultNavigationHandler(),
      appTitle: StringConstants.appTitle,
      packages: {},
      homeWidget: homeWidget,
      moduleList: getModuleList(),
      appInitializer: () async {
        final theme = PSTheme();
        await theme.initialize();

        final storageService = DIContainer.container.resolve<IStorageService>();

        TaskManagerModule.registerDependencies(
          secureStorageService: storageService,
        );


        final globalAppInitializer = GlobalAppInitializer();

        DIContainer.container
            .registerFactory((container) => globalAppInitializer);

        if (environment != null && homeWidget is SplashView) {
          await globalAppInitializer.initializeEnvironmentBasedDependencies(
              DIContainer.container.resolve<Core>(), environment);
        }

        DIContainer.container.resolve<IAuthManager>().storeTokenInformation(
          accessToken: token as String,
          sessionId: '',
          individualId: '',
        );

        return Future.value(theme.defaultTheme);
      },
      onContextBuild: (BuildContext context) {
        PSMediaQuery().init(context);
      },
      onApplicationDetach: () {

      },
      sdkPackageName: "main_app",
      );
}

Future<List<int>> _getSecretSalt() async {
  await rootBundle.loadString(StringConstants.envDefaultPath);
  await dotenv.load(fileName: StringConstants.envDefaultPath);
  final environmentEnv = {...dotenv.env};
  dotenv.env.addAll(environmentEnv);

  final getBytes = dotenv.env[StringConstants.envKeyName] ?? '';
  final getBytesValues = List<int>.from(jsonDecode(getBytes));
  return getBytesValues;
}

List<CoreInitializationParams> getModuleList() {
  return [
    CoreInitializationParams(
      identifier: ModuleIdentifiers.shared_dependencies,
      moduleInstance: SharedDependenciesModule(),
      routeManager: APIErrorsRouteManager(),
    ),
    CoreInitializationParams(
      identifier: ModuleIdentifiers.global,
      moduleInstance: GlobalModule(),
      routeManager: GlobalRouteManager(),
    ),
  ];
}
