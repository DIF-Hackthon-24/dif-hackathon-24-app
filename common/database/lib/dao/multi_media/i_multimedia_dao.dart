import 'package:database/model/menu_media_model.dart';
import 'package:database/model/multimedia_db_model.dart';
import 'package:database/model/time_line_media_model.dart';
import 'package:database/types/media_download_status.dart';

abstract class IMultimediaDao {
  Future<void> insertOrUpdateAllMultimedia(List<MultimediaDbModel> modelList);

  Future<List<MultimediaDbModel>> getMultimediaListToDownload();

  Future<List<MultimediaDbModel>> getMultimediaListToDelete();

  Future<void> deleteRecordsForDeletedMultimedia();

  Future<List<MultimediaDbModel>> getAllDownloadedMultimedia();

  Future<List<MultimediaDbModel>> getAllMultimedia();

  Future<List<MultimediaDbModel>> getDownloadInProgressAndEnqueue();

  Future<MultimediaDbModel?> getMultimediaRecordByTaskId(
      {required String taskId});

  Future<int> insertMultimedia(MultimediaDbModel image);

  Future<int> updateMultimediaDownloadStatusWithProgress(
      String taskId, int progress, MediaDownloadStatus mediaDownloadStatus);

  Future<int> updateMultimediaDownloadStatus(
      String multimediaId, MediaDownloadStatus mediaStatus);

  Future<int> setTaskIdPathAndName(String id, String downloadTaskId,
      MediaDownloadStatus status, String localFolder, String fileName);

  Future<MultimediaDbModel?> getMultimediaRecordByMultimediaId({
    required String multimediaId,
  });

  void onDispose();

  Future<MenuMediaModel>getMenuItems();

  Future<TimeLineMediaModel> getTimelineImage();
}
