import 'package:database/model/plot_media_model.dart';


class PlotMediaModelMapper {
  static PlotMediaModel fromPlotData( {topBanner,planImages,videos}) {
    return PlotMediaModel( topBanner: topBanner ?? [], planImages: planImages ?? [], videos: videos ?? [],
    );
  }
}
