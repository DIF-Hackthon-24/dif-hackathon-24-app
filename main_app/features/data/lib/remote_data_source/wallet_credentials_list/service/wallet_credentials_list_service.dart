import 'package:core/ioc/di_container.dart';
import 'package:core/task/busy_type.dart';
import 'package:core/task/task_params.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_response_model.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:shared_dependencies/base_service/base_service_request.dart';
import 'package:shared_dependencies/service_identifiers.dart';

class GetWalletCredentialsListServiceParams extends TaskParams {
  String? token;

  GetWalletCredentialsListServiceParams({
    required this.token,
  });
}

class _Constants {
  static const authKey = 'Authorization';
  static const bearer = 'Bearer';
}

class GetWalletCredentialsListService extends BaseGraphQLService {
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
    final parameters = params as GetWalletCredentialsListServiceParams;
    final response = WalletCredentialsListResponseModel();
    return RestRequest(
      type: RequestType.get,
      name: ServiceIdentifiers.fetchWalletCredentialsList,
      data: response,
      showBusy: BusyType.none,
      cachePolicy: CachePolicy.none,
      additionalHeaders: {
    _Constants.authKey: '${_Constants.bearer} ${parameters.token}'

      }
    );
  }
}
