import 'package:download_manager/data/download_status.dart';

class DownloadManagerTask {
  DownloadManagerTask({
    required this.taskId,
    required this.status,
    required this.progress,
    required this.url,
    required this.filename,
    required this.savedDir,
    required this.timeCreated,
    required this.allowCellular,
  });

  final String taskId;
  final DownloadStatus status;
  final int progress;
  final String url;
  final String filename;
  final String savedDir;
  final DateTime timeCreated;
  final bool allowCellular;

  @override
  String toString() =>
      'DownloadTask(taskId: $taskId, status: $status, progress: $progress, url: $url, filename: $filename, savedDir: $savedDir, timeCreated: $timeCreated, allowCellular: $allowCellular)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is DownloadManagerTask &&
        other.taskId == taskId &&
        other.status == status &&
        other.progress == progress &&
        other.url == url &&
        other.filename == filename &&
        other.savedDir == savedDir &&
        other.timeCreated == timeCreated &&
        other.allowCellular == allowCellular;
  }

  @override
  int get hashCode {
    return Object.hash(
      taskId,
      status,
      progress,
      url,
      filename,
      savedDir,
      timeCreated,
      allowCellular,
    );
  }
}