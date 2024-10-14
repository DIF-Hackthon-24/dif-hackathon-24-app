import 'package:database/types/multimedia_category.dart';
import 'package:database/types/media_download_status.dart';

class MultimediaDbModel {
  final String multimediaId;
  final String fileId;
  final String remotePath;
  final DateTime sysUpdatedAt;
  final MediaDownloadStatus? mediaStatus;
  final String filename;
  final String description;
  final String mimeType;
  final String localFolder;
  final String localFileName;
  final String taskId;
  final int progress;
  final MultimediaCategory useAs;

  MultimediaDbModel({
    required this.multimediaId,
    required this.fileId,
    required this.remotePath,
    required this.sysUpdatedAt,
    required this.filename,
    required this.mimeType,
    this.description = '',
    this.mediaStatus,
    this.localFolder = '',
    this.localFileName = '',
    this.taskId = '',
    this.progress = 0,
    this.useAs = MultimediaCategory.image,
  });
}
