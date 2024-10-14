import 'package:database/model/media_asset_model.dart';
import 'package:database/model/media_db_model.dart';

import '../../types/language.dart';

abstract class IMediaDao {
  
  Future<List<MediaDbModel>> fetchAllMainCategory(
    Language language,
  );

  Future<List<MediaDbModel>> fetchAllSubCategoriesByMainCategory(
    Language language,
    String categoryId,
  );
  
  Future<List<MediaAssetModel>> fetchAllMediaAssetsBySubCategory(
    Language language,
    String categoryId,
    String subCategoryId,
  );
  
  Future<void> insertOrUpdateMedia(
    Language language,
    String multimediaId,
    MediaDbModel media,
  );

  Future<void> deleteAllMedia();
}
