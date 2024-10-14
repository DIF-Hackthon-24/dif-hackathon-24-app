abstract class IDataModel {
  void fromJsonToModel(Map<String, dynamic> value);
  void fromRawResponseToModel(dynamic value);
  void fromRawHeadersToModel(dynamic value);
}

class BaseDataModel implements IDataModel {
  Map<String, dynamic>? headers;

  @override
  void fromJsonToModel(Map<String, dynamic> value) {
    throw UnimplementedError();
  }

  @override
  void fromRawResponseToModel(dynamic value) {
    throw UnimplementedError();
  }

  @override
  void fromRawHeadersToModel(value) {
    throw UnimplementedError();
  }
}
