import 'package:database/model/asset_db_model.dart';
import 'package:database/types/language.dart';

abstract class IAssetDao {
  Future<void> insertAllAssets(Language language, List<AssetDbModel> assets);

  Future<List<AssetDbModel>> fetchAllAssets({Language language});
  Future<List<AssetDbModel>> fetchAssetById({required String id,required Language language});


  Future<void> insertOrUpdateAsset(Language language, AssetDbModel asset);


  Future<void> deleteAllAssets();

  Future<AssetDbModel> getAllAssetMedia(String id, String languageCode);

  void onDispose();
}
