import 'package:core/task/task_params.dart';

class FileDownloadTaskParams extends TaskParams {
  String url;
  String savePath;
  Map<String,dynamic>? queryParams;
  Map<String,dynamic>? headers;
  FileDownloadTaskParams({
    required this.url,
    required this.savePath,
    this.queryParams,
    this.headers,
  });
}
