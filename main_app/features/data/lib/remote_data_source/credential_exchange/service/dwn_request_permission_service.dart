import 'package:core/ioc/di_container.dart';
import 'package:core/task/busy_type.dart';
import 'package:core/task/task_params.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_response_model.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:shared_dependencies/base_service/base_service_request.dart';
import 'package:shared_dependencies/service_identifiers.dart';

class _Constants {
  static const dwnRequest = 'dwn_request';
}

class PostDwnRequestPermissionServiceParams extends TaskParams {
  Map<String, dynamic>? permissionRequest;

  PostDwnRequestPermissionServiceParams({
    required this.permissionRequest,
  });
}

class PostDwnRequestPermissionService extends BaseGraphQLService {
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
    final parameters = params as PostDwnRequestPermissionServiceParams;
    final response = WalletCredentialsProcessPresentationResponseModel();
    return RestRequest(
        type: RequestType.post,
        name: ServiceIdentifiers.postPermissionRequest,
        data: response,
        body: parameters.permissionRequest,
        showBusy: BusyType.none,
        cachePolicy: CachePolicy.none,
        queryParameters: {_Constants.dwnRequest: _Constants.dwnRequest});
  }
}
