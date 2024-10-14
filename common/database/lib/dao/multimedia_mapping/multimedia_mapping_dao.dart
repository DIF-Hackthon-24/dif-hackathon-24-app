import 'package:core/core.dart';
import 'package:database/dao/multimedia_mapping/i_multimedia_mapping_dao.dart';
import 'package:database/db/wsa_database.dart';
import 'package:database/model/multimedia_db_model.dart';
import 'package:drift/drift.dart';

class MultimediaMappingDao implements IMultimediaMappingDao {
  WSADatabase db;

  MultimediaMappingDao(this.db);

  @override
  void onDispose() {}

  @override
  Future<void> removeMappingForAssetId(String assetId) async {
    await (db.delete(db.multimediaMapping)
          ..where((t) => t.assetId.equals(assetId)))
        .go();
  }

  @override
  Future<void> removeMappingForPlotId(String plotId) async {
    await (db.delete(db.multimediaMapping)
          ..where((t) => t.plotId.equals(plotId)))
        .go();
  }

  @override
  Future<void> mapPlotAndMultimedia(
      String plotId, List<MultimediaDbModel> images) async {
    List<MultimediaMappingCompanion> mappingCompanions = [];
    for (var image in images) {
      mappingCompanions.add(MultimediaMappingCompanion.insert(
        multimediaId: image.multimediaId,
        useAs: image.useAs,
        plotId: Value(plotId),
      ));
    }
    await db.batch((batch) {
      batch.insertAll(db.multimediaMapping, mappingCompanions);
    });
  }

  @override
  Future<void> mapAssetAndMultimedia(
      String assetId, List<MultimediaDbModel> images) async {
    List<MultimediaMappingCompanion> mappingCompanions = [];
    for (var image in images) {
      mappingCompanions.add(MultimediaMappingCompanion.insert(
        multimediaId: image.multimediaId,
        useAs: image.useAs,
        assetId: Value(assetId),
      ));
    }
    await db.batch((batch) {
      batch.insertAll(db.multimediaMapping, mappingCompanions);
    });
  }

  @override
  Future<bool> isMultimediaMapped(String multimediaId) async {
    bool mappedInMultimediaMappingTable = true;
    bool mappedInMediaTable = true;

    final list = await (db.select(db.multimediaMapping)
          ..where(
            (t) => (t.multimediaId.like('%$multimediaId%')),
          ))
        .get();
    if (list.isEmptyOrNull) {
      mappedInMultimediaMappingTable = false;
    }

    final mediaList = await (db.select(db.media)
          ..where(
            (t) => (t.multimediaId.like('%$multimediaId%')),
          ))
        .get();
    if (mediaList.isEmptyOrNull) {
      mappedInMediaTable = false;
    }

    return Future.value(mappedInMultimediaMappingTable || mappedInMediaTable);
  }

  @override
  Future<void> setMultimediaToUseAs(List<MultimediaDbModel> medias) async {
    List<MultimediaMappingCompanion> mappingCompanions = [];
    for (var media in medias) {
      mappingCompanions.add(MultimediaMappingCompanion.insert(
        multimediaId: media.multimediaId,
        useAs: media.useAs,
      ));
    }
    await db.batch((batch) {
      batch.insertAll(db.multimediaMapping, mappingCompanions);
    });
  }

  @override
  Future<void> removeMultimediaToUseAs(List<MultimediaDbModel> medias) async {
    for (var media in medias) {
      await (db.delete(db.multimediaMapping)
            ..where((t) => t.useAs.equals(media.useAs.index)))
          .go();
    }
  }
}
