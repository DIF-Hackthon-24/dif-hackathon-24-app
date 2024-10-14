import 'package:core/logging/logger.dart';
import 'package:universal_io/io.dart';
import 'package:url_launcher/url_launcher.dart';

class _Constants {
  static const zoomLevel = 15;
}

class UrlLauncher {
  Future<void> makeCall(String phoneNumber) async {
    var phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    _launchUrl(phoneUri);
  }


  Future<void> launchEmail(String email, {String subject = ''}) async {
    var emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': subject},
    );
    _launchUrl(emailUri);
  }

  Future<void> openGoogleMap(double latitude, double longitude,String placeName) async {
    var googleUrl = getGoogleMapURL(latitude, longitude, placeName);
    Uri? mapURL = Uri.tryParse(googleUrl);
    if (mapURL != null) {
      if (await canLaunchUrl(mapURL)) {
        await launchUrl(
          mapURL,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not open the map.';
      }
    } else {
      throw 'Could not open the map.';
    }
  }
  
  Future<void> openMap(double latitude, double longitude,String placeName) async {
    var googleUrl = getGoogleMapURL(latitude, longitude, placeName);
    var appleUrl = getAppleMapURL(latitude, longitude, placeName);
    if (Platform.isIOS) {
      Uri? mapURL = Uri.tryParse(appleUrl);
      if(mapURL != null ){
        if (await canLaunchUrl(mapURL)) {
          await launchUrl(
            mapURL,
            mode: LaunchMode.externalApplication,
          );
        } else {
          throw 'Could not open the map.';
        }
      } else {
        throw 'Could not open the map.';
      }
    } else {
      Uri? mapURL = Uri.tryParse(googleUrl);
      if (mapURL != null) {
        if (await canLaunchUrl(mapURL)) {
          await launchUrl(
            mapURL,
            mode: LaunchMode.externalApplication,
          );
        } else {
          throw 'Could not open the map.';
        }
      } else {
        throw 'Could not open the map.';
      }
    }
  }

  Future<void> openPlotMap(double latitude, double longitude,) async {
    await openMap(latitude, longitude, '');
  }

  Future<void> launchBrowser(String url) async {
    Uri? uri = Uri.tryParse(url);
    if(uri != null){
      if (await canLaunchUrl(uri)){
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  String getGoogleMapURL(double latitude, double longitude, String? placeName) {
    String googleUrl = 'https://www.google.com/maps/search/?api=1';
    if ((placeName ?? '').trim().isNotEmpty) {
      googleUrl += '&query=$placeName';
    }
    googleUrl += '&query=$latitude,$longitude&zoom=${_Constants.zoomLevel}';
    return googleUrl;
  }

  String getAppleMapURL(double latitude, double longitude, String? placeName) {
    String googleUrl = 'https://maps.apple.com/?';
    if ((placeName ?? '').trim().isNotEmpty) {
      googleUrl += 'q=$placeName';
    }
    googleUrl += '&ll=$latitude,$longitude&z=${_Constants.zoomLevel}';
    return googleUrl;
  }
}

void _launchUrl(Uri uri) async {
  try {
    if (await canLaunchUrl(uri)){
      await launchUrl(uri);
    }
  } catch (errorCode) {
    PSLogger.logDebug(
      'IncorrectMail\nErrorMessage: $errorCode\n******************\n',
    );
  }
}

