import 'package:core/navigation/navigation_manager.dart';
import 'package:shared_dependencies/module_identifiers.dart';
import 'package:shared_dependencies/navigation_handler/no_network_navigation_handler.dart';
import 'package:main_app/route/global_route_manager.dart';

class WalletCredentialListNavigationHandler extends NoNetworkNavigationHandler {

  WalletCredentialListNavigationHandler(
      super.languageDataProvider,
      super.stringToMapConvertorImpl,
      super.codeDataProviderImpl,
      );

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
