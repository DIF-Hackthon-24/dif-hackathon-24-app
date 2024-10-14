import 'dart:async';

import 'package:core/core.dart';
import 'package:database/dao/multi_media/i_multimedia_dao.dart';
import 'package:database/db/wsa_database.dart';
import 'package:database/model/menu_media_model.dart';
import 'package:database/model/multimedia_db_model.dart';
import 'package:database/model/time_line_media_model.dart';
import 'package:database/model_mapper/multimedia_db_model_mppper.dart';
import 'package:database/types/media_download_status.dart';
import 'package:database/types/multimedia_category.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

class MultimediaDao implements IMultimediaDao {
  WSADatabase db;

  MultimediaDao(this.db);

  StreamController<List<MultimediaDbModel>> streamController =
      StreamController();

  @override
  Future<List<MultimediaDbModel>> getMultimediaListToDownload() async {
    final list = await (db.select(db.multimedia)
          ..where((t) =>
              t.mediaStatus
                  .equalsNullable(MediaDownloadStatus.downloadPending.index) |
              t.mediaStatus
                  .equalsNullable(MediaDownloadStatus.downloadFailed.index) |
              t.mediaStatus
                  .equalsNullable(MediaDownloadStatus.enqueueFailed.index) |
              t.mediaStatus.equalsNullable(null) |
              t.mediaStatus
                  .equalsNullable(MediaDownloadStatus.downloadCancelled.index) |
              t.mediaStatus
                  .equalsNullable(MediaDownloadStatus.undefined.index)))
        .get();
    return Future.value(list
        .map((e) => MultimediaDbModelMapper.fromMultimediaData(e))
        .toList());
  }

  @override
  Future<List<MultimediaDbModel>> getDownloadInProgressAndEnqueue() async { // Using on splash screen
    final list = await (db.select(db.multimedia)
      ..where((t) =>
      t.mediaStatus.equals(MediaDownloadStatus.downloadEnqueued.index) |
      t.mediaStatus.equals(MediaDownloadStatus.downloadRunning.index)))
        .get();
    return Future.value(list
        .map((e) => MultimediaDbModelMapper.fromMultimediaData(e))
        .toList());
  }

  @override
  Future<int> insertMultimedia(MultimediaDbModel image) async {
    MultimediaCompanion entry =
        MultimediaDbModelMapper.toMultimediaCompanion(image);
    return await db.into(db.multimedia).insert(entry);
  }

  @override
  Future<int> updateMultimediaDownloadStatusWithProgress(String taskId,
      int progress, MediaDownloadStatus mediaDownloadStatus) async {
    return await (db.update(db.multimedia)
          ..where((t) => t.downloadTaskId.like('%$taskId%')))
        .write(
      MultimediaCompanion(
          downloadProgress: Value(progress),
          mediaStatus: Value(mediaDownloadStatus)),
    );
  }

  @override
  Future<int> setTaskIdPathAndName(String id, String downloadTaskId,
      MediaDownloadStatus status, String localFolder, String fileName) async {
    return await (db.update(db.multimedia)
          ..where((t) => t.multimediaId.like('%$id%')))
        .write(
      MultimediaCompanion(
        downloadTaskId: Value(downloadTaskId),
        mediaStatus: Value(status),
        localFolder: Value(localFolder),
        localFileName: Value(fileName),
      ),
    );
  }

  @override
  void onDispose() {
    streamController.close();
  }

