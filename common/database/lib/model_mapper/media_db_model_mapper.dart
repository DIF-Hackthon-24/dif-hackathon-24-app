import 'package:database/db/wsa_database.dart';
import 'package:database/model/media_asset_model.dart';
import 'package:database/model/media_db_model.dart';
import 'package:drift/drift.dart';

class MediaDbModelMapper {

  static MediaDbModel fromQueryRow(
    QueryRow queryRow,
    WSADatabase db,
  ) {
    return MediaDbModel(
      mediaId: queryRow.read<String?>(db.media.mediaId.name) ?? '',
      mediaOrder: queryRow.read<int?>(db.media.mediaOrder.name) ?? 0,
      title: queryRow.read<String?>(db.media.title.name) ?? '',
      subTitle: queryRow.read<String?>(db.media.subTitle.name) ?? '',
      categoryId: queryRow.read<String?>(db.media.categoryId.name) ?? '',
      categoryLabel: queryRow.read<String?>(db.media.categoryLabel.name) ?? '',
      categoryOrder: queryRow.read<int?>(db.media.categoryOrder.name) ?? 0,
      subCategoryId: queryRow.read<String?>(db.media.subCategoryId.name) ?? '',
      subCategoryLabel:
          queryRow.read<String?>(db.media.subCategoryLabel.name) ?? '',
      subCategoryOrder:
          queryRow.read<int?>(db.media.subCategoryOrder.name) ?? 0,
      sysUpdatedAt:
          queryRow.read<DateTime?>(db.media.sysUpdateAt.name) ?? DateTime.now(),
    );
  }

  static MediaAssetModel fromQueryRowForMediaAssetModel(
      QueryRow queryRow, WSADatabase db, String documentDirPath) {
    return MediaAssetModel(
      mediaId: queryRow.read<String?>(db.media.mediaId.name) ?? '',
      mediaOrder: queryRow.read<int?>(db.media.mediaOrder.name) ?? 0,
      title: queryRow.read<String?>(db.media.title.name) ?? '',
      subTitle: queryRow.read<String?>(db.media.subTitle.name) ?? '',
      multimediaId: queryRow.read<String?>(db.media.multimediaId.name) ?? '',
      fileId: queryRow.read<String?>(db.multimedia.fileId.name) ?? '',
      fileName: queryRow.read<String?>(db.multimedia.fileName.name) ?? '',
      localFileName:
          '$documentDirPath/${queryRow.read<String?>(db.multimedia.localFileName.name) ?? ''}',
      mimeType: queryRow.read<String?>(db.multimedia.mimeType.name) ?? '',
    );
  }

  static MediaDbModel fromMediaData(MediaData data) {
    return MediaDbModel(
      mediaId: data.mediaId,
      mediaOrder: data.mediaOrder,
      title: data.title,
      subTitle: data.subTitle,
      categoryId: data.categoryId,
      categoryLabel: data.categoryLabel,
      categoryOrder: data.categoryOrder,
      subCategoryId: data.subCategoryId,
      subCategoryLabel: data.subCategoryLabel,
      subCategoryOrder: data.subCategoryOrder,
      sysUpdatedAt: data.sysUpdateAt,
    );
  }

  static toMediaCompanion(MediaDbModel model) {
    return MediaCompanion(
      mediaId: Value(model.mediaId),
      mediaOrder: Value(model.mediaOrder),
      title: Value(model.title),
      subTitle: Value(model.subTitle),
      categoryId: Value(model.categoryId),
      categoryLabel: Value(model.categoryLabel),
      categoryOrder: Value(model.categoryOrder),
      subCategoryId: Value(model.subCategoryId),
      subCategoryLabel: Value(model.subCategoryLabel),
      subCategoryOrder: Value(model.subCategoryOrder),
      sysUpdateAt: Value(model.sysUpdatedAt),
    );
  }
}
