import 'package:network_manager/model/response/base_data_model.dart';

class TokenRefreshResponseModel extends BaseDataModel {
  Map<String, List<dynamic>>? response;
  Map<String, dynamic>? headers;

  @override
  void fromJsonToModel(Map<String, dynamic> value) {}

  @override
  void fromRawHeadersToModel(value) {
    headers = value as Map<String, dynamic>;
  }
}
