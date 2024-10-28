import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:core/encryption/i_encryption.dart';
import 'package:core/ioc/di_container.dart';
import 'package:dio/io.dart';
import 'package:http_parser/http_parser.dart';
import 'package:core/logging/logger.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/task/base_error.dart';
import 'package:core/utils/extensions/list_extensions.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as rest_response;
import 'package:network_manager/client/network_client.dart';
import 'package:network_manager/configuration/config.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/rest/file_upload_request.dart';
import 'package:network_manager/model/requests/rest/rest_request.dart';
import 'package:network_manager/model/response/base_network_response.dart';
import 'package:core/utils/extensions/iterable_extensions.dart';


extension RestExtension on NetworkClient {
  Future<BaseNetworkResponse> executeRestReqest({
    required RestRequest request,
    required Dio client,
    required Config config,
    String? sessionId,
  }) async {
    final environment = _environmentForAPI(
      name: request.name,
      environments: config.restEnvironments,
      mappingOverrides: config.gqlMappingOverrides,
    );

    logStartOfNetworkRequest(request);

    final headers = _addAdditionalHeaders(
      sessionId: sessionId,
      additionalHeaders: request.additionalHeaders,
      environment: environment,
    );

    try {
      final result = await startNetworkRequest(
        request: request,
        path: environment.host,
        client: client,
        headers: headers,
      );

      PSLogger.logDebug(
        '\n\nNetwork Response: ${request.name}, data: ${result.data}\n\n',
      );

      if (result.statusCode == 200 || result.statusCode! < 300) {
        request.data!.fromRawResponseToModel(result.data);
        request.data!.fromRawHeadersToModel(result.headers.map);
        logEndOfNetworkRequest(request);
        return Future.value(BaseNetworkResponse(data: request.data));
      }

      logEndOfNetworkRequest(request);
      final traceId = request.additionalHeaders?['x-trace-id'] ?? '';

      String requestData = '';
      String responseData = '';
      if (result.requestOptions.data is String) {
        requestData = result.requestOptions.data as String? ?? '';
      } else if (result.requestOptions.data is Map<String, dynamic>) {
        final mapData = result.requestOptions.data as Map<String, dynamic>? ?? {};
        requestData = json.encode(mapData);
      }
      if (result.data is Map<String, dynamic>) {
        var mapData = result.data as Map<String, dynamic>? ?? {};
        responseData = json.encode(mapData);
      } else {
        Map<String, dynamic> mapData = {
          'response' : result.data,
        };
        responseData = json.encode(mapData);
      }
      return _handleException(
        request.name,
        result.statusCode.toString(),
        result.statusMessage ?? '',
        traceId,
        result.statusCode,
        requestData,
        responseData,
      );
    } catch (e) {
      final dioError = e as DioException;
      if (dioError.error is SocketException) {
        return _handleException(
          request.name,
          'no_internet_access',
          '',
          '',
          0,
          '',
          '',
        );
      } else {
        rethrow;
      }
    }
  }

  Environment _environmentForAPI({
    required String name,
    required List<Environment> environments,
    required Map<String, String> mappingOverrides,
  }) {
    final environment = environments.firstOrNull((element) => element.name == name);
    return environment!;
  }

  Future<rest_response.Response> startNetworkRequest({
    required RestRequest request,
    required String path,
    required Dio client,
    required Map<String, String> headers,
  }) async {
    switch (request.type) {
      case RequestType.get:
        return await _standardGetRequest(
            path: path,
            client: client,
            headers: headers,
            body: request.parameters,
            urlValues: request.urlValues,
            queryParameters: request.queryParameters
        );
      case RequestType.post:
        return await _standardPostRequest(
            path: path,
            client: client,
            headers: headers,
            body: request.parameters,
            urlValues: request.urlValues,
            queryParameters: request.queryParameters
        );
      case RequestType.fileDownload:
        return await _fileDownloadRequest(
            client: client,
            path: path,
            headers: headers,
            queryParameters: request.queryParameters
        );
      case RequestType.delete:
        return await _standardDeleteRequest(
          path: path,
          client: client,
          headers: headers,
          body: request.parameters,
          urlValues: request.urlValues,
          queryParameters: request.queryParameters,
        );

      default:
        throw Exception('There is no ${request.type}');
    }
  }

  Future<rest_response.Response> _standardGetRequest({
    required Dio client,
    required String path,
    required Map<String, String> headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? urlValues,
    Object? body,
  }) async {
    PSLogger.logDebug<NetworkClient>(
      'Sending GET request to the server for url: $path',
    );
    if(urlValues != null && urlValues.isNotEmpty){
      urlValues.entries.forEachIndexed((element,index){
        path = path.replaceFirst(element.key, element.value);
      });
    }

    final response = await client.get(path, options: Options(headers: headers), queryParameters: queryParameters,data: body);
    return response;
  }

  Future<rest_response.Response> _standardDeleteRequest({
    required Dio client,
    required String path,
    required Map<String, String> headers,
    Object? body,
    Map<String, dynamic>? urlValues,
    Map<String, dynamic>? queryParameters,
  }) async {
    PSLogger.logDebug<NetworkClient>(
      'Sending POST request to the server for url: $path',
    );
    if(urlValues != null && urlValues.isNotEmpty){
      urlValues.entries.forEachIndexed((element,index){
        path = path.replaceFirst(element.key, element.value);
      });
    }
    final response = await client.delete(path, queryParameters: queryParameters, data: body, options: Options(headers: headers));
    return response;
  }


