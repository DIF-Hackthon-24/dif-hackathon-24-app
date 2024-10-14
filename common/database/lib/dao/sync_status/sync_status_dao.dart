import 'package:database/dao/sync_status/i_sync_status_dao.dart';
import 'package:database/db/wsa_database.dart';
import 'package:database/model/sync_status_db_model.dart';
import 'package:database/model_mapper/sync_status_db_model_mapper.dart';
import 'package:database/types/sync_type.dart';
import 'package:drift/drift.dart';

class SyncStatusDao implements ISyncStatusDao {
  WSADatabase db;

  SyncStatusDao(this.db);

  @override
  Future<void> clearAllSyncStatus() async {
    await (db.delete(db.syncStatusTbl)).go();
  }

  @override
  Future<List<SyncStatusDbModel>> fetchAllSyncStatus() async {
    final statusList = await db.select(db.syncStatusTbl).get();
    return Future.value(statusList
        .map((e) => SyncStatusDbModelMapper.fromSyncStatusTblData(e))
        .toList());
  }

  @override
  Future<SyncStatusDbModel?> fetchSyncStatus(SyncType syncType) async {
    final statusList = await (db.select(db.syncStatusTbl)
          ..where((t) => t.syncType.equals(syncType.index)))
        .get();
    if (statusList.isEmpty) {
      return null;
    }
    return Future.value(
        SyncStatusDbModelMapper.fromSyncStatusTblData(statusList[0]));
  }

  @override
  Future<void> insertOrUpdateSyncStatus(SyncStatusDbModel status) async {
    await db
        .into(db.syncStatusTbl)
        .insertOnConflictUpdate(SyncStatusTblCompanion.insert(
          syncedAt: status.syncedAt,
          syncType: Value(status.syncType),
        ));
  }
}
