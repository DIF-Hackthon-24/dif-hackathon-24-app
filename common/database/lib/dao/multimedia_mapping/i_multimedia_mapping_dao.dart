import 'package:database/model/multimedia_db_model.dart';

abstract class IMultimediaMappingDao {
  Future<void> removeMappingForPlotId(String plotId);

  Future<void> removeMappingForAssetId(String assetId);

  Future<void> mapPlotAndMultimedia(
      String plotId, List<MultimediaDbModel> images);

  Future<void> mapAssetAndMultimedia(
      String assetId, List<MultimediaDbModel> images);

  Future<void> setMultimediaToUseAs(List<MultimediaDbModel> medias);

  Future<void> removeMultimediaToUseAs(List<MultimediaDbModel> medias);

  Future<bool> isMultimediaMapped(String multimediaId);

  void onDispose();
}
