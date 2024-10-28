import 'dart:convert';
import 'package:core/encryption/i_encryption.dart';
import 'package:core/ioc/di_container.dart';
import 'package:data/remote_data_source/base_data_source/base_remote_data_source.dart';
import 'package:data/remote_data_source/credential_exchange/i_wallet_credentials_exchange_issuance_remote_data_source.dart';
import 'package:data/remote_data_source/credential_exchange/service/wallet_credentials_issuance_offer_request_service.dart';
import 'package:data/remote_data_source/credential_exchange/service/wallet_credentials_resolve_presentation_request_service.dart';
import 'package:data/remote_data_source/credential_exchange/service/wallet_match_credentials_request_service.dart';
import 'package:data/remote_data_source/credential_exchange/service/wallet_process_credentials_presentation_request_service.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_model.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_response_model.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:shared_dependencies/service_identifiers.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_manager.dart';

class GetWalletCredentialIssuanceRemoteDataSource extends BaseRemoteDataSource
    implements IWalletCredentialsExchangeIssuanceRemoteDataSource {
  GetWalletCredentialIssuanceRemoteDataSource(super.taskManager);

  @override
  Future<String?> postWalletCredentialResolvePresentationRequestAPI(
      String credentialOfferRequest) async {
    final token =
        await DIContainer.container.resolve<IAuthManager>().getAccessToken();
    final result = await executeApiAndHandleErrors(
      task: Task(
        subType: TaskSubType.REST,
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier:
            ServiceIdentifiers.postWalletCredentialsResolvePresentationRequest,
        parameters: PostWalletCredentialsResolvePresentationServiceParams(
            token: token, credentialsRequest: credentialOfferRequest),
      ),
    ) as WalletCredentialsResolvePresentationResponseModel?;

    if (result != null) {
      await storeResolvePresentationResponseKey(result.restResponse!);
      return result.restResponse;
    }
    return null;
  }

  @override
  Future<WalletCredentialListModel?> postWalletMatchCredentialsRequestAPI(
      String credentialRequest) async {
    final token =
        await DIContainer.container.resolve<IAuthManager>().getAccessToken();
    final result = await executeApiAndHandleErrors(
      task: Task(
        subType: TaskSubType.REST,
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier:
            ServiceIdentifiers.postMatchCredentialsForPresentationDefinition,
        parameters: PostWalletMatchCredentialsServiceParams(
            token: token, credentialsRequest: credentialRequest),
      ),
    ) as WalletCredentialsListResponseModel?;

    if (result != null) {
      final encryption = DIContainer.container.resolve<IEncryption>();
      final encryptedData = encryption.encrypt(jsonEncode(result.restResponse));
      await storeWalletCredKey(encryptedData);
      return WalletCredentialListModel.fromJson(result.restResponse!);
    }
    return null;
  }

  @override
  Future<bool?> postWalletProcessCredentialRequestAPI(
      String credentialId, String presentationResponse) async {
    Map<String, dynamic> jsonMap;
    final token =
        await DIContainer.container.resolve<IAuthManager>().getAccessToken();
    final result = await executeApiAndHandleErrors(
      task: Task(
        subType: TaskSubType.REST,
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier: ServiceIdentifiers.postProcessPresentationRequest,
        parameters: PostWalletProcessCredentialsServiceParams(
            token: token,
            resolvedPresentationResponse: presentationResponse,
            credentialId: credentialId),
      ),
    ) as WalletCredentialsProcessPresentationResponseModel;

    // Check if the restResponse is not null
    if (result.restResponse != null) {
      // Parse the JSON response into a ProcessResponseModel object
      final ProcessResponseModel getValue =
          ProcessResponseModel.fromJson(result.restResponse!);

      // Check if the redirectUri is null and return the result
      return getValue.redirectUri == null;
    }
    return null;
  }

  Future<void> storeWalletCredKey(String key) async {
    await executeApiAndHandleErrors(
        task: Task(
      taskType: TaskType.CACHE_OPERATION,
      parameters: CacheTaskParams(
        type: TaskManagerCacheType.SET,
        writeValues: {'wallet_match_presentation_cred': key},
      ),
    ));
  }

  Future<void> storeResolvePresentationResponseKey(String key) async {
    await executeApiAndHandleErrors(
        task: Task(
      taskType: TaskType.CACHE_OPERATION,
      parameters: CacheTaskParams(
        type: TaskManagerCacheType.SET,
        writeValues: {'wallet_resolve_presentation_response_key': key},
      ),
    ));
  }

  @override
  Future<WalletCredentialListModel?> postWalletCredentialOfferRequestAPI(String credentialOfferRequest, bool requireUserInput) async{
    final token =  await DIContainer.container.resolve<IAuthManager>().getAccessToken();
    final result = await  executeApiAndHandleErrors(
      task: Task(
        subType: TaskSubType.REST,
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier: ServiceIdentifiers.postWalletCredentialsIssuance,
        parameters: PostWalletCredentialsIssuanceServiceParams(
            token: token,
            credentialsIssuanceOfferRequest: credentialOfferRequest,
            isUserInputRequired: requireUserInput
        ),
      ),
    ) as WalletCredentialsListResponseModel?;

    if (result != null) {
      return WalletCredentialListModel.fromJson(result.restResponse!);
    }
    return null;
  }

  @override
  Future<String?> postWalletCredentialIssuanceRequestAPI() async {
    final result = await executeApiAndHandleErrors(
      task: Task(
        subType: TaskSubType.REST,
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier:
        ServiceIdentifiers.postWalletCredentialsIdentityIssuance,
      ),
    ) as WalletCredentialsResolvePresentationResponseModel?;

    if (result != null) {
      return result.restResponse;
    }
    return null;
  }

}
