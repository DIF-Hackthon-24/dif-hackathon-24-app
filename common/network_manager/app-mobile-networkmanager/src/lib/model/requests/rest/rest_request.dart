// Project imports:
import 'package:core/task/busy_type.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/response/base_data_model.dart';

class RestRequest extends BaseRequest {
  RestRequest({
    required super.type,
    required super.name,
    required BaseDataModel super.data,
    Object? body,
    super.additionalHeaders,
    super.showBusy = BusyType.defaultIndicator,
    super.showBusyDelayInMilliseconds = 0,
    super.cachePolicy = CachePolicy.none,
    Map<String, dynamic>? urlValues,
    Map<String, dynamic>? queryParameters,
  }) : super(queryParameters: queryParameters,parameters: body, urlValues: urlValues);
}
