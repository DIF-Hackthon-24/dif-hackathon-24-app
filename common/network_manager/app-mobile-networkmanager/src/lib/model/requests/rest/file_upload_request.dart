// Dart imports:
// Project imports:
import 'package:core/task/busy_type.dart';
import 'package:network_manager/model/requests/base_request.dart';
import 'package:network_manager/model/response/base_data_model.dart';
import 'package:universal_io/io.dart';

class FileUploadRequest extends BaseRequest {
  final File file;
  Map<String,String>? requestFields;
  BaseDataModel? responseModel;
  FileUploadRequest({
    required this.file,
    required super.name,
    Map<String, dynamic>? variables,
    String endPoint = Constants.graphQLDefaultEndpointName,
    super.additionalHeaders,
    super.showBusy = BusyType.defaultIndicator,
    super.showBusyDelayInMilliseconds = 0,
    super.cachePolicy = CachePolicy.none,
    this.requestFields,
    this.responseModel,
    Map<String,dynamic>? urlValues,
    Map<String, dynamic>? queryParameters,
  }) : super(
      type: RequestType.fileUpload,
      data: null,
      parameters: variables,
      urlValues: urlValues,
      queryParameters: queryParameters
  );
}
