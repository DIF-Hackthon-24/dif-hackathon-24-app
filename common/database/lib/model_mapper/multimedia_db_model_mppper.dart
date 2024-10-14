import 'package:database/db/wsa_database.dart';
import 'package:database/model/multimedia_db_model.dart';
import 'package:database/types/media_download_status.dart';
import 'package:drift/drift.dart';

class MultimediaDbModelMapper {
  static MultimediaDbModel fromMultimediaData(MultimediaData data) {
    return MultimediaDbModel(
      multimediaId: data.multimediaId,
      fileId: data.fileId,
      remotePath: data.remotePath,
      sysUpdatedAt: data.sysUpdateAt,
      mediaStatus: data.mediaStatus,
      filename: data.fileName,
      description: data.description,
      mimeType: data.mimeType,
      localFolder: data.localFolder ?? '',
      localFileName: data.localFileName ?? '',
      taskId: data.downloadTaskId ?? '',
      progress: data.downloadProgress ?? MediaDownloadStatus.undefined.index,
    );
  }

  static toMultimediaCompanion(MultimediaDbModel image) {
    return MultimediaCompanion(
      multimediaId: Value(image.multimediaId),
      fileId: Value(image.fileId),
      fileName: Value(image.filename),
      description: Value(image.description),
      mimeType: Value(image.mimeType),
      remotePath: Value(image.remotePath),
      sysUpdateAt: Value(image.sysUpdatedAt),
      mediaStatus: Value(image.mediaStatus ?? MediaDownloadStatus.undefined),
      localFolder: Value(image.localFolder),
      localFileName: Value(image.localFileName),
      downloadTaskId: Value(image.taskId),
      downloadProgress: Value(image.progress),
    );
  }
}
