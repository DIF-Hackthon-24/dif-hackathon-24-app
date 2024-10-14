// ignore_for_file: avoid_init_to_null

import 'dart:async';
import 'dart:convert';

import 'package:core/logging/logger.dart';
import 'package:core/performance_monitor/performance_monitor.dart';
import 'package:core/task/base_error.dart';
import 'package:core/utils/extensions/list_extensions.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:network_manager/client/mock/mock_network_client.dart';
import 'package:network_manager/client/network_client.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
import 'package:network_manager/model/response/base_network_response.dart';
import 'package:universal_io/io.dart';

extension GraphQLExtension on NetworkClient {
  Future<BaseNetworkResponse> executeGraphQLReqest({
    required GraphQLRequest request,
    required Map<String, GraphQLClient> clientList,
    String? sessionId,
  }) async {
    final graphQLClient = _clientForRequest(request.name, clientList);
    if (graphQLClient is MockNetworkClient) {
      final networkResponse = graphQLClient.runGraphQLRequest(request: request);

      return Future.value(networkResponse);
    }

    final client = graphQLClient as GraphQLClient;
    try {
      PSLogger.logDebug(
        '\n\nNetwork request: ${request.name}, ${request.request}, variables -- ${request.parameters.toString()}\n\n',
      );
      logStartOfNetworkRequest(request);

      final result = await startNetworkRequest(sessionId, request, client);

      PSLogger.logDebug(
        '\n\nNetwork Response: ${request.name}, variables -- ${request.parameters.toString()} --- data: ${result.data}\n\n',
      );

      if (!result.hasException && result.data != null) {
        var headers = result.context.entry<HttpLinkResponseContext>()?.headers;
        request.data!.fromJsonToModel(result.data!);
        if (headers != null) {
          request.data!.fromRawHeadersToModel(headers);
        }
        return Future.value(BaseNetworkResponse(data: request.data, rawData: result.data));
      }
      return _handleException(request, result);
    } on TimeoutException catch (e) {
      return handleTimeout(request,e.message ?? '');
    } finally {
      logEndOfNetworkRequest(request);
    }
  }

  Future<QueryResult> startNetworkRequest(String? sessionId, GraphQLRequest request, GraphQLClient client) async {
    switch (request.type) {
      case RequestType.mutate:
        return await _mutationBuilder(sessionId, request, client);
      case RequestType.query:
        return await _queryBuilder(sessionId, request, client);
      default:
        throw Exception('There is no ${request.type}');
    }
  }

  Future<QueryResult> _queryBuilder(String? sessionId, GraphQLRequest graphQLRequest, GraphQLClient client) {
    var networkTimeout = networkTimeoutInSeconds > 0 ? Duration(seconds: networkTimeoutInSeconds) : Constants.timeout;
    if (serviceTimeouts.isNotEmpty &&
        serviceTimeouts.containsKey(graphQLRequest.name)) {
      int timeout = serviceTimeouts[graphQLRequest.name] ?? 0;
      if (timeout > 0) {
        networkTimeout = Duration(seconds: timeout);
      }
    }
    return client
        .query(QueryOptions(
      document: gql(graphQLRequest.request),
      variables: graphQLRequest.parameters as Map<String, dynamic>? ?? {},
      context: _addAdditionalHeaders(sessionId, graphQLRequest.additionalHeaders),
    )).timeout(networkTimeout);
  }
  Future<QueryResult> _mutationBuilder(String? sessionId, GraphQLRequest graphQLRequest, GraphQLClient client) {
    var networkTimeout  = networkTimeoutInSeconds > 0 ? Duration(seconds: networkTimeoutInSeconds) : Constants.timeout;
    if (serviceTimeouts.isNotEmpty &&
        serviceTimeouts.containsKey(graphQLRequest.name)) {
      int timeout = serviceTimeouts[graphQLRequest.name] ?? 0;
      if (timeout > 0) {
        networkTimeout = Duration(seconds: timeout);
      }
    }
    return client
        .mutate(MutationOptions(
      document: gql(graphQLRequest.request),
      variables: graphQLRequest.parameters  as Map<String, dynamic>? ?? {},
      context: _addAdditionalHeaders(sessionId, graphQLRequest.additionalHeaders),
    )).timeout(networkTimeout);
  }
  dynamic _clientForRequest(String? name, Map<String, GraphQLClient> clients) {
    final gqlName = config.gqlMappingOverrides[name] ?? Constants.graphQLDefaultEndpointName;
    if (kReleaseMode) {
      return clients[gqlName];
    }

    if (clients.containsKey(gqlName)) {
      return clients[gqlName];
    }

    return mockNetworkClient;
  }

