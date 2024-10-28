import 'package:core/navigation/i_route_manager.dart';
import 'package:main_app/splash/screen/splash_view.dart';
import 'package:presentation/credential_exchange/view/wallet_credentials_offer_request_view.dart';
import 'package:presentation/wallet_credentials_list/view/wallet_credentials_list_view.dart';
import 'package:flutter/material.dart';

class GlobalRouteManager extends IRouteManager {
  static const splash = 'splash';
  static const mockedLogin = 'mocked_login';
  static const walletCredentialList = 'wallet_credential_list';
  static const walletCredentialExchange = 'wallet_credential_exchange';
  static const completeIdentityVerification = 'complete_identity_verification';

  @override
  Widget getView(RouteSettings settings) {
    switch (settings.name) {
      case GlobalRouteManager.splash:
        return const SplashView();
      case GlobalRouteManager.walletCredentialList:
        return const WalletCredentialsListView();
      case GlobalRouteManager.walletCredentialExchange:
        return const WalletCredentialsOfferRequestView(mode: false,);

      default:
        throw Exception('Not implemented');
    }
  }

  @override
  Widget getBottomSheet(String bottomSheetName, arguments) {
    // final theme = PSTheme().themeFor(arguments['themeName'] as String? ?? bottomSheetName);
    switch (bottomSheetName) {
      case GlobalRouteManager.mockedLogin:
      default:
        throw Exception('Route ${arguments.number} not found');
    }
  }

  @override
  Widget getDialog(String dialogName, arguments) {
    // return super.getDialog(dialogName, arguments);
    switch (dialogName) {
      case GlobalRouteManager.completeIdentityVerification:
        return Material(
          color: Colors.transparent,
          child: WalletCredentialsOfferRequestView(
              mode: arguments['mode'] as bool),
        );
      default:
        throw Exception('Route ${arguments.number} not found');
    }
  }
}
