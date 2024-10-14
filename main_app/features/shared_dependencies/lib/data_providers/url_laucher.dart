import 'package:url_launcher/url_launcher.dart';

abstract class IURLLauncher {
  Future<bool> launchURL(String urlString);
}

class URLLauncherImpl implements IURLLauncher {
  @override
  Future<bool> launchURL(String urlString) async {
    var url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      return true;
    } else {
      return false;
    }
  }
}
