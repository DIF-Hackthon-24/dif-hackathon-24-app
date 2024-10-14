import 'dart:convert';

abstract class IStringToMapConvertor {
  Map<String, dynamic> getMapFromString(String string);
}

class StringToMapConvertorImpl implements IStringToMapConvertor {
  @override
  Map<String, dynamic> getMapFromString(String string) {
    return jsonDecode(string);
  }
}
