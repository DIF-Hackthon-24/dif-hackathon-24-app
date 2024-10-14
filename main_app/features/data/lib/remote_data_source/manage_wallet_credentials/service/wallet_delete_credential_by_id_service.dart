import 'package:core/task/busy_type.dart';
import 'package:core/task/task_params.dart';
import 'package:data/remote_data_source/manage_wallet_credentials/model/wallet_credentials_delete_response_model.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:shared_dependencies/base_service/base_service_request.dart';
import 'package:shared_dependencies/service_identifiers.dart';

class DeleteWalletCredentialByIdServiceParams extends TaskParams {
  String? token;
  String credentialId;
  bool isPermanent;

  DeleteWalletCredentialByIdServiceParams({
    required this.token,
    required this.credentialId,
    required this.isPermanent,
  });
}

class _Constants {
  static const authKey = 'Authorization';
  static const bearer = 'Bearer';
}

class DeleteWalletCredentialByIdService extends BaseGraphQLService {
  @override
  GraphQLRequest getGraphQLRequest(
    TaskParams? params, {
    Map<String, dynamic>? paramsInMap,
  }) {
    throw UnimplementedError();
  }

  @override
  RestRequest getRestRequest(TaskParams? params,
      {Map<String, dynamic>? paramsInMap}) {
    final parameters = params as DeleteWalletCredentialByIdServiceParams;
    final response = WalletCredentialsDeleteResponseModel();
    return RestRequest(
        type: RequestType.delete,
        name: ServiceIdentifiers.deleteWalletCredentialsById,
        data: response,
        queryParameters: {
          "permanent" : parameters.isPermanent
        },
        showBusy: BusyType.none,
        cachePolicy: CachePolicy.none,
        additionalHeaders: {
          _Constants.authKey: '${_Constants.bearer} ${parameters.token}'
        },
        urlValues: {
          "credential_id": parameters.credentialId
        });
  }
}
