import 'package:core/task/task_params.dart';
import 'package:network_manager/model/response/base_data_model.dart';
import 'package:universal_io/io.dart';

class FileUploadTaskParams extends TaskParams {
  final String name;
  final File file;
  final Map<String, String> headers;
  final Map<String, dynamic> parameters;
  final Map<String,String> requestFields;
  final BaseDataModel responseDataModel;
  final Map<String,dynamic> urlValues;

  FileUploadTaskParams({
    this.name = 'default',
    required this.file,
    this.headers = const {},
    this.parameters = const {},
    this.requestFields = const {},
    required this.responseDataModel,
    this.urlValues= const {}
  });
}