  @override
  Future<void> insertOrUpdateAllMultimedia(
      List<MultimediaDbModel> images) async {
    List<MultimediaCompanion> multimediaCompanionList = [];
    for (var image in images) {
      multimediaCompanionList.add(
        MultimediaCompanion.insert(
          multimediaId: image.multimediaId,
          fileId: image.fileId,
          fileName: image.filename,
          mimeType: image.mimeType,
          remotePath: image.remotePath,
          sysUpdateAt: image.sysUpdatedAt,
          description: image.description,
        ),
      );
    }
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(db.multimedia, multimediaCompanionList);
    });
  }

  @override
  Future<MultimediaDbModel?> getMultimediaRecordByTaskId(
      {required String taskId}) async {
    final list = await (db.select(db.multimedia)
          ..where((t) => t.downloadTaskId.like('%$taskId%')))
        .get();
    if (list.isNotEmptyOrNull) {
      return Future.value(MultimediaDbModelMapper.fromMultimediaData(list[0]));
    }
    return Future.value(null);
  }

  @override
  Future<List<MultimediaDbModel>> getAllDownloadedMultimedia() async {
    final list = await (db.select(db.multimedia)
          ..where((t) =>
              t.mediaStatus.equals(MediaDownloadStatus.downloadComplete.index)))
        .get();
    return Future.value(list
        .map((e) => MultimediaDbModelMapper.fromMultimediaData(e))
        .toList());
  }

  @override
  Future<List<MultimediaDbModel>> getAllMultimedia() async {
    final list = await (db.select(db.multimedia)).get();
    return Future.value(list
        .map((e) => MultimediaDbModelMapper.fromMultimediaData(e))
        .toList());
  }

  @override
  Future<int> updateMultimediaDownloadStatus(
      String multimediaId, MediaDownloadStatus mediaStatus) async {
    return await (db.update(db.multimedia)
          ..where((t) => t.multimediaId.like('%$multimediaId%')))
        .write(
      MultimediaCompanion(mediaStatus: Value(mediaStatus)),
    );
  }

  @override
  Future<MultimediaDbModel?> getMultimediaRecordByMultimediaId({
    required String multimediaId,
  }) async {
    final list = await (db.select(db.multimedia)
          ..where((t) => t.multimediaId.like(multimediaId)))
        .get();
    if (list.isNotEmptyOrNull) {
      return Future.value(MultimediaDbModelMapper.fromMultimediaData(list.first));
    }
    return Future.value(null);
  }

  @override
  Future<List<MultimediaDbModel>> getMultimediaListToDelete() async {
    final list = await (db.select(db.multimedia)
          ..where((t) => t.mediaStatus
              .equalsNullable(MediaDownloadStatus.deletePending.index)))
        .get();
    return Future.value(list
        .map((e) => MultimediaDbModelMapper.fromMultimediaData(e))
        .toList());
  }

  @override
  Future<void> deleteRecordsForDeletedMultimedia() async {
    await (db.delete(db.multimedia)
          ..where((t) =>
              t.mediaStatus.equals(MediaDownloadStatus.deleteDone.index)))
        .go();
  }

  @override
  Future<MenuMediaModel> getMenuItems() async {
    // Perform a join on multimediaMapping and multimedia tables to get all media related to plotId
    var query = await (db.select(db.multimediaMapping).join([
      leftOuterJoin(
        db.multimedia,
        db.multimediaMapping.multimediaId.equalsExp(db.multimedia.multimediaId),
      ),
    ])).get();

    String externalStorageDirPath = (await getApplicationDocumentsDirectory()).absolute.path;

    // Helper function to generate a list of media file paths based on the multimedia category
    List<String> getMediaPaths(String categoryName) {
    return query
        .where((e) => e
        .readTable(db.multimediaMapping)
        .useAs
        .name
        .equalsIgnoreCase(categoryName))
        .map((e) =>
    "$externalStorageDirPath/${e.readTable(db.multimedia).localFileName ?? ''}")
        .toList();
    }

    // Create a map of media categories to their respective file paths
    MenuMediaModel mediaModel = MenuMediaModel(
      menuMasterPlanEnglish: getMediaPaths(MultimediaCategory.menuMasterPlanEnglish.name).firstOrNull,
      menuMasterPlanArabic: getMediaPaths(MultimediaCategory.menuMasterPlanArabic.name).firstOrNull,
      menuTimelineEnglish: getMediaPaths(MultimediaCategory.menuTimelineEnglish.name).firstOrNull,
      menuTimelineArabic: getMediaPaths(MultimediaCategory.menuTimelineArabic.name).firstOrNull,
      menuMediaEnglish: getMediaPaths(MultimediaCategory.menuMediaEnglish.name).firstOrNull,
      menuMediaArabic: getMediaPaths(MultimediaCategory.menuMediaArabic.name).firstOrNull,
    );

    return mediaModel;
  }
  
  @override
  Future<TimeLineMediaModel> getTimelineImage() async {
    // Perform a join on multimediaMapping and multimedia tables to get all media related to plotId
    var query = await (db.select(db.multimediaMapping).join([
      leftOuterJoin(
        db.multimedia,
        db.multimediaMapping.multimediaId.equalsExp(db.multimedia.multimediaId),
      ),
    ])).get();

    String externalStorageDirPath = (await getApplicationDocumentsDirectory()).absolute.path;

    // Helper function to generate a list of media file paths based on the multimedia category
    List<String> getMediaPaths(String categoryName) {
    return query
        .where((e) => e
        .readTable(db.multimediaMapping)
        .useAs
        .name
        .equalsIgnoreCase(categoryName))
        .map((e) =>
    "$externalStorageDirPath/${e.readTable(db.multimedia).localFileName ?? ''}")
        .toList();
    }

    // Create a map of media categories to their respective file paths
    TimeLineMediaModel mediaModel = TimeLineMediaModel(
      timelineEnglish: getMediaPaths(MultimediaCategory.timelineEnglish.name).firstOrNull,
      timelineArabic: getMediaPaths(MultimediaCategory.timelineArabic.name).firstOrNull,
    );
    return mediaModel;
  }

  await(JoinedSelectStatement<HasResultSet, dynamic> joinedSelectStatement) {}
}
