import 'package:core/navigation/navigation_manager.dart';
import 'package:shared_dependencies/module_identifiers.dart';
import 'package:shared_dependencies/navigation_handler/no_network_navigation_handler.dart';
import 'package:main_app/route/global_route_manager.dart';

class ChatNavigationHandler extends NoNetworkNavigationHandler {

  ChatNavigationHandler(
      super.languageDataProvider,
      super.stringToMapConvertorImpl,
      super.codeDataProviderImpl,
      );

  void navigateToWalletCredentialExchange(String initialOffer) async{
    print("navigator offer URL: $initialOffer");
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.walletCredentialExchange}",
      NavigationType.Replace,
      arguments: {'initialOffer': initialOffer}

    );
  }

  void navigateToSplash() async {
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.splash}",
      NavigationType.Replace,
    );
  }

  void showNoNetworkError() async {
    super.showNoNetworkErrorPopup();
  }

}
