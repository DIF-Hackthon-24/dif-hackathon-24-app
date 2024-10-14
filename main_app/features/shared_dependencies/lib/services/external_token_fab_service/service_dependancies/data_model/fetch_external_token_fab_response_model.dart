import 'package:network_manager/model/response/base_data_model.dart';

class OssTokenForFabResponseModel extends BaseDataModel {
  Map<String, dynamic>? response;
  Data? data;

  @override
  void fromJsonToModel(Map<String, dynamic> value) {
    response = value;
  }

  @override
  void fromRawHeadersToModel(value) {
    headers = value;
  }
}
class Data {
  CreateExternalAPIToken? createExternalAPIToken;

  Data({this.createExternalAPIToken});

  Data.fromJson(Map<String, dynamic> json) {
    createExternalAPIToken = json['createExternalAPIToken'] != null
        ? new CreateExternalAPIToken.fromJson(json['createExternalAPIToken'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.createExternalAPIToken != null) {
      data['createExternalAPIToken'] = this.createExternalAPIToken!.toJson();
    }
    return data;
  }
}

class CreateExternalAPIToken {
  String? ossToken;

  CreateExternalAPIToken({this.ossToken});

  CreateExternalAPIToken.fromJson(Map<String, dynamic> json) {
    ossToken = json['ossToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ossToken'] = this.ossToken;
    return data;
  }
}

