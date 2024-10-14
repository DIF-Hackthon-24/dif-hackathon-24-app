import 'package:core/environment/i_environment_selection_handler.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/module/module.dart';
import 'package:core/storage/memory_storage/memory_storage_service_impl.dart';
import 'package:core/storage/secure_storage/secure_storage_service.dart';
import 'package:core/task/i_task.dart';
import 'package:data/remote_data_source/credential_exchange/wallet_credentials_lissuance_remote_data_source.dart';
import 'package:data/remote_data_source/manage_wallet_credentials/manage_wallet_credentials_remote_data_source.dart';
import 'package:data/remote_data_source/wallet_credentials_list/wallet_credentials_list_remote_data_source.dart';
import 'package:data/repository/credential_exchange/wallet_credentialst_issuance_offer_request_repository.dart';
import 'package:data/repository/manage_wallet_credentials/delete_wallet_credentials_by_id_repository.dart';
import 'package:data/repository/wallet_credentials_list/wallet_credentials_list_repository.dart';
import 'package:database/dao/asset/asset_dao.dart';
import 'package:database/dao/asset/i_asset_dto.dart';
import 'package:database/dao/content_config/content_config_dao.dart';
import 'package:database/dao/content_config/i_content_config_dao.dart';
import 'package:database/dao/media/i_media_dao.dart';
import 'package:database/dao/media/media_dao.dart';
import 'package:database/dao/multi_media/i_multimedia_dao.dart';
import 'package:database/dao/multi_media/multimedia_dao.dart';
import 'package:database/dao/multimedia_mapping/i_multimedia_mapping_dao.dart';
import 'package:database/dao/multimedia_mapping/multimedia_mapping_dao.dart';
import 'package:database/dao/plot/i_plot_dao.dart';
import 'package:database/dao/plot/plot_dao.dart';
import 'package:database/db/wsa_database.dart';
import 'package:deeplink_manager/deeplink/deep_link_manager.dart';
import 'package:domain/usecase/credential_exchange/wallet_credentials_offer_request_use_case.dart';
import 'package:domain/usecase/manage_wallet_credentials/delete_wallet_credentials_use_case.dart';
import 'package:domain/usecase/wallet_credentials_list/wallet_credentials_list_use_case.dart';
import 'package:main_app/splash/coordinator/splash_coordinator.dart';
import 'package:main_app/splash/navigation_handler/splash_navigation_handler.dart';
import 'package:presentation/credential_exchange/coordinator/wallet_credentials_offer_request_coordinator.dart';
import 'package:presentation/credential_exchange/navigation_handler/wallet_credentials_list_navigation_handler.dart';
import 'package:presentation/wallet_credentials_list/coordinator/wallet_credentials_list_coordinator.dart';
import 'package:presentation/wallet_credentials_list/navigation_handler/wallet_credentials_list_navigation_handler.dart';
import 'package:download_manager/download_manager.dart';
import 'package:download_manager/i_download_manager.dart';
import 'package:network_manager/client/i_service.dart';
import 'package:shared_dependencies/converters/string_to_map_convertor.dart';
import 'package:shared_dependencies/data/mocked_user_data.dart';
import 'package:shared_dependencies/data_providers/language_code_data_provider.dart';
import 'package:shared_dependencies/data_providers/language_data_provider.dart';
import 'package:task_manager/environment_selection/environment_selection_task_handler.dart';
import 'package:task_manager/session_management/token_refresh_service/data/token_refresh_service.dart';
import 'package:task_manager/session_management/user_session/user_session_service.dart';
import 'package:task_manager/task_manager.dart';
import 'package:widget_library/environment/view_model/environment_select_view_model.dart';

part '_dao_register.dart';

