import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/base_classes/base_coordinator.dart';
import 'package:core/logging/logger.dart';
import 'package:domain/usecase/wallet_credentials_list/i_wallet_credentials_list_use_case.dart';
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
    // final secured = await _isDeviceSecure(mockLogin);
    // if (secured || kDebugMode) {
    //   _listenForNetworkChange();
    // } else {
    //   if (networkSubscription != null) {
    //     networkSubscription?.cancel();
    //   }
    // }

  }

  void navigateToWalletList()  {
    navigationHandler.navigateToWalletList();
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


  void _listenForNetworkChange() {
    networkSubscription ??= Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        PSLogger.logDebug(
          '\nSplashCoordinator:############====> Network status change detected === ${result.name}"\n',
        );
      },
      cancelOnError: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onConfigRetry() async {

  }

  void _navigateToNextScreen() {
    if (!state.haveMovedToNextScreen) {
      state = state.copyWith(haveMovedToNextScreen: true, startAnimation: true);
      Future.delayed(const Duration(seconds: 0), () {
      });
    }
  }

  void onLongPressDownloadError() {
    state = state.copyWith(
      showDownloadFailed: false,
      showDownloadFailedDetails: true,
    );
  }

  void onSkipAndContinue() {
    state = state.copyWith(
      showDownloadFailed: false,
      showDownloadFailedDetails: false,
    );
    _navigateToNextScreen();
  }

  Future<bool> _isDeviceSecure(bool mockLogin) async {
    final notSecured = await SecuritySuit.isDeviceNotSecure();
    if (notSecured && !mockLogin) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }



  void upgradeNow() {

  }
}
