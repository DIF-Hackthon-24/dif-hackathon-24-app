import 'package:core/core.dart';
import 'package:database/dao/asset/i_asset_dto.dart';
import 'package:database/db/wsa_database.dart';
import 'package:database/model/asset_db_model.dart';
import 'package:database/model_mapper/assets_db_model_mppper.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

import '../../types/language.dart';
import '../../types/multimedia_category.dart';

class AssetDao implements IAssetDao {
  WSADatabase db;

  AssetDao(this.db);

  @override
  Future<void> insertAllAssets(
      Language language, List<AssetDbModel> assets) async {
    List<AssetCompanion> assetCompanions = [];
    for (var asset in assets) {
      assetCompanions.add(AssetCompanion.insert(
          id: asset.id,
          assetDescription: asset.description ?? '',
          isPropertyPlot: asset.isPropertyPlot,
          xCoordinate: asset.xCoordinate,
          yCoordinate: asset.yCoordinate,
          assetsCategory: asset.category ?? '',
          sysUpdateAt: asset.sysUpdatedAt,
          name: asset.name,
          iconKey: asset.iconKey,
          language: language,));
    }

    await db.batch((batch) {
      batch.insertAll(db.asset, assetCompanions);
    });
  }

  @override
  void onDispose() {}

  @override
  Future<List<AssetDbModel>> fetchAllAssets({Language language = Language.english}) async {
    final assetList = await (db.select(db.asset)..where((tbl) => tbl.language.equals(language.index))).get();
    return Future.value(assetList.map((e) => AssetDbModelMapper.fromAssetData(e)).toList());
  }

  @override
  Future<void> insertOrUpdateAsset(
      Language language, AssetDbModel asset) async {
    final data = AssetCompanion.insert(
        id: asset.id,
        assetDescription: asset.description ?? '',
        isPropertyPlot: asset.isPropertyPlot,
        xCoordinate: asset.xCoordinate,
        yCoordinate: asset.yCoordinate,
        assetsCategory: asset.category ?? '',
        sysUpdateAt: asset.sysUpdatedAt,
        name: asset.name,
        iconKey: asset.iconKey,
        language: language);

    await db.into(db.asset).insert(
          data,
          onConflict: DoUpdate((old) => data, target: [db.asset.id, db.asset.language],),
        );
  }

  Future<Map<String, List<String>>> _getAllMedia(String assetId) async {
    // Perform a join on multimediaMapping and multimedia tables to get all media related to plotId
    var query = await (db.select(db.multimediaMapping).join([
      leftOuterJoin(db.multimedia, db.multimediaMapping.multimediaId.equalsExp(db.multimedia.multimediaId),),
    ])..where(db.multimediaMapping.assetId.equals(assetId))).get();

    String externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;

    // Helper function to generate a list of media file paths based on the multimedia category
    List<String> getMediaPaths(String categoryName) {
      return query
          .where((e) => e.readTable(db.multimediaMapping).useAs.name.equalsIgnoreCase(categoryName))
          .map((e) => "$externalStorageDirPath/${e.readTable(db.multimedia).localFileName ?? ''}")
          .toList();
    }

    // Create a map of media categories to their respective file paths
   return {
      MultimediaCategory.bannerImage.name: getMediaPaths(MultimediaCategory.bannerImage.name),
      MultimediaCategory.image.name: getMediaPaths(MultimediaCategory.image.name),
      MultimediaCategory.assetsAnimation.name: getMediaPaths(MultimediaCategory.assetsAnimation.name),
    };
  }

  @override
  Future<AssetDbModel> getAllAssetMedia(id, languageCode) async {
    List<AssetDbModel> assetData = await fetchAssetById(id: id, language: languageCode == "ar" ? Language.arabic : Language.english);
    AssetDbModel asset = assetData.first;
    Map<String, List<String>> allMedia = await _getAllMedia(id);
    return (asset.copyWith(
        assetImages: allMedia[MultimediaCategory.image.name],
        assetBanner: allMedia[MultimediaCategory.bannerImage.name],
        assetAnimations: allMedia[MultimediaCategory.assetsAnimation.name]));
  }

  @override
  Future<void> deleteAllAssets() async {
    await db.delete(db.asset).go();
  }

  @override
  Future<List<AssetDbModel>> fetchAssetById({required String id, required Language language}) async {
    final assetList = await (db.select(db.asset)
          ..where((tbl) => tbl.language.equals(language.index) & tbl.id.equals(id)))
        .get();
    return Future.value(assetList.map((e) => AssetDbModelMapper.fromAssetData(e)).toList());
  }
}
