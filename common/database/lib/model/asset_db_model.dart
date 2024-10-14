class AssetDbModel {
  final String id;
  final String name;
  final int xCoordinate;
  final int yCoordinate;
  final bool isPropertyPlot;
  final String? description;
  final String? category;
  final DateTime sysUpdatedAt;
  final List<String> assetBanner;
  final List<String> assetImages;
  final String iconKey;
  final List<String> assetAnimations;

  AssetDbModel({
    required this.id,
    required this.name,
    required this.xCoordinate,
    required this.yCoordinate,
    required this.isPropertyPlot,
    required this.description,
    required this.category,
    required this.sysUpdatedAt,
    required this.assetImages,
    required this.assetBanner,
    required this.iconKey,
    required this.assetAnimations,
  });

  AssetDbModel copyWith({
    String? iconKey,
    String? id,
    String? name,
    int? xCoordinate,
    int? yCoordinate,
    bool? isPropertyPlot,
    String? description,
    String? category,
    DateTime? sysUpdatedAt,
    List<String>? assetBanner,
    List<String>? assetImages,
    List<String>? assetAnimations,

  }) {
    return AssetDbModel(
      iconKey:  iconKey ?? this.iconKey,
      id: id ?? this.id,
      name: name ?? this.name,
      xCoordinate: xCoordinate ?? this.xCoordinate,
      yCoordinate: yCoordinate ?? this.yCoordinate,
      isPropertyPlot: isPropertyPlot ?? this.isPropertyPlot,
      description: description ?? this.description,
      category: category ?? this.category,
      sysUpdatedAt: sysUpdatedAt ?? this.sysUpdatedAt,
      assetBanner: assetBanner ?? this.assetBanner,
      assetImages: assetImages ?? this.assetImages,
      assetAnimations: assetAnimations ?? this.assetAnimations
    );
  }
}