class GlobalModule implements Module {
  @override
  void registerModules() {
    // Register Database as singleton.
    DIContainer.container
        .registerSingleton<WSADatabase>((container) => WSADatabase());

    registerDao();

    // Register Download Manager as singleton.
    DIContainer.container
        .registerSingleton<IDownloadManager>((container) => DownloadManager(
              multimediaDao: container.resolve<IMultimediaDao>(),
            ));

    DIContainer.container.registerFactory(
      (container) => DeepLinkManager(
        taskManager: container.resolve<TaskManager>(),
      ),
    );
    DIContainer.container.registerFactory<SecureStorageService>(
      (container) => SecureStorageService(),
    );
    DIContainer.container.registerFactory<MemoryStorageServiceImpl>(
      (container) => MemoryStorageServiceImpl(),
    );

    DIContainer.container.registerFactory<ITask>(
      (container) => UserSessionService(),
      name: UserSessionService.identifier,
    );

    DIContainer.container.registerFactory<IService>(
      (container) => TokenRefreshService(),
      name: TokenRefreshService.identifier,
    );

    DIContainer.container.registerFactory<IEnvironmentSelectionHandler>(
      (container) => EnvironmentSelectionTaskHandler(),
    );
    DIContainer.container.registerFactory(
      (container) => EnvironmentSelectViewModel(
        container.resolve<IEnvironmentSelectionHandler>(),
      ),
    );

    DIContainer.container.registerFactory<ILanguageCodeDataProvider>(
      (container) => LanguageCodeDataProviderImpl(
        taskManager: container.resolve<TaskManager>(),
      ),
    );

    DIContainer.container.registerFactory(
      (container) => SplashCoordinator(
          languageDataProvider: LanguageDataProviderImpl(
            taskManager: container.resolve<TaskManager>(),
          ),
          navigationHandler: SplashNavigationHandler(
            LanguageDataProviderImpl(
              taskManager: container.resolve<TaskManager>(),
            ),
            StringToMapConvertorImpl(),
            LanguageCodeDataProviderImpl(
              taskManager: container.resolve<TaskManager>(),
            ),
          ),
          getWalletCredentialsListUseCase: WalletCredentialsListUseCase(
              walletCredentialsListRepository: WalletCredentialsListRepository(
                  getWalletCredentialListRemoteDataSource:
                      GetWalletCredentialListRemoteDataSource(
            container.resolve<TaskManager>(),
          )))),
    );

    DIContainer.container.registerSingleton(
      (container) => MockedUserData(
        emiratesId: '',
        appId: '',
        deviceId: '',
        token: '',
        type: '',
        isProfileExists: false,
        role: '',
      ),
    );

    DIContainer.container.registerFactory(
      (container) => WalletCredentialsListCoordinator(
          getWalletCredentialsListUseCase: WalletCredentialsListUseCase(
              walletCredentialsListRepository: WalletCredentialsListRepository(
                  getWalletCredentialListRemoteDataSource:
                      GetWalletCredentialListRemoteDataSource(
        container.resolve<TaskManager>(),
      ))),
          deleteWalletCredentialsUseCase: DeleteWalletCredentialsUseCase(
              deleteWalletCredentialsByIdRepository :
              DeleteWalletCredentialsByIdRepository(manageWalletCredentialsRemoteDataSource: GetManageWalletCredentialsRemoteDataSource(
                container.resolve<TaskManager>(),
              ))
          ),
        navigationHandler: WalletCredentialListNavigationHandler(
          LanguageDataProviderImpl(
            taskManager: container.resolve<TaskManager>(),
          ),
          StringToMapConvertorImpl(),
          LanguageCodeDataProviderImpl(
            taskManager: container.resolve<TaskManager>(),
          ),
        ),
      ),
    );

    DIContainer.container.registerFactory(
          (container) => WalletCredentialsOfferRequestCoordinator(
            credentialsOfferRequestUseCase: WalletCredentialsOfferRequestUseCase(
              walletCredentialsIssuanceOfferRequestRepository: WalletCredentiaIssuanceOfferRequestRepository(walletCredentialsExchangeIssuanceRemoteDataSource:
              GetWalletCredentialIssuanceRemoteDataSource(
                container.resolve<TaskManager>(),
              )
              )),
            navigationHandler: CredentialExchangeNavigationHandler(
              LanguageDataProviderImpl(
                taskManager: container.resolve<TaskManager>(),
              ),
              StringToMapConvertorImpl(),
              LanguageCodeDataProviderImpl(
                taskManager: container.resolve<TaskManager>(),
              ),
      ),
    ));
  }
}
