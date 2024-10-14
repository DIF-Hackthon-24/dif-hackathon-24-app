/* import 'package:core/deeplink/deeplink.dart';
import 'package:core/encryption/i_encryption.dart';
import 'package:core/ioc/di_container.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FirebaseDeeplink extends Deeplink {
  @override
  Future<String> createDeepLink(String path, Map<String, dynamic>? value, {bool short = true}) async {
    final packageInfo = await PackageInfo.fromPlatform();
    var packageName = packageInfo.packageName;
    //Todo  Need to mention app id in env file
    //var appStoreId = dotenv.env['APP_STORE_APP_ID']?.replaceAll('id', '');
    //Todo  Need to provide url in PageLink
    var pageLink = dotenv.env['DEEPLINK_URL'] ?? '';
    final encrypter = DIContainer.container.resolve<IEncryption>();
    pageLink = encrypter.decrypt(pageLink);
    var androidMinimumVersion = 0;
    var iosMinimumVersion = 0;
    final parameters = DynamicLinkParameters(
      uriPrefix: pageLink,
      link: Uri(
        scheme: dotenv.env['DEEPLINK_SCHEME'],
        host: dotenv.env['DEEPLINK_HOST'],
        path: '$path',
        queryParameters: value,
      ),
      androidParameters: AndroidParameters(
        packageName: packageName,
        minimumVersion: androidMinimumVersion,
      ),
      iosParameters: IOSParameters(
        bundleId: packageName,

        /// appStoreId: appStoreId, //TODO Need To Provide APP Store ID once available
        minimumVersion: '$iosMinimumVersion',
      ),
    );

    Uri url;
    if (short) {
      final shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await FirebaseDynamicLinks.instance.buildLink(parameters);
    }
    return url.toString();
  }

  @override
  Future<Uri?>? initDeepLinks() async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final deepLink = data?.link;
    return deepLink;
  }

  @override
  void listenToDeepLinks(Function(Uri uri) onDeepLinkCalled) {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      if (dynamicLinkData != null) {
        onDeepLinkCalled(dynamicLinkData.link);
      }
    }).onError((error) {
      // Handle errors
    });
  }
}
 */

//TODO Need to call this method in the specific screen where we need to create deeplink url
/// state.deepLinkUrl = await DIContainer.container<FirebaseDeeplink>().createDeepLink('adha', {'module': ModuleIdentifiers.global, 'screen': 'homeView', 'index': '0'});

//TODO This kind of URL will be created
/// Creating a deeplink
///   var link = await DIContainer.container<FirebaseDeepLink>().createDeepLink('adha',{
///           'module':'ABC',
///           'path': "abc"
///         });
///   http://example.com/adha?module=ABC&path=abc

//TODO Need to call this method where we need to receive deeplink url
/*Future<Uri?> getDeeplink() async {
    var data = await DIContainer.container<FirebaseDeeplink>().initDeepLinks();
    DIContainer.container<FirebaseDeeplink>().listenToDeepLinks((deepLinkUrl) async {
       print("url ${deepLinkUrl}");
      print("quesry ${deepLinkUrl.query}");
       print("path ${deepLinkUrl.path}");
       print("data ${deepLinkUrl.data}");
      print("authority ${deepLinkUrl.authority}");
       print("fragment ${deepLinkUrl.fragment}");
       print("parameters ${deepLinkUrl.queryParameters}");
       print("parameters all ${deepLinkUrl.queryParametersAll}");
       print("parameters 0 ${deepLinkUrl.query[0]}");
       print("parameters 1 ${deepLinkUrl.query[1]}");
       print("parameters 2 ${deepLinkUrl.query[2]}");

       if (deepLinkUrl.query.contains('homeView')) {
         String moduleName = deepLinkUrl.queryParameters['module'] ?? '';
         String screenName = deepLinkUrl.queryParameters['screen'] ?? '';
         String index = deepLinkUrl.queryParameters['index'] ?? '';
         await _navigationHandler.navigateToContact(moduleName, screenName, tabIndex: index);
       }
     });
         return data;
 }*/
