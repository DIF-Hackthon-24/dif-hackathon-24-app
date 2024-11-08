import 'package:core/navigation/navigation_manager.dart';
import 'package:shared_dependencies/module_identifiers.dart';
import 'package:shared_dependencies/navigation_handler/no_network_navigation_handler.dart';
import 'package:main_app/route/global_route_manager.dart';

class SplashNavigationHandler extends NoNetworkNavigationHandler {

  SplashNavigationHandler(
    super.languageDataProvider,
    super.stringToMapConvertorImpl,
    super.codeDataProviderImpl,
  );

  void navigateToWalletList(String recipient) async{
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.walletCredentialList}",
      NavigationType.Replace,
      arguments: {'recipient': recipient}
    );
  }

  void navigateToWalletCredentialExchange([String? initialOffer]) async{
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.walletCredentialExchange}",
      NavigationType.Replace,
        arguments: {'initialOffer': initialOffer ?? ''}
    );
  }

  void navigateToCompleteIdentityVerification(bool mode) async{
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.completeIdentityVerification}",
      NavigationType.Dialog,
      arguments: {'mode': mode}

    );
  }

  void navigateToPreferenceCollection() async{
    await NavigationManager.navigateTo(
        "${ModuleIdentifiers.global}-${GlobalRouteManager.preferenceCollection}",
        NavigationType.Replace,
    );
  }

  void navigateToChat() async{
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.chat}",
      NavigationType.Replace,
    );
  }

  void showNoNetworkError() async {
    super.showNoNetworkErrorPopup();
  }

}
