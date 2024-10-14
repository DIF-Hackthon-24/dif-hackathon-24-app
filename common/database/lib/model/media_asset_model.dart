class MediaAssetModel {
  final String mediaId;
  final String title;
  final String subTitle;
  final int mediaOrder;
  final String multimediaId;
  final String fileId;
  final String fileName;
  final String localFileName;
  final String mimeType;

  MediaAssetModel({
    required this.mediaId,
    required this.title,
    required this.subTitle,
    required this.mediaOrder,
    required this.multimediaId,
    required this.fileId,
    required this.fileName,
    required this.localFileName,
    required this.mimeType,
  });

  MediaAssetModel copyWith({
    String? mediaId,
    String? title,
    String? subTitle,
    int? mediaOrder,
    String? multimediaId,
    String? fileId,
    String? fileName,
    String? localFileName,
    String? mimeType,
  }) {
    return MediaAssetModel(
      mediaId: mediaId ?? this.mediaId,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      mediaOrder: mediaOrder ?? this.mediaOrder,
      multimediaId: multimediaId ?? this.multimediaId,
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      localFileName: localFileName ?? this.localFileName,
      mimeType: mimeType ?? this.mimeType,
    );
  }
}
