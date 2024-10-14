// Project imports:
import 'package:core/task/busy_type.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/response/base_data_model.dart';

class GraphQLRequest extends BaseRequest {
  final String request;

  GraphQLRequest({
    required BaseDataModel super.data,
    required super.type,
    required super.name,
    required this.request,
    Map<String, dynamic>? variables,
    String endPoint = Constants.graphQLDefaultEndpointName,
    super.additionalHeaders,
    super.showBusy = BusyType.defaultIndicator,
    super.showBusyDelayInMilliseconds = 0,
    super.cachePolicy = CachePolicy.none,
    Map<String,dynamic>? urlValues,
    Map<String, dynamic>? queryParameters,
  }) : super(
      parameters: variables,
      urlValues: urlValues,
      queryParameters: queryParameters
  );
}
