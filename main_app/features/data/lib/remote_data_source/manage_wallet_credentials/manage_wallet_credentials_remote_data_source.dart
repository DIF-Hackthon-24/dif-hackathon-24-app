import 'package:core/ioc/di_container.dart';
import 'package:data/remote_data_source/base_data_source/base_remote_data_source.dart';
import 'package:data/remote_data_source/manage_wallet_credentials/i_manage_wallet_credentials_remote_data_source.dart';
import 'package:data/remote_data_source/manage_wallet_credentials/model/wallet_credentials_delete_response_model.dart';
import 'package:data/remote_data_source/manage_wallet_credentials/service/wallet_delete_credential_by_id_service.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:shared_dependencies/service_identifiers.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_manager.dart';


class GetManageWalletCredentialsRemoteDataSource extends BaseRemoteDataSource implements IManageWalletCredentialsRemoteDataSource {
  GetManageWalletCredentialsRemoteDataSource(super.taskManager) ;


  @override
  Future<bool?> deleteCredentialByIdAPI(String credentialId, bool isPermanent) async{
    final token =  await DIContainer.container.resolve<IAuthManager>().getAccessToken();
    final result = await  executeApiAndHandleErrors(
      task: Task(
        subType: TaskSubType.REST,
        taskType: TaskType.DATA_OPERATION,
        apiIdentifier: ServiceIdentifiers.deleteWalletCredentialsById,
        parameters: DeleteWalletCredentialByIdServiceParams(
          token: token,
          credentialId: credentialId,
          isPermanent: isPermanent
        ),
      ),
    ) as WalletCredentialsDeleteResponseModel?;

    if (result != null) {return result.restResponse!.isEmpty;
    }
    return null;
  }
}
