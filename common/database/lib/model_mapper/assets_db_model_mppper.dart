import 'package:drift/drift.dart';
import 'package:database/model/asset_db_model.dart';
import 'package:database/db/wsa_database.dart';


class AssetDbModelMapper {
  static AssetDbModel fromAssetData(AssetData assetData) {
    return AssetDbModel(
      id: assetData.id,
      xCoordinate: assetData.xCoordinate ,
      yCoordinate: assetData.yCoordinate ,
      isPropertyPlot: assetData.isPropertyPlot,
      sysUpdatedAt: assetData.sysUpdateAt ,
      name:  assetData.name,
      description: assetData.assetDescription,
      category: assetData.assetsCategory,
      assetBanner: [],
      assetImages: [],
      assetAnimations: [],
      iconKey: assetData.iconKey
    );
  }

  static toAssetCompanion(AssetDbModel asset) {
    return AssetCompanion(
      id: Value(asset.id),
      name: Value(asset.name),
      assetDescription: Value(asset.description??''),
      assetsCategory: Value(asset.category??''),
      isPropertyPlot: Value(asset.isPropertyPlot),
      xCoordinate: Value(asset.xCoordinate),
      yCoordinate: Value(asset.yCoordinate),
      sysUpdateAt: Value(asset.sysUpdatedAt),
      iconKey: Value(asset.iconKey),
    );
  }
}
