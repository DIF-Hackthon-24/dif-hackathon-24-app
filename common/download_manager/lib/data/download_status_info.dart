import 'package:download_manager/data/download_status.dart';

class DownloadStatusInfo {
  DownloadStatusInfo({this.taskId, this.status, this.progress});

  String? taskId;
  int? progress = 0;
  DownloadStatus? status = DownloadStatus.undefined;
}