  Context? _addAdditionalHeaders(String? sessionId, Map<String, String>? additionalHeaders) {
    Map<String, String> newHeaders = {};
    if (additionalHeaders != null) {
      newHeaders = additionalHeaders;
    }

    if (sessionId.isNotBlank()) {
      newHeaders['x-session-id'] = sessionId!;
    }

    if (newHeaders.isNotEmpty) {
      final linkHeaders = HttpLinkHeaders(headers: newHeaders);
      return Context.fromMap({HttpLinkHeaders: linkHeaders});
    }

    return null;
  }

  // ignore: long-method
  BaseNetworkResponse _handleException(
      GraphQLRequest request,
      QueryResult result,
      ) {
    var message = '';
    String? messageEN = null;
    String? messageAR = null;
    String? traceId = '';
    String errorCode = Constants.defaultErrorCode;
    dynamic exception;
    Map<String, dynamic>? response;
    int statusCode = 0;

    traceId = request.additionalHeaders?['x-trace-id'] ?? '';
    if (result.hasException) {
      if (result.exception != null) {
        if (result.exception!.graphqlErrors.isNotEmpty && result.exception!.graphqlErrors.first.extensions != null) {
          PSLogger.logError(result.exception!.graphqlErrors.first.message);

          errorCode =
              result.exception!.graphqlErrors.first.extensions?['Code'] as String? ?? Constants.defaultErrorCode;
          exception = result.exception;
          message = result.exception!.graphqlErrors.first.message;

        } else if (result.exception!.linkException != null) {
          if (result.exception!.linkException is HttpLinkParserException) {
            final serverException = result.exception?.linkException as HttpLinkParserException;
            if (serverException.response.body.isNotEmpty) {
              if (serverException.response.body is Map<String, dynamic>) {
                response = json.decode(serverException.response.body) as Map<String, dynamic>? ?? {};
                final errorList = (response['errors']) as List? ?? [];
                if (errorList.isNotEmpty) {
                  statusCode = errorList.first['statusCode'] as int? ?? 0;
                  errorCode = errorList.first['errorCode'] as String? ?? '';
                  messageEN = errorList.first['messageEN'] as String? ?? '';
                  messageAR = errorList.first['messageAR'] as String? ?? '';
                }
              } else {
                statusCode = serverException.response.statusCode;
                response = {
                  'htmlResponse': serverException.response.body,
                };
              }
            }
            exception = serverException;
          } else if (result.exception!.linkException!.originalException != null) {
            exception = result.exception!.linkException!.originalException;

            if (exception is SocketException /*&& !await hasConnection()*/) {
              errorCode = 'no_internet_access';
            }

            //we can't cast without checking the type,it will throw exception...
            //this can happen,for example, when there is no internet.Then it will be thrown
            //Unhandled Exception: type 'SocketException' is not a subtype of type 'FormatException?' in type cast
            final originalFormatException = exception is FormatException ? exception : null;

            PSLogger.logError(originalFormatException?.message ?? '');
            PSLogger.logError(originalFormatException?.source as String? ?? '');
            messageEN = originalFormatException?.source.toString() ?? '';

            message = originalFormatException?.message ?? '';
          } else {
            //we have a link exception, but original message is null!
            if (result.exception is ServerException) {
              final serverException = result.exception as ServerException;
              message = serverException.parsedResponse?.errors?.firstOrNull((_) => true)?.message ?? '';
              serverException.parsedResponse?.errors?.forEach((element) {
                PSLogger.logError('Server Exception: ${element.message}');
              });
              exception = serverException;
            }
            if (result.exception?.linkException is ServerException) {
              final serverException = result.exception?.linkException as ServerException;
              message = serverException.parsedResponse?.errors?.firstOrNull((_) => true)?.message ?? '';
              final errorList = (serverException.parsedResponse?.response['errors']) as List? ?? [];
              if (errorList.isNotEmpty) {
                response = serverException.parsedResponse?.response;
                statusCode = errorList.first['statusCode'] as int? ?? 0;
                errorCode = errorList.first['errorCode'] as String? ?? '';
                messageEN = errorList.first['messageEN'] as String? ?? '';
                messageAR = errorList.first['messageAR'] as String? ?? '';
              }
              serverException.parsedResponse?.errors?.forEach((element) {
                PSLogger.logError('Server Exception: ${element.message}');
              });
              exception = serverException;
            }
          }
        }
      }

      PerformanceMonitor.track('${request.name}${Constants.networkCallExceptionKey}', properties: {
        Constants.methodKey: request.name,
        Constants.messageKey: message,
        Constants.errorCodeKey: errorCode,
      });
    }

    var  responseData = '';
    if (response != null) {
      responseData = json.encode(response);
    }
    return BaseNetworkResponse(
      error: BaseError(
        errorCode: errorCode,
        message: message,
        messageEN: messageEN,
        messageAR: messageAR,
        traceId: traceId,
        request: request.request,
        response: responseData,
        statusCode: statusCode,
      ),
    );
  }
}

