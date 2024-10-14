import 'dart:convert';
import 'package:core/core.dart';
import 'package:core/ioc/di_container.dart';
import 'package:core/logging/logger.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/session_management/inactivity_service.dart';
import 'package:core/task/base_error.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:dio/dio.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:network_manager/utils/connectivity/jwt_parser.dart';
import 'package:shared_dependencies/base_usecase/enum_api_errors.dart';
import 'package:shared_dependencies/config_manager/i_config_manager.dart';
import 'package:shared_dependencies/constants/string_constants.dart';
import 'package:shared_dependencies/data_providers/language_code_data_provider.dart';
import 'package:shared_dependencies/data_providers/language_data_provider.dart';
import 'package:shared_dependencies/error_manager/error_manager.dart';
import 'package:shared_dependencies/navigation_handler/api_error_navigation_handler.dart';
import 'package:shared_dependencies/widgets/send_report_overlay_notification/send_report_overlay_notification.dart';
import 'package:shared_dependencies/widgets/send_report_overlay_notification/send_report_overlay_notification_attributes.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/task_manager_impl/task_manager_impl.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

class _Constants {
  static const String xOssToken = 'x-oss-token';
  static const sendReportApiErrorTheme = 'send_report_api_error';
  static const String sendApiErrorReport = "send_api_error_report";
  static const String adhaSendAPIErrorReportSuccessTitle = "adhaSendAPIErrorReportSuccessTitle";
  static const String adhaSendAPIErrorReportSuccessDescription = "adhaSendAPIErrorReportSuccessDescription";
  static const String adhaSendAPIErrorReportFailedTitle = "adhaSendAPIErrorReportFailedTitle";
  static const String adhaSendAPIErrorReportFailedDescription = "adhaSendAPIErrorReportFailedDescription";
  static const String SUPPORT_TEAM_EMAIL_ID_KEY = "SUPPORT_TEAM_EMAIL_ID";
  static const String SUPPORT_TEAM_EMAIL_ID = "<SUPPORT_TEAM_EMAIL_ID>";
  static const String SEND_ERROR_REPORT_MOBILE_NUMBER_KEY = "SEND_ERROR_REPORT_MOBILE_NUMBER";
  static const String SUPPORT_TEAM_MOBILE_NUMBER = "<SUPPORT_TEAM_MOBILE_NUMBER>";
  static const String htmlSource = "htmlResponse";
  static const String common = 'common';
  static const String gatewayErrorMessage = "gatewayErrorMessage";
  static const String errorCode = "errorCode";
  static const String message = "message";
  static const String messageEN = "messageEN";
  static const String messageAR = "messageAR";
  static const String contentType = 'content-type';
  static const String contentTypeHtml = 'text/html';
}

abstract class BaseUseCase {
  final TaskManager _taskManager;

  BaseUseCase(this._taskManager);

  Future<void> resetTokenWithValidity({String? token}) async {
    await DIContainer.container.resolve<IAuthManager>().storeTokenInformation(
          accessToken: token ?? '',
          sessionId: '',
          individualId: '',
        );

    final inactivityService = DIContainer.container.resolve<IInactivityService>();
    inactivityService.startTimer(expiryTime: Jwt.getExpiryDate(token ?? ''));
  }

  Future<String> getToken() async {
    return await DIContainer.container.resolve<IAuthManager>().getAccessToken() as String;
  }

  Future<String> getContent({required String section, required String key}) async {
    var data = await DIContainer.container.resolve<ILanguageDataProvider>().readFromLanguageFile();
    return data[section][key];
  }

