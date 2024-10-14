import 'package:database/model/plot_db_model.dart';
import 'package:database/db/wsa_database.dart';
import 'package:drift/drift.dart';

class PlotDbModelMapper {
  static PlotDbModel fromPlotData(PlotData plotData) {
    return PlotDbModel(
      id: plotData.id,
      plotNumber: plotData.plotNumber,
      area: plotData.plotArea,
      xCoordinate: plotData.xCoordinate,
      yCoordinate: plotData.yCoordinate,
      isPlotSold: plotData.isPlotSold,
      isPropertyPlot: plotData.isPropertyPlot,
      isPlotUnavailableOrInNegotiation: plotData.isPlotUnavailableOrInNegotiation,
      plotCharacteristics: plotData.plotCharacteristics,
      sysUpdatedAt: plotData.sysUpdateAt,
      plotImages: [],
      topBanner: [],
      plotVideos: [],
    );
  }
  static toPlotCompanion(PlotDbModel plot) {
    return PlotCompanion(
      id: Value(plot.id),
      isPlotSold: Value(plot.isPlotSold),
      isPropertyPlot: Value(plot.isPropertyPlot),
      xCoordinate: Value(plot.xCoordinate),
      yCoordinate: Value(plot.yCoordinate),
      plotArea: Value(plot.area),
      plotNumber: Value(plot.plotNumber),
      plotCharacteristics: Value(plot.plotCharacteristics??''),
      sysUpdateAt: Value(plot.sysUpdatedAt),
    );
  }
}
