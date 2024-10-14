import 'package:core/ioc/di_container.dart';
import 'package:core/task/busy_type.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:network_manager/client/i_service.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:network_manager/model/response/base_data_model.dart';
import 'package:shared_dependencies/data/mocked_user_data.dart';

class Constant {
  static const String xTraceId = 'x-trace-id';
  static const String xDeviceId = 'x-device-id';
  static const String xGQLToken = 'X-GQL-Token';
  static const String automation1 = 'automation1';
  static const String contentType = 'Content-type';
  static const String contentValue = 'application/json';
  static const String userAgent = 'User-Agent';
  static const String userAgentValue = 'mobile';
}

abstract class BaseGraphQLService implements IService {
  static const String type = 'type';
  static const String xdeviceid = 'x-device-id';
  static const String xtraceid = 'x-trace-id';
  static const String xosstoken = 'x-oss-token';

  GraphQLRequest getGraphQLRequestWithHeaders({
    required BaseDataModel data,
    required RequestType type,
    required String name,
    required String request,
    Map<String, dynamic>? variables,
    String endPoint = Constants.graphQLDefaultEndpointName,
    Map<String, String>? additionalHeaders,
    BusyType showBusy = BusyType.defaultIndicator,
    int showBusyDelayInMilliseconds = 0,
    CachePolicy cachePolicy = CachePolicy.none,
  }) {
    return GraphQLRequest(
        data: data,
        request: request,
        type: type,
        name: name,
        showBusy: BusyType.none,
        cachePolicy: CachePolicy.none,
        variables: variables,
        additionalHeaders: addAdditionalHeaders(additionalHeaders));
  }

  static Map<String, String>? addAdditionalHeaders(
      Map<String, String>? additionalHeaders) {
    String? authToken;
    DIContainer.container
        .resolve<IAuthManager>()
        .getAccessToken()
        .then((value) {
      authToken = value;
    });

    Map<String, String> headers = {
      Constant.xGQLToken: authToken ?? '',
    };
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }
    handleMockUserRequestHeaders(headers);
    return headers;
  }

  static Map<String, String> addCommonHeaders({
    String? deviceId,
    String? traceId,
    String? xGQLToken,
  }) {
    Map<String, String> additionalHeaders = {
      Constant.contentType: Constant.contentValue,
      Constant.userAgent: Constant.contentValue,
      Constant.xDeviceId: deviceId ?? '',
      Constant.xTraceId: traceId ?? '',
      Constant.xGQLToken: xGQLToken ?? '',
    };
    return additionalHeaders;
  }

  static void handleMockUserRequestHeaders(Map<String, String>? headers) {
    final userData = DIContainer.container.resolve<MockedUserData>();
    if (userData.deviceId.isNotEmpty) {
      if (headers?.containsKey(Constant.xTraceId) ?? false) {
        headers?[Constant.xTraceId] = Constant.automation1;
      } else {
        headers?.addAll({Constant.xTraceId: Constant.automation1});
      }
      if (headers?.containsKey(Constant.xDeviceId) ?? false) {
        headers?[Constant.xDeviceId] = userData.deviceId;
      } else {
        headers?.addAll({Constant.xDeviceId: userData.deviceId});
      }
    }
  }

  RestRequest getRestRequestWithHeaders({
    required BaseDataModel data,
    required RequestType type,
    required String name,
    Object? body,
    Map<String, String>? additionalHeaders,
    Map<String, dynamic>? urlValues,
    Map<String, dynamic>? queryParameters,
  }) {
    return RestRequest(
        data: data,
        body: body,
        type: type,
        name: name,
        showBusy: BusyType.none,
        cachePolicy: CachePolicy.none,
        additionalHeaders: addAdditionalHeaders(additionalHeaders),
        urlValues: urlValues,
        queryParameters: queryParameters);
  }
}