  Future<rest_response.Response> _standardPostRequest({
    required Dio client,
    required String path,
    required Map<String, String> headers,
    Object? body,
    Map<String, dynamic>? urlValues,
    Map<String, dynamic>? queryParameters,
  }) async {
    PSLogger.logDebug<NetworkClient>(
      'Sending POST request to the server for url: $path',
    );
    if(urlValues != null && urlValues.isNotEmpty){
      urlValues.entries.forEachIndexed((element,index){
        path = path.replaceFirst(element.key, element.value);
      });
    }
    var storeBaseUrl =  client.options.baseUrl;
    if(queryParameters != null && queryParameters.isNotEmpty && queryParameters["identity"] == 'identity'){
      client.options.baseUrl = "https://issuer.portal.walt.id";
      queryParameters.remove('identity');
    }

    final response = await client.post(path,queryParameters: queryParameters, data: body, options: Options(headers: headers));
    client.options.baseUrl = storeBaseUrl;
    return response;
  }

  Future<BaseNetworkResponse> runFileUploadWithDio({required FileUploadRequest request}) async {
    final localConfig = config.restEnvironments.firstOrNull((config) => config.name == request.name);

    if (localConfig == null) {
      throw 'No registered host for REST upload in assets/network_configuration_[environment].json!';
    }
    final headers = (localConfig.headers ?? {})
      ..addAll(request.additionalHeaders ?? {})
      ..addAll(config.headers);
    final host = localConfig.host;
    final encrypter = DIContainer.container.resolve<IEncryption>();
    final baseUrl = encrypter.decrypt((config.baseUrlMap ?? {})['defaultBaseURL'] ??'');
    // final baseUrl = (config.baseUrlMap ?? {})['defaultBaseURL'] ??'';
    var endPoint = '$baseUrl$host';
    var fileName = request.file.path.split('/').last;
    //final mimeType = lookupMimeType(request.file.path);
    final multipartFile = await MultipartFile.fromFile(
      request.file.path,
      contentType: getMediaTypes(fileName.split('.').last),
      // //contentType: MediaType('application', mimeType ?? 'pdf'),
      filename: fileName.toString(),);

    final data = FormData.fromMap({
      'file': multipartFile,
    });
    data.fields.addAll(request.requestFields!.entries);

    final options = Options(headers: headers);
    final urlValues = request.urlValues;

    if(urlValues != null && urlValues.isNotEmpty){
      urlValues.entries.forEachIndexed((element,index){
        endPoint = endPoint.replaceFirst(element.key, element.value);
      });
    }

    return _executeRestFileUpload(endPoint, request, data, options);
  }

  MediaType getMediaTypes(String ext){
    switch(ext.toLowerCase()){
      case 'png':
        return MediaType('image','png');
      case 'jpg':
      case 'jpeg':
        return MediaType('image','jpeg');
      default:
        return MediaType('application', 'pdf');
    }
  }

  Future<BaseNetworkResponse> _executeRestFileUpload(
      String endpoint,
      FileUploadRequest request,
      FormData data,
      Options options,
      ) async {
    final traceId = request.additionalHeaders?['x-trace-id'] ?? '';
    try{
      final result = await Dio().post(endpoint,
        queryParameters: request.queryParameters,
        data: data,options: options,);

      if (result.statusCode == 200 || result.statusCode! < 300) {
        PSLogger.logDebug(
          '\n\nNetwork Response: ${request.name}, data: ${result.data}\n\n',
        );
        request.responseModel!.fromRawResponseToModel(result.data);
        request.responseModel!.fromRawHeadersToModel(result.headers.map);
        return Future.value(BaseNetworkResponse(data: request.responseModel));
      }
      var mapData = result.data as Map<String, dynamic>? ?? {};
      final encodedRequestData = jsonEncode(mapData);
      final encodedResult = jsonEncode(result);
      return _handleException(
        request.name,
        result.statusCode.toString(),
        result.statusMessage ?? '',
        traceId,
        result.statusCode,
        encodedRequestData,
        encodedResult,);
    }catch(e){
      PSLogger.logError(e.toString());
      final dioError = e as DioException;
      if (dioError.error is SocketException) {
        return _handleException(
          request.name,
          'no_internet_access',
          '',
          '',
          0,
          '',
          '',
        );
      } else {
        rethrow;
      }
    }
  }


  Future<rest_response.Response> _fileDownloadRequest({
    required Dio client,
    required String path,
    required Map<String, String> headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    PSLogger.logDebug<NetworkClient>(
      'Sending GET request to the server for url: $path',
    );
    PSLogger.logDebug(headers.toString());
    PSLogger.logDebug(queryParameters.toString());
    PSLogger.logDebug(path.toString());
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
    final response = await client.get(
      path,
      options: Options(
        headers: headers,
        responseType: ResponseType.bytes,
      ),
      queryParameters: queryParameters,
    );
    return response;
  }

  Map<String, String> _addAdditionalHeaders({
    String? sessionId,
    Map<String, String>? additionalHeaders,
    required Environment environment,
  }) {
    Map<String, String> newHeaders = environment.headers ?? {};
    if (additionalHeaders != null) {
      newHeaders = additionalHeaders;
    }

    if (sessionId.isNotBlank()) {
      newHeaders['x-session-id'] = sessionId!;
    }

    return newHeaders;
  }

  // ignore: long-parameter-list
  BaseNetworkResponse _handleException(
      String apiName,
      String errorCode,
      String message,
      String traceId,
      int? statusCode,
      String? request,
      String? response,
      ) {
    PerformanceMonitor.track('$apiName${Constants.networkCallExceptionKey}', properties: {
      Constants.methodKey: apiName,
      Constants.messageKey: message,
      Constants.errorCodeKey: errorCode,
    });

    return BaseNetworkResponse(
      error: BaseError(
        errorCode: errorCode,
        message: message,
        messageAR: message,
        messageEN: message,
        traceId: traceId,
        statusCode: statusCode ?? 0,
        request: request,
        response: response,
      ),
    );
  }
}
