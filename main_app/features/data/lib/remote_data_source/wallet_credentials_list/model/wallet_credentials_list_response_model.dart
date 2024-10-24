import 'package:network_manager/model/response/base_data_model.dart';

class WalletCredentialsListResponseModel extends BaseDataModel {
  Map<String, dynamic>? response;

  List<dynamic>? restResponse;

  @override
  void fromJsonToModel(Map<String, dynamic> value) {
    response = value;
  }

  @override
  void fromRawHeadersToModel(value) {
    headers = value;
  }

  @override
  void fromRawResponseToModel(dynamic value) {
    restResponse = value;
  }
}

class WalletCredentialsResolvePresentationResponseModel extends BaseDataModel {
  Map<String, dynamic>? response;

  String? restResponse;

  @override
  void fromJsonToModel(Map<String, dynamic> value) {
    response = value;
  }

  @override
  void fromRawHeadersToModel(value) {
    headers = value;
  }

  @override
  void fromRawResponseToModel(dynamic value) {
    restResponse = value;
  }
}

class WalletCredentialsProcessPresentationResponseModel extends BaseDataModel {
  Map<String, dynamic>? response;

  Map<String, dynamic>? restResponse;

  @override
  void fromJsonToModel(Map<String, dynamic> value) {
    response = value;
  }

  @override
  void fromRawHeadersToModel(value) {
    headers = value;
  }

  @override
  void fromRawResponseToModel(dynamic value) {
    restResponse = value;
  }
}