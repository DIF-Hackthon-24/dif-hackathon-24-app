import 'package:database/db/wsa_database.dart';
import 'package:database/model/sync_status_db_model.dart';
import 'package:drift/drift.dart';

class SyncStatusDbModelMapper {
  static SyncStatusDbModel fromSyncStatusTblData(SyncStatusTblData syncData) {
    return SyncStatusDbModel(
      syncType: syncData.syncType,
      syncedAt: syncData.syncedAt,
    );
  }

  static SyncStatusTblCompanion toPlotCompanion(SyncStatusDbModel syncModel) {
    return SyncStatusTblCompanion(
      syncType: Value(syncModel.syncType),
      syncedAt: Value(syncModel.syncedAt),
    );
  }
}
