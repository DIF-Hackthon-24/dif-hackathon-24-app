class MediaDbModel {
  final String mediaId;
  final int mediaOrder;
  final String title;
  final String subTitle;
  final String categoryId;
  final String categoryLabel;
  final int categoryOrder;
  final String subCategoryId;
  final String subCategoryLabel;
  final int subCategoryOrder;
  final DateTime sysUpdatedAt;

  MediaDbModel({
    required this.mediaId,
    required this.mediaOrder,
    required this.title,
    required this.subTitle,
    required this.categoryId,
    required this.categoryLabel,
    required this.categoryOrder,
    required this.subCategoryId,
    required this.subCategoryLabel,
    required this.subCategoryOrder,
    required this.sysUpdatedAt,
  });

  MediaDbModel copyWith({
    String? mediaId,
    String? title,
    String? subTitle,
    String? categoryId,
    String? categoryLabel,
    String? subCategoryId,
    String? subCategoryLabel,
    int? mediaOrder,
    int? categoryOrder,
    int? subCategoryOrder,
    DateTime? sysUpdatedAt,
  }) {
    return MediaDbModel(
      mediaId: mediaId ?? this.mediaId,
      mediaOrder: mediaOrder ?? this.mediaOrder,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      categoryId: categoryId ?? this.categoryId,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      categoryOrder: categoryOrder ?? this.categoryOrder,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryLabel: subCategoryLabel ?? this.subCategoryLabel,
      subCategoryOrder: subCategoryOrder ?? this.subCategoryOrder,
      sysUpdatedAt: sysUpdatedAt ?? this.sysUpdatedAt,
    );
  }
}
