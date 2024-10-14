import 'package:network_manager/model/response/base_data_model.dart';

class PushRegistrationTokenToNotificationHubResponseModel extends BaseDataModel {
  Map<String, dynamic>? response;

  @override
  void fromJsonToModel(Map<String, dynamic> value) {
    response = value;
  }

  @override
  void fromRawHeadersToModel(value) {
    headers = value;
  }
}