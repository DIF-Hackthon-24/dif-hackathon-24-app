import 'package:core/navigation/navigation_manager.dart';
import 'package:shared_dependencies/module_identifiers.dart';
import 'package:shared_dependencies/navigation_handler/no_network_navigation_handler.dart';
import 'package:main_app/route/global_route_manager.dart';

class CredentialExchangeNavigationHandler extends NoNetworkNavigationHandler {

  CredentialExchangeNavigationHandler(
      super.languageDataProvider,
      super.stringToMapConvertorImpl,
      super.codeDataProviderImpl,
      );

  void navigateToWalletList() async{
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.walletCredentialList}",
      NavigationType.Replace,

    );
  }

  void navigateToSplash() async{
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.splash}",
      NavigationType.Replace,

    );
  }

  void showNoNetworkError() async {
    super.showNoNetworkErrorPopup();
  }

}
