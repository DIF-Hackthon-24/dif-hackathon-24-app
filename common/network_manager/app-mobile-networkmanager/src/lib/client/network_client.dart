import 'dart:io';
import 'package:core/core.dart';
import 'package:core/encryption/i_encryption.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/logging/logger.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/task/base_error.dart';
import 'package:core/utils/extensions/list_extensions.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/io_client.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:network_manager/client/extensions/network_client_graphql_extension.dart';
import 'package:network_manager/client/extensions/network_client_rest_extension.dart';
import 'package:network_manager/client/i_network_client.dart';
import 'package:network_manager/client/mock/mock_network_client.dart';
import 'package:network_manager/configuration/config.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/requests/rest/file_upload_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:network_manager/model/response/base_network_response.dart';

class NetworkClient implements INetworkClient {
  late Map<String, GraphQLClient> _graphQLClients;
  late Config config;
  final IAuthManager _authManager;
  late dio.Dio _restClient;
  late MockNetworkClient mockNetworkClient;
  int networkTimeoutInSeconds = 0;
  Map<String, int> serviceTimeouts = {};

  NetworkClient(this._authManager);

  @override
  Future<void> initializeNetworkClients({
    required String accessTokenKey,
    required Config config,
    Map<String, String>? headers,
    List<int>? certificateBytes,
    bool disableCertificatePinning = false,
  }) async {
    this.config = config;

    SecurityContext? context;
    if (!disableCertificatePinning && certificateBytes != null) {
      context = SecurityContext();
      context.setTrustedCertificatesBytes(certificateBytes);
    }

    // Read the GraphQL Clients
    _graphQLClients = _createGraphQLClients(
      accessTokenKey: accessTokenKey,
      config: config,
      headers: headers,
      context: context,
    );

    // Create the REST client
    if ((config.baseUrlMap ?? {})['defaultBaseURL'] != null) {
      _restClient = _createRestClient(
        context,
        config,
        headers,
      );
    }

    if (kDebugMode) {
      mockNetworkClient = MockNetworkClient();
      await mockNetworkClient.readMappingOverrides();
    }

    // Check that we have a default GraphQL endpoint configured
    assert(_graphQLClients.isNotEmpty);
  }

  Map<String, GraphQLClient> _createGraphQLClients({
    required String accessTokenKey,
    required Config config,
    required Map<String, String>? headers,
    SecurityContext? context,
  }) {
    var clients = <String, GraphQLClient>{};
    final encrypter = DIContainer.container.resolve<IEncryption>();
    final defaultBaseUrl = encrypter.decrypt((config.baseUrlMap?? {})['defaultBaseURL'] ??'');
    // final defaultBaseUrl = (config.baseUrlMap?? {})['defaultBaseURL'] ??'';
    final defaultEnvironment =
        config.gqlEnvironments.firstOrNull((element) => element.name == Constants.graphQLDefaultEndpointName);
    assert(defaultEnvironment != null,
        'There is no "${Constants.graphQLDefaultEndpointName}" GraphQLEndpoint configured in the network config');

    for (var env in config.gqlEnvironments) {
      var combinedHeaders = <String, String>{}..addAll(env.headers ?? {});

      if (headers != null) {
        combinedHeaders.addAll(headers);
      }

      String baseUrl = '';
      
      if(env.baseUrl.isNotEmptyOrNull){
        baseUrl = (config.baseUrlMap ?? {})[env.baseUrl] ?? defaultBaseUrl;
      }else{
        baseUrl = defaultBaseUrl;
      }
      
      // create http link
      final httpLink = (!kIsWeb)
          ? HttpLink(
            baseUrl + env.host,
              defaultHeaders: combinedHeaders,
              httpClient: IOClient(HttpClient(context: context)), //pin certificate to client
            )
          : HttpLink(
            baseUrl + env.host,
              defaultHeaders: combinedHeaders,
            );

      final authLink = AuthLink(
        getToken: () async {
          final accessTokenValue = await _authManager.getAccessToken() ?? '';
          return accessTokenValue.isBlank() ? '' : '$accessTokenKey $accessTokenValue';
        },
      ).concat(httpLink);

      final policies = Policies(
        fetch: FetchPolicy.networkOnly,
      );
      final client = GraphQLClient(
        link: authLink,
        cache: GraphQLCache(),
        defaultPolicies: env.disableCaching ?? false
            ? DefaultPolicies(
                query: policies,
              )
            : null,
      );
      clients[env.name] = client;
    }

    return clients;
  }

