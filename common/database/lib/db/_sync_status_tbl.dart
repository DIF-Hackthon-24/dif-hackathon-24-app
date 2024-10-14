part of 'wsa_database.dart';

class SyncStatusTbl extends Table {
  IntColumn get syncType => intEnum<SyncType>()();

  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {syncType};
}
