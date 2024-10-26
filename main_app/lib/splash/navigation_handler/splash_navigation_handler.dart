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

  void navigateToWalletList() async{
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.walletCredentialList}",
      NavigationType.Replace,

    );
  }

  void navigateToWalletCredentialExchange() async{
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.walletCredentialExchange}",
      NavigationType.Replace,

    );
  }
  void navigateToPermissionRequest() async {
    await NavigationManager.navigateTo(
      "${ModuleIdentifiers.global}-${GlobalRouteManager.permissionRequest}",
      NavigationType.Replace,
    );
  }

  void showNoNetworkError() async {
    super.showNoNetworkErrorPopup();
  }

}