  Future<T?> executeApiAndHandleErrors<T>(
      {required Task task,
      bool refreshToken = true,
      bool showErrorBottomSheet = true,
      bool dismissCurrentScreen = true}) async {
    final result = await _taskManager.waitForExecute<T>(task).catchError((error) async {
      final errorManager = DIContainer.container.resolve<IErrorManager>();
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
        if (error.response?.data != null && error.response?.data is Map<String, dynamic>) {
          final mapData = error.response?.data as Map<String, dynamic>? ?? {};
          if (mapData.containsKey(_Constants.errorCode)) {
            errorCode = mapData[_Constants.errorCode];
          }
          if (mapData.containsKey(_Constants.message)) {
            message = errorManager.getErrorMessage(ErrorType.API, errorCode);
          }
          if (mapData.containsKey(_Constants.messageEN)) {
            messageEN = errorManager.getErrorMessage(ErrorType.API, errorCode);
          }
          if (mapData.containsKey(_Constants.messageAR)) {
            messageAR = errorManager.getErrorMessage(ErrorType.API, errorCode);
          }
          responseData = json.encode(mapData);
        } else if (error.response!.headers.map[_Constants.contentType]!.first.contains(_Constants.contentTypeHtml)) {

          messageAR = await getContent(section: _Constants.common, key: _Constants.gatewayErrorMessage);
          messageEN = await getContent(section: _Constants.common, key: _Constants.gatewayErrorMessage);
          responseData = (error.response?.data is String) ? error.response?.data ?? '' : '';
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
          reference:task.apiIdentifier,
        );
      } else {
        baseError = BaseError(
          errorCode: '',
          message: error.propertyBlocked,
          reference:task.apiIdentifier,
        );
      }
      final selectedLanguage = await DIContainer.container.resolve<ILanguageCodeDataProvider>().getLanguageKey();
      var traceID = await getTraceId(baseError.traceId);
      String? message = null;
      String requestData = '';
      String responseData = '';
      if (selectedLanguage.equalsIgnoreCase('ar')) {
        message = errorManager.getErrorMessage(ErrorType.API, baseError.errorCode);
      } else {
        message = errorManager.getErrorMessage(ErrorType.API, baseError.errorCode);
      }
      if ((baseError.response ?? '').contains(_Constants.htmlSource)) {
        message = await getContent(section: _Constants.common, key: _Constants.gatewayErrorMessage);
        traceID = ''; // TraceId will be empty when message is null
        requestData = baseError.request ?? '';
        responseData = baseError.response ?? baseError.message;
        baseError = BaseError(
          errorCode: baseError.errorCode,
          message: message,
          messageAR: baseError.messageAR,
          messageEN: baseError.messageEN,
          statusCode: baseError.statusCode,
          request: requestData,
          response: baseError.response,
          reference:task.apiIdentifier,
        );
      }

      PSLogger.logAPIError(
        'API Error Trace Id: ${traceID} | Error Message:${message}',
      );

        requestData = baseError.request ?? '';
        responseData = baseError.response ?? '';
        _handleAPIErrorCase(
          baseError.errorCode,
          message,
          '${baseError.statusCode ?? 0}',
          task.apiIdentifier,
          requestData,
          responseData,
          dismissCurrentScreen,
          (error is DioException) ? error.requestOptions.path : '',
          showErrorBottomSheet,
        );
      throw baseError;
    });
    if (refreshToken) {
      String authToken = '';
      if (task.subType == TaskSubType.GRAPHQL && result?.headers != null) {
        authToken = result?.headers?[_Constants.xOssToken] ?? '';
      } else if (task.subType == TaskSubType.REST && result?.headers != null) {
        authToken = result?.headers?[_Constants.xOssToken]?[0] ?? '';
      } else if(task.subType == TaskSubType.REST_FILE_UPLOAD && result?.data !=null && result?.data.headers !=null){
        authToken = result?.data.headers?[_Constants.xOssToken]?[0] ?? '';
      }
      if (authToken.isNotEmpty) {
        await resetTokenWithValidity(token: authToken);
      }
    }
    return result;
  }

  void _handleAPIErrorCase(
    String errorCode,
    String message,
    String statusCode,
    String reference,
    String? request,
    String? response,
    bool? dismissCurrentScreen,
    String restUrl,
    bool showError,
  ) async {
    // * Do not support multiple error popups
    final currentRouteName = NavigationManager.getCurrentRouteName();
    final String errorRoutes = 'api_error_bottom_sheet';
    
    switch (errorCode.enm) {
      case APIErrors.ELIGIBILITY_CALCULATION_IN_PROGRESS:
        break;
      case APIErrors.NO_INTERNET_ACCESS:
        DIContainer.container.resolve<IApiErrorNavigationHandler>().showNoNetworkError();
        break;
      case APIErrors.NON_ELIGIBLE_APPLICANT:
        DIContainer.container.resolve<IApiErrorNavigationHandler>().moveToIneligibleApplicantScreen();
        break;
      case APIErrors.DEVICE_ID_MISMATCH:
        DIContainer.container.resolve<IApiErrorNavigationHandler>().showErrorMessageAndLogout(message,);
        break;
      case APIErrors.SUPPORT_SINGLE_LOGIN:
        DIContainer.container.resolve<IApiErrorNavigationHandler>().showErrorMessageAndLogout(message,);
        break;
      case APIErrors.UNAUTHORIZED:
      case APIErrors.FORBIDDEN:
      case APIErrors.INVALID_TOKEN:
      case APIErrors.EXPIRED_TOKEN:
        DIContainer.container.resolve<IApiErrorNavigationHandler>().logoutAndShowSessionTimeoutToast();
        break;
      case APIErrors.USER_NOT_IN_PILOT_PROGRAM:
        DIContainer.container.resolve<IApiErrorNavigationHandler>().moveToNotInPilotProgram();
        break;
      case APIErrors.CO_APPLICANT_USER:
        DIContainer.container.resolve<IApiErrorNavigationHandler>().moveToLoginCoApplicant(message);
        break;
      case APIErrors.USER_TYPE_NOT_SUPPORTED:
      case APIErrors.API_ERROR_WITHOUT_REPORTING_OPTION:
        if(showError && currentRouteName != errorRoutes){
        DIContainer.container.resolve<IApiErrorNavigationHandler>().showApiError(
              message,
              statusCode,
              dismissCurrentScreen: dismissCurrentScreen,
            );
        }
        break;
      case APIErrors.EXEMPTION_NO_ACTIVE_APPLICATIONS:
      if(showError){
        DIContainer.container.resolve<IApiErrorNavigationHandler>().showApiError(
          message,
          statusCode,
          errorCode: errorCode,
          dismissCurrentScreen: dismissCurrentScreen,
        );
      }
        break;

      default:
        if(showError){
        DIContainer.container.resolve<IApiErrorNavigationHandler>().showApiError(
          message,
          statusCode,
          sendReportEnable: true,
          dismissCurrentScreen: dismissCurrentScreen,
          sendReportOnTap: () async {
            await onSendReportAPIError(
              statusCode,
              errorCode,
              reference,
              request ?? '',
              response ?? '',
              true,
              restUrl,
              dismissCurrentScreen);
          },
        );
        }
    }
  }

  Future<void> onSendReportAPIError(
    String statusCode,
    String errorCode,
    String reference,
    String? request,
    String? response,
    bool isReport,
    String? restUrl,
    bool? dismissCurrentScreen,
  ) async {
    var _configManager = DIContainer.container.resolve<IConfigManager>();
    var configData = await _configManager.retrieveConfigData();

    var data =  await DIContainer.container.resolve<ILanguageDataProvider>().readFromLanguageFile();

    try {
      await _sendAPIErrorReport(
        statusCode,
        errorCode,
        reference,
        request,
        response,
        isReport,
        restUrl
      );
      if (NavigationManager.navigatorKey.currentContext == null) {
        return;
      }

      final commonData = data[_Constants.common] as Map<String, dynamic>;
      final sendApiErrorReport = commonData[_Constants.sendApiErrorReport] as Map<String, dynamic>;
      if(dismissCurrentScreen ?? true){
        NavigationManager.goBack();
      }
      NavigationManager.popDialog(arguments: {});
      _sendReportShowSuccessNotification(sendApiErrorReport);
    } catch (error) {
      PSLogger.logError(error.toString());
      NavigationManager.popDialog(arguments: {});
      if (error is BaseError) {
        final baseError = error;
        if (NavigationManager.navigatorKey.currentContext == null) {
          return;
        }
        final supportOfficeAddress = configData?[_Constants.SUPPORT_TEAM_EMAIL_ID_KEY] ?? '';

        final supportOfficeMobile = configData?[_Constants.SEND_ERROR_REPORT_MOBILE_NUMBER_KEY] ?? '';

        final commonData = data[_Constants.common] as Map<String, dynamic>;
        final sendApiErrorReport = commonData[_Constants.sendApiErrorReport] as Map<String, dynamic>;
        var traceid = await getTraceId(baseError.traceId);
        _sendReportShowUnsuccessNotification(
          sendApiErrorReport,
          supportOfficeAddress,
          supportOfficeMobile,
          traceid,
        );
      }
    }
  }

  Future<String> getTraceId(String? traceId) async {
    final isAuthenticated = await DIContainer.container.resolve<IAuthManager>().isUserAuthenticated();
    final applicationNumber = 'applicationNumber';
    final traceIDWithApplication =
        (traceId.isNotBlank() && applicationNumber.isNotBlank())
            ? '${traceId?.split('-')[0]}-$applicationNumber'
            :  (traceId.isNotBlank() ? traceId!.split('-')[0] : '');
    final baseErrorTraceId =
        (traceId != null && traceId.isNotEmpty) ? traceId.split('-')[0] : '';
     return isAuthenticated ? traceIDWithApplication : baseErrorTraceId;
  }

  Future<String?> _sendAPIErrorReport(
    String statusCode,
    String errorCode,
    String reference,
    String? request,
    String? response,
    bool isReport,
    String? restUrl,
  ) async {
    /* final deviceId = await DeviceInfo.getDeviceId();
    final traceId = await UUIDDataProviderImpl(
      taskManager: _taskManager,
      uuidManager: UUIDManagerImpl(
        uuidClient: const Uuid(),
      ),
    ).getUuidFromSecureStorage();
    String? newToken;
    newToken = await DIContainer.container.resolve<IAuthManager>().getAccessToken();
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    var deviceType = '';
    if (Platform.isAndroid) {
      deviceType = 'android';
    } else if (Platform.isIOS) {
      deviceType = 'iOS';
    }
    var deviceDetail = await DeviceInfo.getAllDeviceIfno() ?? {'deviceType': deviceType};
    try {
      final result = await executeApiAndHandleErrors(
        showErrorBottomSheet: false,
        task: Task(
          apiIdentifier: ServiceIdentifiers.sendAPIErrorReport,
          subType: TaskSubType.REST,
          taskType: TaskType.DATA_OPERATION,
          parameters: SendAPIErrorReportServiceParams(
            deviceId: deviceId,
            traceId: traceId,
            token: newToken ?? '',
            statusCode: statusCode,
            timestamp: '$timestamp',
            appVersion: '$appVersion',
            reference: '$reference',
            errorCode: errorCode,
            applicationNumber: "applicationNumber",
            deviceType: deviceType,
            response: response ?? '',
            request: request ?? '',
            deviceDetail: deviceDetail,
            isReport: isReport,
            restUrl: restUrl ?? '',
          ),
        ),
      ) as SendAPIErrorReportResponseModel?;
      if (result?.response != null) {
        return result?.response ?? '';
      }
      return null;
    } catch (e) {
      PSLogger.logError(e.toString());
      throw e;
    } */
    return null;
  }

  void _sendReportShowSuccessNotification(
    Map<String, dynamic> sendApiErrorReport,
  ) async {
    final successTitle = sendApiErrorReport[_Constants.adhaSendAPIErrorReportSuccessTitle] ?? '';
    final successDescription = sendApiErrorReport[_Constants.adhaSendAPIErrorReportSuccessDescription] ?? '';
    final key = await DIContainer.container.resolve<ILanguageCodeDataProvider>().getLanguageKey();
    final isArabic = key == StringConstants.arabicKey;

    Future.delayed(const Duration(milliseconds: 600), () {
      SendReportOverlayNotification.showCustomNotifcation(
        NavigationManager.navigatorKey.currentContext!,
        attributes: SendReportOverlayNotificationAttributes(
          title: successTitle,
          isArabic: isArabic,
          description: [
            TextSpanAttributes(
              text: successDescription,
              style: PSTheme().themeFor(_Constants.sendReportApiErrorTheme).textTheme.headlineSmall!,
            ),
          ],
          iconType: NotificationIcon.checkMark,
        ),
      );
    });
  }

  void _sendReportShowUnsuccessNotification(
    Map<String, dynamic> sendApiErrorReport,
    String supportOfficeAddress,
    String supportOfficeMobile,
    String traceId,
  ) async {
    final failedTitle = sendApiErrorReport[_Constants.adhaSendAPIErrorReportFailedTitle] ?? '';
    var failedDescription = sendApiErrorReport[_Constants.adhaSendAPIErrorReportFailedDescription] as String? ?? '';

    String desc1 = failedDescription.split(_Constants.SUPPORT_TEAM_EMAIL_ID).first;
    failedDescription = failedDescription.split(_Constants.SUPPORT_TEAM_EMAIL_ID).last;

    String desc2 = failedDescription.split(_Constants.SUPPORT_TEAM_MOBILE_NUMBER).first;
    failedDescription = failedDescription.split(_Constants.SUPPORT_TEAM_MOBILE_NUMBER).last;

    final key = await DIContainer.container.resolve<ILanguageCodeDataProvider>().getLanguageKey();
    final isArabic = key == StringConstants.arabicKey;

    Future.delayed(const Duration(milliseconds: 600), () {
      SendReportOverlayNotification.showCustomNotifcation(
        NavigationManager.navigatorKey.currentContext!,
        attributes: SendReportOverlayNotificationAttributes(
          title: failedTitle,
          isArabic: isArabic,
          description: [
            TextSpanAttributes(
              text: desc1,
              style: PSTheme().themeFor(_Constants.sendReportApiErrorTheme).textTheme.headlineSmall!,
            ),
            TextSpanAttributes(
              text: supportOfficeAddress,
              style: PSTheme().themeFor(_Constants.sendReportApiErrorTheme).textTheme.titleLarge!,
            ),
            TextSpanAttributes(
              text: desc2,
              style: PSTheme().themeFor(_Constants.sendReportApiErrorTheme).textTheme.headlineSmall!,
            ),
            TextSpanAttributes(
              text: supportOfficeMobile,
              style: PSTheme().themeFor(_Constants.sendReportApiErrorTheme).textTheme.titleLarge!,
            ),
             TextSpanAttributes(
              text: failedDescription,
              style: PSTheme().themeFor(_Constants.sendReportApiErrorTheme).textTheme.headlineSmall!,
            ),
          ],
          iconType: NotificationIcon.warning,
        ),
      );
    });
  }
}
