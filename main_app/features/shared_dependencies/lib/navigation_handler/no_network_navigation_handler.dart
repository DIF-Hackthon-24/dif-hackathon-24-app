import 'package:core/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_dependencies/constants/string_constants.dart';
import 'package:shared_dependencies/converters/string_to_map_convertor.dart';
import 'package:shared_dependencies/data_providers/language_code_data_provider.dart';
import 'package:shared_dependencies/data_providers/language_data_provider.dart';
import 'package:widget_library/change_application_popup.dart';
import 'package:widget_library/common_widget/theme/ps_theme.dart';

import '../constants/color_constants.dart';

class _Constants {
  static const arguments = "arguments";
  static const themeName = 'themeName';
  static const shape = 'shape';
  static const isScrollControlled = 'isScrollControlled';
  static const themeDataSuccess = 'success_bottom_sheet_theme';
  static const sharedDependencies = 'shared_dependencies';
  static const apiErrorBottomSheet = 'api_error_bottom_sheet';
  static const warningSymbol = 'assets/images/warning_symbol.svg';
}

abstract class NoNetworkNavigationHandler {
  final LanguageCodeDataProviderImpl codeDataProviderImpl;
  final LanguageDataProviderImpl languageDataProvider;
  final StringToMapConvertorImpl stringToMapConvertorImpl;

  NoNetworkNavigationHandler(this.languageDataProvider, this.stringToMapConvertorImpl, this.codeDataProviderImpl);

  void showNoNetworkErrorPopup() async {
    final key = await codeDataProviderImpl.getLanguageKey();
    final noNetworkTitle = key == 'ar' ? StringConstants.offlineTitleAR : StringConstants.offlineTitleEN;
    final noNetworkDescription =
        key == 'ar' ? StringConstants.offlineDescriptionAR : StringConstants.offlineDescriptionEN;
    var dataString = await languageDataProvider.readFromLanguageFile();
    String errorMessageTitle = noNetworkTitle;
    String errorDescription = noNetworkDescription;
    String errorBtnTitle = 'Ok';
    if (dataString.isNotEmpty) {
      var data = dataString;
      errorMessageTitle = data[StringConstants.common]['noNetworkErrorTitle'] ?? noNetworkTitle;
      errorDescription = data[StringConstants.common]['noNetworkErrorDescription'] ?? noNetworkDescription;
      errorBtnTitle = data[StringConstants.dictionary]['adhaOKBtnLabel'] ?? 'Ok';
    }
    var primaryCtaEnabled = false;
    String? primaryCTAText;
    Function()? primaryButtonOnTap;

    await NavigationManager.navigateTo(
      "${_Constants.sharedDependencies}-${_Constants.apiErrorBottomSheet}",
      NavigationType.BottomSheet,
      barrierDismissiable: false,
      arguments: {
        _Constants.themeName: _Constants.themeDataSuccess,
        _Constants.shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        _Constants.isScrollControlled: true,
        _Constants.arguments: ShowModalBottomSheetInfoAttributes(
          title: errorMessageTitle,
          secondaryCTAText: errorBtnTitle,
          // errorTitle: errorMessageTitle,
          underLinedText: '',
          disableButtons: false,
          showBulletingInfo: false,
          showSubDescription: false,
          showDescription: true,
          description: errorDescription,
          primaryCtaEnabled: primaryCtaEnabled,
          primaryCTAText: primaryCTAText,
          cancelButtonOnTap: primaryButtonOnTap,
          isRtl: key == 'ar' ? true : false,
          confirmButtonOnTap: () {
            NavigationManager.goBack();
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
}
