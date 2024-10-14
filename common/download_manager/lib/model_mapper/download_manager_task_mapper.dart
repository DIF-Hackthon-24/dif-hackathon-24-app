import 'package:download_manager/data/download_manager_task.dart';
import 'package:download_manager/data/download_status.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadManagerTaskMapper {
  static DownloadManagerTask fromDownloadTask(DownloadTask task) {
    return DownloadManagerTask(
      taskId: task.taskId,
      status: task.status.index.enm,
      progress: task.progress,
      url: task.url,
      filename: task.filename ?? '',
      savedDir: task.savedDir,
      timeCreated: DateTime.fromMillisecondsSinceEpoch(task.timeCreated),
      allowCellular: task.allowCellular,
    );
  }
}
