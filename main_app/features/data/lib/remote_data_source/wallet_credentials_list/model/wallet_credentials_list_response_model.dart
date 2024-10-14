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