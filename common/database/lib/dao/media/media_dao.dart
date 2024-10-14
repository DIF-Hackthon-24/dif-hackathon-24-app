import 'dart:async';

import 'package:database/db/wsa_database.dart';
import 'package:database/model/media_asset_model.dart';
import 'package:database/model/media_db_model.dart';
import 'package:database/model_mapper/media_db_model_mapper.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

import '../../types/language.dart';
import 'i_media_dao.dart';

class MediaDao implements IMediaDao {
  WSADatabase db;

  MediaDao(this.db);

  @override
  Future<void> deleteAllMedia() async {
    await db.delete(db.media).go();
  }

  @override
  Future<List<MediaDbModel>> fetchAllMainCategory(
    Language language,
  ) async {

    final query = '''
          SELECT 
              *  
          FROM  
              ${db.media.actualTableName} 
          WHERE 
              ${db.media.language.name} == ${language.index} 
          GROUP BY 
              ${db.media.categoryId.name}     
          ORDER BY 
              ${db.media.categoryOrder.name} 
      ''';

    final mediaList = await db.customSelect(
      query,
      readsFrom: {db.media},
    ).get();
    return Future.value(
      mediaList.map((e) => MediaDbModelMapper.fromQueryRow(e, db)).toList(),
    );
  }

  @override
  Future<List<MediaDbModel>> fetchAllSubCategoriesByMainCategory(
    Language language,
    String categoryId,
  ) async {

    final query = '''
          SELECT 
              *  
          FROM  
              ${db.media.actualTableName} 
          WHERE 
              ${db.media.language.name} == ${language.index} 
              AND ${db.media.categoryId.name} == "$categoryId"
          GROUP BY 
              ${db.media.subCategoryId.name}  
          ORDER BY 
              ${db.media.subCategoryOrder.name}             
      ''';

    final mediaList = await db.customSelect(
      query,
      readsFrom: {db.media},
    ).get();

    return Future.value(
      mediaList.map((e) => MediaDbModelMapper.fromQueryRow(e, db)).toList(),
    );
  }
  
  @override
  Future<List<MediaAssetModel>> fetchAllMediaAssetsBySubCategory(
    Language language,
    String categoryId,
    String subCategoryId,
  ) async {
    final query = '''
          SELECT 
              ${db.media.actualTableName}.${db.media.mediaId.name},
              ${db.media.actualTableName}.${db.media.title.name},
              ${db.media.actualTableName}.${db.media.subTitle.name},
              ${db.media.actualTableName}.${db.media.mediaOrder.name},
              ${db.media.actualTableName}.${db.media.multimediaId.name},
              ${db.multimedia.actualTableName}.${db.multimedia.fileId.name},
              ${db.multimedia.actualTableName}.${db.multimedia.fileName.name},
              ${db.multimedia.actualTableName}.${db.multimedia.localFileName.name},
              ${db.multimedia.actualTableName}.${db.multimedia.mimeType.name}
          FROM  
              ${db.media.actualTableName}
          INNER JOIN 
              ${db.multimedia.actualTableName} 
              on ${db.multimedia.actualTableName}.${db.multimedia.multimediaId.name} 
              LIKE ${db.media.actualTableName}.${db.media.multimediaId.name}     
          WHERE 
              ${db.media.language.name} == ${language.index} 
              AND ${db.media.categoryId.name} == "$categoryId" 
              AND ${db.media.subCategoryId.name} == "$subCategoryId"
          ORDER BY 
              ${db.media.mediaOrder.name} 
      ''';

    String documentDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;
        
    final mediaList = await db.customSelect(
      query,
      readsFrom: {db.media},
    ).get();
    return Future.value(
      mediaList
          .map(
            (e) => MediaDbModelMapper.fromQueryRowForMediaAssetModel(
              e,
              db,
              documentDirPath,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> insertOrUpdateMedia(
    Language language,
    String multimediaId,
    MediaDbModel media,
  ) async {
    final data = MediaCompanion.insert(
      mediaId: media.mediaId,
      multimediaId: multimediaId,
      mediaOrder: media.mediaOrder,
      title: media.title,
      subTitle: media.subTitle,
      categoryId: media.categoryId,
      categoryLabel: media.categoryLabel,
      categoryOrder: media.categoryOrder,
      subCategoryId: media.subCategoryId,
      subCategoryLabel: media.subCategoryLabel,
      subCategoryOrder: media.subCategoryOrder,
      sysUpdateAt: media.sysUpdatedAt,
      language: language,
    );

    await db.into(db.media).insert(
          data,
          onConflict: DoUpdate(
            (old) => data,
            target: [
              db.media.mediaId,
              db.media.categoryId,
              db.media.subCategoryId,
              db.media.language
            ],
          ),
        );
  }
}
