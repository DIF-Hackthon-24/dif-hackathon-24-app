import 'package:dio/dio.dart';
import 'package:network_manager/configuration/config.dart';
import 'package:network_manager/model/requests/rest/file_upload_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:network_manager/model/response/base_network_response.dart';

import '../model/requests/graph_ql/graphql_request.dart';

abstract class INetworkClient {
  void initializeNetworkClients(
      {required String accessTokenKey,
      required Config config,
      Map<String, String>? headers,
      List<int>? certificateBytes,
      bool disableCertificatePinning});

  /// Makes a Standard Request to an external API.
  ///
  /// [request] is generically typed to accept any type of request that belongs
  /// to the standard group of requests.
  Future<BaseNetworkResponse> runRestRequest({required RestRequest request});

  /// Makes a GET Request using GraphQL to an external API.
  ///
  /// [request] contains the information necessary for the method to make a
  /// GET Request to the API.
  /// todo: complete generic implementation of graphql requests
  Future<BaseNetworkResponse> runGraphQLRequest({required GraphQLRequest request});

  Future<BaseNetworkResponse> runFileUpload({required FileUploadRequest request});
  Future<Response<dynamic>> downloadFileFromUrl(String urlPath, String savePath,{Map<String,dynamic> queryParams,Map<String,dynamic>? headers});
  void setNetworkTimeout(int timeOutInSeconds, Map<String, int> serviceTimeouts);
}
