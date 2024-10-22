import 'package:core/ioc/di_container.dart';
import 'package:core/module/module.dart';
import 'package:data/remote_data_source/credential_exchange/service/wallet_credentials_issuance_offer_request_service.dart';
import 'package:data/remote_data_source/credential_exchange/service/wallet_match_credentials_request_service.dart';
import 'package:data/remote_data_source/credential_exchange/service/wallet_process_credentials_presentation_request_service.dart';
import 'package:data/remote_data_source/manage_wallet_credentials/service/wallet_delete_credential_by_id_service.dart';
import 'package:data/remote_data_source/wallet_credentials_list/service/wallet_credentials_list_service.dart';
import 'package:network_manager/client/i_service.dart';
import 'package:shared_dependencies/base_usecase/stream_usecase.dart';
import 'package:shared_dependencies/config_manager/config_manager.dart';
import 'package:shared_dependencies/config_manager/i_config_manager.dart';
import 'package:shared_dependencies/converters/string_to_map_convertor.dart';
import 'package:shared_dependencies/data_providers/language_code_data_provider.dart';
import 'package:shared_dependencies/data_providers/language_data_provider.dart';
import 'package:shared_dependencies/error_manager/error_manager.dart';
import 'package:shared_dependencies/navigation_handler/api_error_navigation_handler.dart';
import 'package:shared_dependencies/service_identifiers.dart';
import 'package:task_manager/task_manager.dart';

class SharedDependenciesModule implements Module {
  @override
  void registerModules() {
    registerDependencies();
    registerUseCase();
    registerServices();
    registerCoordinator();
  }
}

extension SharedDependenciesModuleRegisterUseCaseExtension
    on SharedDependenciesModule {
  void registerUseCase() {
    DIContainer.container.registerFactory<IStreamUsecase>(
      (container) => StreamUsecase(
        container.resolve<TaskManager>(),
      ),
    );
  }
}

extension SharedDependenciesModuleRegisterExtension
    on SharedDependenciesModule {
  void registerDependencies() {
    DIContainer.container.registerFactory<IConfigManager>(
      (container) => ConfigManager(
        container.resolve<TaskManager>(),
      ),
    );

    DIContainer.container.registerFactory<IStringToMapConvertor>(
      (container) => StringToMapConvertorImpl(),
    );

    DIContainer.container
        .registerSingleton<IErrorManager>((container) => ErrorManager());

    DIContainer.container.registerFactory<ILanguageDataProvider>(
      (container) => LanguageDataProviderImpl(
        taskManager: container.resolve<TaskManager>(),
      ),
    );

    DIContainer.container.registerFactory<IApiErrorNavigationHandler>(
      (container) => ApiErrorNavigationHandler(
        LanguageDataProviderImpl(
          taskManager: container.resolve<TaskManager>(),
        ),
        StringToMapConvertorImpl(),
        LanguageCodeDataProviderImpl(
          taskManager: container.resolve<TaskManager>(),
        ),
      ),
    );
  }
}

extension SharedDependenciesModuleRegisterServiceExtension
    on SharedDependenciesModule {
  void registerServices() {
    DIContainer.container.registerFactory<IService>(
          (container) => GetWalletCredentialsListService(),
      name: ServiceIdentifiers.fetchWalletCredentialsList,
    );

    DIContainer.container.registerFactory<IService>(
          (container) => DeleteWalletCredentialByIdService(),
      name: ServiceIdentifiers.deleteWalletCredentialsById,
    );

    DIContainer.container.registerFactory<IService>(
          (container) => PostWalletCredentialsIssuanceOfferRequestListService(),
      name: ServiceIdentifiers.postWalletCredentialsIssuance,
    );

    DIContainer.container.registerFactory<IService>(
          (container) => PostWalletMatchCredentialsRequestService(),
      name: ServiceIdentifiers.postMatchCredentialsForPresentationDefinition,
    );

    DIContainer.container.registerFactory<IService>(
          (container) => PostWalletProcessCredentialsRequestService(),
      name: ServiceIdentifiers.postProcessPresentationRequest,
    );
  }
}

extension SharedDependenciesModuleCoordinatorExtension
    on SharedDependenciesModule {
  void registerCoordinator() {}
}
