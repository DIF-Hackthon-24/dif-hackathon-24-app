abstract class IPostLoginNavigationFlow<TokenModel> {
  Future<void> afterSuccessfulLogin(TokenModel result, String email, Map<String, dynamic>? arguments);
  void registerDeviceFlow(String individualId, {bool isAlert = false, Function? showBusyCallback, Function? hideBusyCallback});
}
