abstract class Deeplink {
  Future<Uri?>? initDeepLinks();

  void listenToDeepLinks(Function(Uri uri) onDeepLinkCalled);

  Future<String> createDeepLink(String path,  Map<String, dynamic /*String|Iterable<String>*/ >? value, {bool short});
}
