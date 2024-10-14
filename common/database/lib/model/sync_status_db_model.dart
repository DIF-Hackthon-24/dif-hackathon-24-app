import 'package:database/types/sync_type.dart';

class SyncStatusDbModel {
  final SyncType syncType;
  final DateTime syncedAt;

  SyncStatusDbModel({
    required this.syncType,
    required this.syncedAt,
  });
}
