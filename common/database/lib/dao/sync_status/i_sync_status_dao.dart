import 'package:database/model/sync_status_db_model.dart';
import 'package:database/types/sync_type.dart';

abstract class ISyncStatusDao {

  Future<void> insertOrUpdateSyncStatus(SyncStatusDbModel status);

  Future<List<SyncStatusDbModel>> fetchAllSyncStatus();

  Future<SyncStatusDbModel?> fetchSyncStatus(SyncType syncType);

  Future<void> clearAllSyncStatus();
}