  dio.Dio _createRestClient(
    SecurityContext? context,
    Config config,
    Map<String, String>? headers,
  ) {
    var combinedHeaders = <String, String>{};
    if (headers != null) {
      combinedHeaders.addAll(headers);
    }
    final encrypter = DIContainer.container.resolve<IEncryption>();
    final baseUrl = encrypter.decrypt((config.baseUrlMap ?? {})['defaultBaseURL'] ??'');
    // final baseUrl = (config.baseUrlMap ?? {})['defaultBaseURL'] ??'';
    var options = dio.BaseOptions(
      connectTimeout: Duration(milliseconds: networkTimeoutInSeconds > 0
          ? networkTimeoutInSeconds * 1000
          : Constants.timeOutValue * 1000),
      headers: combinedHeaders,
      baseUrl:baseUrl,
    );

    final client = dio.Dio(options);
    if (!kIsWeb) {
      (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        HttpClient httpClient = HttpClient(context: context);
        return httpClient;
      };
    }

    return client;
  }

  @override
  Future<dio.Response<dynamic>> downloadFileFromUrl(String urlPath, String savePath,{Map<String,dynamic>? queryParams,Map<String,dynamic>? headers}) {
    return dio.Dio().download(urlPath, savePath,queryParameters: queryParams,options: Options(
      headers: headers,
    ));
  }

  @override
  Future<BaseNetworkResponse> runFileUpload({required FileUploadRequest request}) async {
    return await runFileUploadWithDio(request: request);
  }

  @override
  Future<BaseNetworkResponse> runGraphQLRequest({required GraphQLRequest request}) async => await executeGraphQLReqest(
        request: request,
        clientList: _graphQLClients,
        sessionId: _authManager.sessionId(),
      );

  @override
  Future<BaseNetworkResponse> runRestRequest({required RestRequest request}) async {
    return await executeRestReqest(
      request: request,
      client: _restClient,
      config: config,
      sessionId: _authManager.sessionId(),
    );
  }

  BaseNetworkResponse handleTimeout(
    GraphQLRequest request,String timeoutResponse,) {
    PerformanceMonitor.track('${request.name}${Constants.networkCallExceptionKey}', properties: {
      Constants.methodKey: request.name,
      Constants.messageKey: Constants.connectionTimeout,
      Constants.errorCodeKey: Constants.goneFishing,
    });
    PSLogger.logDebug('${Constants.networkResponseTimeoutError}${request.name}\n');
    return BaseNetworkResponse(
      error: BaseError(
        errorCode: Constants.connectionTimeout,
        message: Constants.networkResponseTimeoutError,
        messageEN: Constants.networkResponseTimeoutError,
        messageAR: Constants.networkResponseTimeoutErrorAR,
        request: request.request,  
        response: timeoutResponse,
      ),
    );
  }

  void logStartOfNetworkRequest(BaseRequest request) {
    PerformanceMonitor.startTimedEvent(
      '${request.name}${Constants.networkCallKey}',
      properties: {
        Constants.methodKey: request.name,
      },
    );
  }

  void logEndOfNetworkRequest(BaseRequest request) {
    PerformanceMonitor.endTimedEvent(
      '${request.name}${Constants.networkCallKey}',
      properties: {
        Constants.methodKey: request.name,
      },
    );
  }

  @override
  void setNetworkTimeout(int timeOutInSeconds, Map<String, int> serviceTimeout) async{
    serviceTimeouts = serviceTimeout;
    networkTimeoutInSeconds = timeOutInSeconds;
    _restClient.options.connectTimeout = Duration(milliseconds: networkTimeoutInSeconds > 0
        ? networkTimeoutInSeconds * 1000
        : Constants.timeOutValue * 1000) ;
  }

}
