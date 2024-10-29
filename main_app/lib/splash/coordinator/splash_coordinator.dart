import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/base_classes/base_coordinator.dart';
import 'package:core/logging/logger.dart';
import 'package:domain/usecase/wallet_credentials_list/i_wallet_credentials_list_use_case.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:main_app/splash/navigation_handler/splash_navigation_handler.dart';
import 'package:main_app/splash/state/splash_view_state.dart';
import 'package:security_suit/security_suit.dart';
import 'package:shared_dependencies/data_providers/language_data_provider.dart';

class SplashCoordinator extends BaseCoordinator<SplashViewState> {
  final ILanguageDataProvider languageDataProvider;
  final SplashNavigationHandler navigationHandler;
  StreamSubscription? networkSubscription;
  final IWalletCredentialsListUseCase getWalletCredentialsListUseCase;
  Map<String, dynamic> content = {};


  SplashCoordinator({
    required this.languageDataProvider,
    required this.navigationHandler,
    required this.getWalletCredentialsListUseCase,
  }) : super(
          SplashViewState(
            loadingValue: 0,
            isLoading: false,
            isForceUpgradeRequired: false,
            isForceUpgradeSkipped: false,
          ),
        );

  void onSkipPress(){
    state=state.copyWith(isForceUpgradeRequired: false,isForceUpgradeSkipped:true);
  }

  void initialize(bool mockLogin) async {
  }

  void navigateToWalletList()  {
    navigationHandler.navigateToWalletList('');
  }

  void navigateToWalletCredentialExchange()
  {
    navigationHandler.navigateToWalletCredentialExchange();
  }

  void navigateToPreferenceCollection()
  {
    navigationHandler.navigateToPreferenceCollection();
  }

  void navigateToChat()
  {
    navigationHandler.navigateToChat();
  }

  void navigateToCompleteIdentityVerification(bool mode)
  {
    navigationHandler.navigateToCompleteIdentityVerification(mode);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onConfigRetry() async {

  }


  Future<void> onNFCReader() async{
    _showSessionExpiredToast("NFC Reader has been clicked.");
  }


  void _showSessionExpiredToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}
