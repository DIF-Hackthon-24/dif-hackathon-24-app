import 'dart:async';

import 'package:core/core.dart';
import 'package:database/dao/plot/i_plot_dao.dart';
import 'package:database/db/wsa_database.dart';
import 'package:database/model/plot_db_model.dart';
import 'package:database/model/plot_media_model.dart';
import 'package:database/model_mapper/plot_db_model_mppaer.dart';
import 'package:database/model_mapper/plot_media_model_mppper.dart';
import 'package:database/types/multimedia_category.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

class PlotDao implements IPlotDao {
  WSADatabase db;

  PlotDao(this.db);

  @override
  Future<void> insertAllPlots(List<PlotDbModel> plots) async {
    List<PlotCompanion> plotCompanions = [];
    for (var plot in plots) {
      plotCompanions.add(PlotCompanion.insert(
        id: plot.id,
        isPlotSold: plot.isPlotSold,
        isPropertyPlot: plot.isPropertyPlot,
        isPlotUnavailableOrInNegotiation:plot.isPlotUnavailableOrInNegotiation,
        xCoordinate: plot.xCoordinate,
        yCoordinate: plot.yCoordinate,
        plotArea: plot.area,
        plotNumber: plot.plotNumber,
        plotCharacteristics: plot.plotCharacteristics ?? '',
        sysUpdateAt: plot.sysUpdatedAt,
      ));
    }

    await db.batch((batch) {
      batch.insertAll(db.plot, plotCompanions);
    });
  }

  @override
  void onDispose() {}

  @override
  Future<void> insertOrUpdatePlot(PlotDbModel plot) async {
    await db.into(db.plot).insertOnConflictUpdate(PlotCompanion.insert(
          id: plot.id,
          isPlotSold: plot.isPlotSold,
          isPropertyPlot: plot.isPropertyPlot,
          isPlotUnavailableOrInNegotiation: plot.isPlotUnavailableOrInNegotiation,
          xCoordinate: plot.xCoordinate,
          yCoordinate: plot.yCoordinate,
          plotArea: plot.area,
          plotNumber: plot.plotNumber,
          plotCharacteristics: plot.plotCharacteristics ?? '',
          sysUpdateAt: plot.sysUpdatedAt,
        ));
  }

  @override
  Future<List<PlotDbModel>> fetchAllPlots() async {
    ///getting the plots list from plot table
    final plotList = await (db.select(db.plot)
      ..where((tbl) => tbl.isPlotUnavailableOrInNegotiation.equals(false) | tbl.isPlotSold.equals(true))).get();

    return Future.value(
        plotList.map((e) => PlotDbModelMapper.fromPlotData(e)).toList());
  }

  /// this method is responsible  to get the media of that plot
  Future<Map<String, List<String>>> _getAllMedia(String plotId) async {
    // Perform a join on multimediaMapping and multimedia tables to get all media related to plotId
    var query = await (db.select(db.multimediaMapping).join([
      leftOuterJoin(db.multimedia, db.multimediaMapping.multimediaId.equalsExp(db.multimedia.multimediaId),),
    ])..where(db.multimediaMapping.plotId.equals(plotId))).get();

    String documentDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;

    // Function to generate a list of media file paths based on the multimedia category
    List<String> getMediaPaths(String categoryName) {
      final result = query.where((e) => e.readTable(db.multimediaMapping).useAs.name.equalsIgnoreCase(categoryName));
      if (result.isEmptyOrNull) {
        return [];
      }
      return result.map((e) => "$documentDirPath/${e.readTableOrNull(db.multimedia)?.localFileName ?? ''}").toList();
    }

    // Create a map of media categories to their respective file paths
    return {
      MultimediaCategory.bannerImage.name: getMediaPaths(MultimediaCategory.bannerImage.name),
      MultimediaCategory.planImage.name: getMediaPaths(MultimediaCategory.planImage.name),
      MultimediaCategory.plotLayoutVideo.name: getMediaPaths(MultimediaCategory.plotLayoutVideo.name),
    };
  }

  @override
  Future<PlotMediaModel> getAllAPlotMedia(id) async {
    Map<String, List<String>> allMedia = await _getAllMedia(id);
    return Future.value(PlotMediaModelMapper.fromPlotData(
        planImages: allMedia[MultimediaCategory.planImage.name],
        topBanner: allMedia[MultimediaCategory.bannerImage.name],
        videos: allMedia[MultimediaCategory.plotLayoutVideo.name]));
  }

  @override
  Future<void> deleteAllPlots() async {
    await db.delete(db.plot).go();
  }
}
