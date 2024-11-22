import 'package:core/ioc/di_container.dart';
import 'package:core/navigation/navigation_manager.dart';
import 'package:core/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_manager/auth/i_auth_manager.dart';
import 'package:shared_dependencies/config_manager/i_config_manager.dart';
import 'package:shared_dependencies/constants/string_constants.dart';
import 'package:shared_dependencies/converters/string_to_map_convertor.dart';
import 'package:shared_dependencies/data_providers/language_code_data_provider.dart';
import 'package:shared_dependencies/data_providers/language_data_provider.dart';
import 'package:shared_dependencies/module_identifiers.dart';
import 'package:shared_dependencies/navigation_handler/no_network_navigation_handler.dart';
import 'package:widget_library/change_application_popup.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

import '../constants/color_constants.dart';

class _Constants {
  static const arguments = "arguments";
  static const themeName = 'themeName';
  static const shape = 'shape';
  static const isScrollControlled = 'isScrollControlled';
  static const themeDataLogout = 'logout_confirmation';
  static const themeDataSuccess = 'success_bottom_sheet_theme';
  static const themeApiError = 'enquiry_form_details_bottomsheet';

  static const sharedDependencies = 'shared_dependencies';
  static const apiErrorBottomSheet = 'api_error_bottom_sheet';
  static const notInPilot = 'not_in_pilot';
  static const login = 'login';
  static const ok = 'Ok';
  static const warningSymbol = 'assets/images/warning_symbol.svg';
  static const String EXEMPTION_NO_ACTIVE_APPLICATION_ERROR_CODE = 'DHP-MS-62-404';
  static const String exemptionContent = 'hackExemptionServicesSubmitConfirmationContent';
  static const String noActiveApplicationDescription = 'exemptionNoActiveApplicationDescription';
}

abstract class IApiErrorNavigationHandler {
  void showNoNetworkError();

  void showApiError(String message,String statusCode,
      {bool sendReportEnable = false, String errorCode, Function()? sendReportOnTap, bool? dismissCurrentScreen});

  void showErrorMessageAndLogout(String message,);

  void logoutAndShowSessionTimeoutToast();

  void moveToNotInPilotProgram();

  void moveToLoginCoApplicant(String message);

  void moveToIneligibleApplicantScreen();
}

class ApiErrorNavigationHandler extends NoNetworkNavigationHandler implements IApiErrorNavigationHandler {
  final LanguageDataProviderImpl languageDataProvider;
  final StringToMapConvertorImpl stringToMapConvertorImpl;
  final LanguageCodeDataProviderImpl codeDataProviderImpl;

  ApiErrorNavigationHandler(this.languageDataProvider, this.stringToMapConvertorImpl, this.codeDataProviderImpl)
      : super(
          languageDataProvider,
          stringToMapConvertorImpl,
          codeDataProviderImpl,
        );

  @override
  void showNoNetworkError() async {
    super.showNoNetworkErrorPopup();
  }

  @override
  void showApiError(String message, String statusCode,
      {bool sendReportEnable = false, String errorCode = '', Function()? sendReportOnTap,bool? dismissCurrentScreen}) async {
    var data = await languageDataProvider.readFromLanguageFile();
    final errorBtnTitle = data[StringConstants.dictionary]['hackOKBtnLabel'] ?? '';
    //var _configManager = DIContainer.container.resolve<IConfigManager>();
    final key = await codeDataProviderImpl.getLanguageKey();
    //var configData = await _configManager.retrieveConfigData();
    var primaryCtaEnabled = false;
    String? primaryCTAText;
    Function()? primaryButtonOnTap;
    if (sendReportEnable) {
      primaryCtaEnabled = true;
      primaryCTAText = data[StringConstants.dictionary]['hackSendReport'] ?? '';
      primaryButtonOnTap = sendReportOnTap;
    }

    String? description;
    if (errorCode.isNotEmptyOrNull
        && errorCode != ''
        && errorCode == _Constants.EXEMPTION_NO_ACTIVE_APPLICATION_ERROR_CODE) {
        description = data[StringConstants.common]?[_Constants.exemptionContent]
                ?[_Constants.noActiveApplicationDescription] ??
            '';
    } else {
      description = null;
    }

    await NavigationManager.navigateTo(
      "${_Constants.sharedDependencies}-${_Constants.apiErrorBottomSheet}",
      NavigationType.BottomSheet,
      barrierDismissiable: false,
      arguments: {
        _Constants.themeName: _Constants.themeApiError,
        _Constants.shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        _Constants.isScrollControlled: true,
        _Constants.arguments: ShowModalBottomSheetInfoAttributes(
          title: message,
          secondaryCTAText: errorBtnTitle,
          errorTitle: null,
          underLinedText: null,
          disableButtons: false,
          showBulletingInfo: false,
          showSubDescription: false,
          showDescription: true,
          description: description,
          primaryCtaEnabled: primaryCtaEnabled,
          primaryCTAText: primaryCTAText,
          cancelButtonOnTap: primaryButtonOnTap,
          isRtl: key == 'ar' ? true : false,
          confirmButtonOnTap: () {
            if (dismissCurrentScreen ?? true) {
              NavigationManager.goBack();
            }
            NavigationManager.popDialog(arguments: {});
          },
          iconAttributes: IconAttributes(
            iconPath: _Constants.warningSymbol,
            iconBackgroundColor: ColorConstants.COLOR_WHITE,
            iconBorderColor: PSTheme().themeFor(_Constants.themeDataSuccess).primaryColor,
          ),
        ),
      },
    );
  }

