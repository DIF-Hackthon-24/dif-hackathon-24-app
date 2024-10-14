import 'package:database/model/asset_media_model.dart';


class AssetMediaModelMapper {
  static AssetMediaModel fromAssetData( {assetBanner,assetImages}) {
    return AssetMediaModel(
      assetBanner: assetBanner ?? [],
      assetImages: assetImages ?? [],
    );
  }
}
