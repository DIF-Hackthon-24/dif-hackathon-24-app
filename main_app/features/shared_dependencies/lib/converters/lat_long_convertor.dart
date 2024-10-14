import 'dart:convert';
class _Constants{
  static const latitudeNTextKey = 'adhaLatitudeNText';
  static const latitudeSTextKey = 'adhaLatitudeSText';
  static const longitudeWTextKey = 'adhaLongitudeWText';
  static const longitudeETextKey = 'adhaLongitudeEText';
}

class LatitudeLongitudeConvertor{
  
  String returnCoordinates(
    Map<String,dynamic> dictionaryContent,
    String latitude,
    String longitude,
    bool isRTL,
  ) {
    double lat = jsonDecode(latitude);
    double long = jsonDecode(longitude);

    if (dictionaryContent.isEmpty) {
      return '';
    }
    lat = double.parse(lat.toStringAsFixed(2));
    long = double.parse(long.toStringAsFixed(2));
    final latitudeNText = dictionaryContent[_Constants.latitudeNTextKey] as String? ?? '';
    final latitudeSText = dictionaryContent[_Constants.latitudeSTextKey] as String? ?? '';
    final longitudeEText = dictionaryContent[_Constants.longitudeETextKey] as String? ?? '';
    final longitudeWText = dictionaryContent[_Constants.longitudeWTextKey] as String? ?? '';

    String latText = !lat.isNegative
        ? latitudeNText.split('<>').join(lat.toStringAsFixed(2))
        : latitudeSText.split('<>').join(
              (lat.sign * lat).toString(),
            );

    String longText = (!long.isNegative)
        ? longitudeEText.split('<>').join(long.toStringAsFixed(2))
        : longitudeWText.split('<>').join(
              (long.sign * long).toString(),
            );

    return isRTL ? '$latText، $longText' : '$latText, $longText';
  }

}