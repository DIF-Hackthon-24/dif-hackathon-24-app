part of 'wsa_database.dart';


class Multimedia extends Table {
  TextColumn get multimediaId => text()();

  TextColumn get fileId => text()();

  TextColumn get fileName => text()();

  TextColumn get description => text()();

  TextColumn get mimeType => text()();

  TextColumn get remotePath => text()();

  DateTimeColumn get sysUpdateAt => dateTime()();

  IntColumn get mediaStatus => intEnum<MediaDownloadStatus>().nullable()();

  TextColumn get localFolder => text().nullable()();

  TextColumn get localFileName => text().nullable()();

  TextColumn get downloadTaskId => text().nullable()();

  IntColumn get downloadProgress => integer().nullable()();

  @override
  Set<Column> get primaryKey => {multimediaId};
}