  @override
  void showErrorMessageAndLogout(String message,) async {
    final authManager = DIContainer.container.resolve<IAuthManager>();
    final isUserAuthenticated = await authManager.isUserAuthenticated();
    if(!isUserAuthenticated){
      return Future(() => null);
    }    
    var _configManager = DIContainer.container.resolve<IConfigManager>();
    //var dataString = await languageDataProvider.readFromLanguageFile();
    //var data = stringToMapConvertorImpl.getMapFromString(dataString);
    final key = await codeDataProviderImpl.getLanguageKey();
    //var configData = await _configManager.retrieveConfigData();
    authManager.clearState();
    await _configManager.clearConfigData();
    await _configManager.clearUserData();
     NavigationManager.navigateTo(
      '${ModuleIdentifiers.login}-${_Constants.login}',
      NavigationType.Replace,
      arguments: {
        'fetchConfig': true,
      }
    );
    await NavigationManager.navigateTo(
      "${_Constants.sharedDependencies}-${_Constants.apiErrorBottomSheet}",
      NavigationType.BottomSheet,
      barrierDismissiable: false,
      arguments: {
        _Constants.themeName: _Constants.themeDataLogout,
        _Constants.shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        _Constants.arguments: ShowModalBottomSheetInfoAttributes(
          title: message,
          secondaryCTAText: _Constants.ok,
          disableButtons: false,
          showBulletingInfo: false,
          description: null,
          showSubDescription: false,
          showDescription: true,
          primaryCtaEnabled: false,
          errorTitle: null,
          underLinedText: null,
          isRtl: key == 'ar' ? true : false,
          confirmButtonOnTap: () {
           NavigationManager.goBack();
          },
          iconAttributes: IconAttributes(
            iconPath: _Constants.warningSymbol,
            iconBorderColor: ColorConstants.COLOR_FFFBEAEA,
            iconBackgroundColor: ColorConstants.COLOR_WHITE,
          ),
        ),
      },
    );
  }

  @override
  void moveToNotInPilotProgram() {
    NavigationManager.navigateTo(
      '${ModuleIdentifiers.login}-${_Constants.notInPilot}',
      NavigationType.Push,
    );
  }

  @override
  void moveToLoginCoApplicant(String message) async {
    await NavigationManager.navigateTo('shared_dependencies-co_applicant_view', NavigationType.Push, arguments: {
      'message': message,
    });
  }

  @override
  void logoutAndShowSessionTimeoutToast() async {
    final authManager = DIContainer.container.resolve<IAuthManager>();
    final isUserAuthenticated = await authManager.isUserAuthenticated();
    if(!isUserAuthenticated){
      return Future(() => null);
    } 
    var _configManager = DIContainer.container.resolve<IConfigManager>();
    authManager.clearState();
    await _configManager.clearConfigData();
    await _configManager.clearUserData();
    await _configManager.clearNocData();

    var data = await languageDataProvider.readFromLanguageFile();
    final errorDescription = data['common']['sessionTimeOutMessage'] ?? '';
    NavigationManager.navigateTo(
      '${ModuleIdentifiers.login}-${_Constants.login}',
      NavigationType.Replace,
      arguments: {
        'fetchConfig': true,
      }
    );
    Future.delayed(const Duration(milliseconds: 600), () async {
      await Fluttertoast.showToast(
        msg: errorDescription,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xFF333333),
      );
    });
  }
  
  @override
  void moveToIneligibleApplicantScreen() async {
   await NavigationManager.navigateTo('global-ineligible_applicant', NavigationType.Push);
  }
}
