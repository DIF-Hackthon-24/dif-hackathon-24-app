import 'package:database/types/media_download_status.dart';

enum DownloadStatus {
  undefined,
  enqueued,
  running,
  complete,
  failed,
  canceled,
  pause,
  enqueueFailed, // Extra status value to represent any error in the download enqueue
}

extension StatusCode on int {
  DownloadStatus get enm {
    switch (this) {
      case 0:
        return DownloadStatus.undefined;
      case 1:
        return DownloadStatus.enqueued;
      case 2:
        return DownloadStatus.running;
      case 3:
        return DownloadStatus.complete;
      case 4:
        return DownloadStatus.failed;
      case 5:
        return DownloadStatus.canceled;
      case 6:
        return DownloadStatus.pause;
      default:
        return DownloadStatus.enqueueFailed;
    }
  }
}

extension StatusCodeDB on DownloadStatus {
  MediaDownloadStatus get enmDb {
    switch (this) {
      case DownloadStatus.undefined:
        return MediaDownloadStatus.undefined;
      case DownloadStatus.enqueued:
        return MediaDownloadStatus.downloadEnqueued;
      case DownloadStatus.running:
        return MediaDownloadStatus.downloadRunning;
      case DownloadStatus.complete:
        return MediaDownloadStatus.downloadComplete;
      case DownloadStatus.failed:
        return MediaDownloadStatus.downloadFailed;
      case DownloadStatus.canceled:
        return MediaDownloadStatus.downloadCancelled;
      case DownloadStatus.pause:
        return MediaDownloadStatus.downloadPaused;
      case DownloadStatus.enqueueFailed:
        return MediaDownloadStatus.enqueueFailed;
      default:
        return MediaDownloadStatus.downloadPending;
    }
  }
}
