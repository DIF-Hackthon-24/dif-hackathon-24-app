import 'dart:convert';

import 'package:core/task/base_error.dart';
import 'package:dio/dio.dart';
import 'package:task_manager/task_manager.dart';

class _Constants {
  static const String errorCode = "errorCode";
  static const String message = "message";
  static const String messageEN = "messageEN";
  static const String messageAR = "messageAR";
  static const String contentType = 'content-type';
  static const String contentTypeHtml = 'text/html';
}

abstract class BaseRemoteDataSource{
  final TaskManager _taskManager;

  BaseRemoteDataSource(this._taskManager);

  Future<T?> executeApiAndHandleErrors<T>({
    required Task task,
  }) async {
    final result =
        await _taskManager.waitForExecute<T>(task).catchError((error) async {
      late BaseError baseError;
      if (error is BaseError) {
        baseError = error;
      } else if (error is DioException) {
        String requestData = '';
        String responseData = '';
        String errorCode = '';
        String messageAR = '';
        String messageEN = '';
        String? message = error.message;
        if (error.requestOptions.queryParameters.isNotEmpty) {
          requestData = json.encode(error.requestOptions.queryParameters);
        }
        if (error.response?.data != null &&
            error.response?.data is Map<String, dynamic>) {
          final mapData = error.response?.data as Map<String, dynamic>? ?? {};
          if (mapData.containsKey(_Constants.errorCode)) {
            errorCode = mapData[_Constants.errorCode];
          }
          if (mapData.containsKey(_Constants.message)) {
            message = "Something went wrong!";
          }
          if (mapData.containsKey(_Constants.messageEN)) {
            messageEN = "Something went wrong!";
          }
          if (mapData.containsKey(_Constants.messageAR)) {
            messageAR = "Something went wrong!";
          }
          responseData = json.encode(mapData);
        } else if (error.response!.headers.map[_Constants.contentType]!.first
            .contains(_Constants.contentTypeHtml)) {
          messageAR = "Something went wrong!";
          messageEN = "Something went wrong!";
          responseData = (error.response?.data is String)
              ? error.response?.data ?? ''
              : '';
          errorCode = error.response?.statusCode.toString() ?? '';
          requestData = error.requestOptions.path.toString();
        } else {
          responseData = error.response?.statusMessage ?? '';
        }

        baseError = BaseError(
          errorCode: errorCode,
          message: message ?? '',
          messageAR: messageAR,
          messageEN: messageEN,
          statusCode: error.response?.statusCode ?? 0,
          request: requestData,
          response: responseData,
          reference: task.apiIdentifier,
        );
      } else {
        baseError = BaseError(
          errorCode: '',
          message: error.propertyBlocked,
          reference: task.apiIdentifier,
        );
      }
      throw baseError;
    });
    return result;
  }
}
