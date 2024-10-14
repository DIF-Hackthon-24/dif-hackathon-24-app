import 'package:database/model/plot_db_model.dart';
import 'package:database/model/plot_media_model.dart';

abstract class IPlotDao {
  Future<void> insertAllPlots(List<PlotDbModel> plots);

  Future<List<PlotDbModel>> fetchAllPlots();

  Future<void> insertOrUpdatePlot(PlotDbModel plot);

  Future<void> deleteAllPlots();

  void onDispose();

  Future<PlotMediaModel> getAllAPlotMedia(id);
}
