import 'package:core/ioc/di_container.dart';
import 'package:data/remote_data_source/base_data_source/base_remote_data_source.dart';
import 'package:data/remote_data_source/credential_exchange/i_wallet_credentials_exchange_issuance_remote_data_source.dart';
import 'package:data/remote_data_source/credential_exchange/service/wallet_credentials_issuance_offer_request_service.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_model.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_response_model.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:shared_dependencies/service_identifiers.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_manager.dart';

class GetWalletCredentialIssuanceRemoteDataSource extends BaseRemoteDataSource implements IWalletCredentialsExchangeIssuanceRemoteDataSource {
  GetWalletCredentialIssuanceRemoteDataSource(super.taskManager) ;


  @override
  Future<WalletCredentialListModel?> postWalletCredentialOfferRequestAPI(String credentialOfferRequest) async{
    final token =  await DIContainer.container.resolve<IAuthManager>().getAccessToken();
    final result = await  executeApiAndHandleErrors(
      task: Task(
        subType: TaskSubType.REST,
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier: ServiceIdentifiers.postWalletCredentialsIssuance,
        parameters: PostWalletCredentialsIssuanceServiceParams(
          token: token,
          credentialsIssuanceOfferRequest: credentialOfferRequest
        ),
      ),
    ) as WalletCredentialsListResponseModel?;

    if (result != null) {
        return WalletCredentialListModel.fromJson(result.restResponse!);
    }
    return null;
  }


}
