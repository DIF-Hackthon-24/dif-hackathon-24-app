import 'package:core/ioc/di_container.dart';
import 'package:core/task/busy_type.dart';
import 'package:core/task/task_params.dart';
import 'package:data/remote_data_source/wallet_credentials_list/model/wallet_credentials_list_response_model.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:shared_dependencies/base_service/base_service_request.dart';
import 'package:shared_dependencies/service_identifiers.dart';

class PostWalletProcessCredentialsServiceParams extends TaskParams {
  String? token;
  String? resolvedPresentationResponse;
  String? credentialId;

  PostWalletProcessCredentialsServiceParams({
    required this.token,
    required this.resolvedPresentationResponse,
    required this.credentialId
  });
}

class _Constants {
  static const authKey = 'Authorization';
  static const bearer = 'Bearer';
}

class PostWalletProcessCredentialsRequestService extends BaseGraphQLService {
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
    final parameters = params as PostWalletProcessCredentialsServiceParams;
    final response = WalletCredentialsProcessPresentationResponseModel();
    return RestRequest(
      type: RequestType.post,
      name: ServiceIdentifiers.postProcessPresentationRequest,
      data: response,
      body: { 'presentationRequest': parameters.resolvedPresentationResponse,
        'selectedCredentials': [parameters.credentialId]},
      showBusy: BusyType.none,
      cachePolicy: CachePolicy.none,
      additionalHeaders: {
    _Constants.authKey: '${_Constants.bearer} ${parameters.token}'

      }
    );
  }
}
