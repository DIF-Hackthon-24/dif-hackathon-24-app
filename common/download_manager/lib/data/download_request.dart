class DownloadRequest {
  final String url;
  final String fileName;
  final Map<String, String> headers;
  final bool showNotification;
  final bool openFileFromNotification;
  final bool requiresStorageNotLow;
  final bool saveInPublicStorage;
  final bool allowCellular;
  final int timeout;

  DownloadRequest({
    required this.url,
    required this.fileName,
    this.headers = const {'auth': 'test_for_sql_encoding'},
    this.showNotification = true,
    this.openFileFromNotification = true,
    this.requiresStorageNotLow = true,
    this.saveInPublicStorage = false,
    this.allowCellular = true,
    this.timeout = 15000,
  });
}
