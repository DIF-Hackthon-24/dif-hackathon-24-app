import 'dart:convert';

import 'package:core/encryption/i_encryption.dart';
import 'package:core/ioc/di_container.dart';
import 'package:data/remote_data_source/base_data_source/base_remote_data_source.dart';
import 'package:data/remote_data_source/wallet_credentials_list/i_wallet_credentials_list_remote_data_source.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_model.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_response_model.dart';
import 'package:data/remote_data_source/wallet_credentials_list/service/wallet_credentials_list_service.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:shared_dependencies/service_identifiers.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_manager.dart';


class GetWalletCredentialListRemoteDataSource extends BaseRemoteDataSource implements IGetWalletCredentialListRemoteDataSource {
  GetWalletCredentialListRemoteDataSource(super.taskManager) ;


  @override
  Future<WalletCredentialListModel?> getWalletCredentialListAPI() async{
    final token =  await DIContainer.container.resolve<IAuthManager>().getAccessToken();
    final result = await  executeApiAndHandleErrors(
      task: Task(
        subType: TaskSubType.REST,
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier: ServiceIdentifiers.fetchWalletCredentialsList,
        parameters: GetWalletCredentialsListServiceParams(
          token: token,
        ),
      ),
    ) as WalletCredentialsListResponseModel?;

    if (result != null) {
      // final encryption = DIContainer.container.resolve<IEncryption>();
      // final encryptedData = encryption.encrypt(jsonEncode(result.restResponse)) ;
      // await storeWalletCredKey(encryptedData);
      return WalletCredentialListModel.fromJson(result.restResponse!);
    }
    return null;
  }

  Future<void> storeWalletCredKey(String key) async {
     await  executeApiAndHandleErrors(
     task:  Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.SET,
          writeValues: {'wallet_cred': key},
        ),
      )
    );
  }

  @override
  Future<WalletCredentialListModel?> getWalletCredKey() async {
    final keyData = await executeApiAndHandleErrors(
      task:
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.GET,
          readValues: ['wallet_match_presentation_cred'],
        ),
      ),
    );
    if (keyData != null && keyData['wallet_match_presentation_cred'] !=null) {
      final encryption = DIContainer.container.resolve<IEncryption>();
      final decryptedData = jsonDecode(encryption.decrypt((keyData['wallet_match_presentation_cred'] as String? ?? "")));
      return WalletCredentialListModel.fromJson(decryptedData);
    }
    return null;
  }

  @override
  Future<String?> getWalletResolvePresentationKey() async {
    final keyData = await executeApiAndHandleErrors(
      task:
      Task(
        taskType: TaskType.CACHE_OPERATION,
        parameters: CacheTaskParams(
          type: TaskManagerCacheType.GET,
          readValues: ['wallet_resolve_presentation_response_key'],
        ),
      ),
    );
    if (keyData != null && keyData['wallet_resolve_presentation_response_key'] !=null) {
      return keyData['wallet_resolve_presentation_response_key'];
    }
    return null;
  }

}
