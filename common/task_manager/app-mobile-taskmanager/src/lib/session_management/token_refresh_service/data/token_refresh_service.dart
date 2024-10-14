import 'package:core/task/busy_type.dart';
import 'package:core/task/task_params.dart';
import 'package:network_manager/client/i_service.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:task_manager/session_management/token_refresh_service/service_dependencies/data_model/token_refresh_response_model.dart';
import 'package:task_manager/session_management/token_refresh_service/service_dependencies/query/token_refresh_graphql_query.dart';

class TokenRefreshServiceParams extends TaskParams {
  String deviceId;
  String traceId;
  String? token;

  TokenRefreshServiceParams({
    required this.deviceId,
    required this.traceId,
    this.token,
  });
}

class TokenRefreshService implements IService {
  static const String identifier = 'tokenRefresh';

  @override
  GraphQLRequest getGraphQLRequest(
    TaskParams? params, {
    Map<String, dynamic>? paramsInMap,
  }) {
    final parameters = params as TokenRefreshServiceParams;

    final response = TokenRefreshResponseModel();
    final request = TokenRefreshGraphQLQuery.getQuery();

    return GraphQLRequest(
      data: response,
      request: request,
      type: RequestType.mutate,
      name: identifier,
      showBusy: BusyType.none,
      cachePolicy: CachePolicy.none,
      additionalHeaders: {
        'Content-type': 'application/json',
        'User-Agent': 'mobile',
        "x-device-id": parameters.deviceId,
        "x-trace-id": parameters.traceId,
        "x-oss-token": parameters.token ?? '',
      },
    );
  }

  @override
  RestRequest getRestRequest(TaskParams? params, {Map<String, dynamic>? paramsInMap}) {
    throw UnimplementedError();
  }
}
