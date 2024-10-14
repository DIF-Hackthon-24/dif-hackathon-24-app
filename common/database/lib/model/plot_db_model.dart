class PlotDbModel {
  final String id;
  final String plotNumber;
  final String area;
  final int xCoordinate;
  final int yCoordinate;
  final bool isPlotSold;
  final bool isPropertyPlot;
  final bool isPlotUnavailableOrInNegotiation;
  final String? plotCharacteristics;
  final DateTime sysUpdatedAt;
  final List<String> topBanner;
  final List<String> plotImages;
  final List<String> plotVideos;

  PlotDbModel({
    required this.id,
    required this.plotNumber,
    required this.area,
    required this.xCoordinate,
    required this.yCoordinate,
    required this.isPlotSold,
    required this.isPropertyPlot,
    required this.isPlotUnavailableOrInNegotiation,
    required this.plotCharacteristics,
    required this.sysUpdatedAt,
    required this.topBanner,
    required this.plotImages,
    required this.plotVideos,
  });

  PlotDbModel copyWith({
    String? id,
    String? plotNumber,
    String? area,
    int? xCoordinate,
    int? yCoordinate,
    bool? isPlotSold,
    bool? isPropertyPlot,
    bool? isPlotUnavailableOrInNegotiation,
    String? plotCharacteristics,
    DateTime? sysUpdatedAt,
    List<String>? topBanner,
    List<String>? plotImages,
    List<String>? plotVideos,
  }) {
    return PlotDbModel(
      id: id ?? this.id,
      plotNumber: plotNumber ?? this.plotNumber,
      area: area ?? this.area,
      xCoordinate: xCoordinate ?? this.xCoordinate,
      yCoordinate: yCoordinate ?? this.yCoordinate,
      isPlotSold: isPlotSold ?? this.isPlotSold,
      isPropertyPlot: isPropertyPlot ?? this.isPropertyPlot,
      isPlotUnavailableOrInNegotiation: isPlotUnavailableOrInNegotiation ?? this.isPlotUnavailableOrInNegotiation,
      plotCharacteristics: plotCharacteristics ?? this.plotCharacteristics,
      sysUpdatedAt: sysUpdatedAt ?? this.sysUpdatedAt,
      topBanner: topBanner ?? this.topBanner,
      plotImages: plotImages ?? this.plotImages,
      plotVideos: plotVideos ?? this.plotVideos,
    );
  }
}
