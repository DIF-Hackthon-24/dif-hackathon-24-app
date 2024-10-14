import 'package:database/dao/content_config/i_content_config_dao.dart';
import 'package:database/db/wsa_database.dart';
import 'package:database/model/content_config_model.dart';
import 'package:database/model_mapper/content_config_mapper.dart';
import 'package:database/types/content_config_keys.dart';

class ContentConfigDao implements IContentConfigDao {
  WSADatabase db;

  ContentConfigDao(this.db);

  @override
  void onDispose() {}

  @override
  Future<void> insertAllContentConfigs({
    required List<ContentConfigDbModel> contextConfigs,
  }) async {
    List<ContentAndConfigCompanion> contextConfigsCompanions = [];
    for (var contentConfig in contextConfigs) {
      contextConfigsCompanions.add(
        ContentAndConfigCompanion.insert(
          key: contentConfig.key,
          valueEn: contentConfig.valueEn,
          valueAr: contentConfig.valueAr,
        ),
      );
    }

    await db.batch((batch) {
      batch.insertAll(db.contentAndConfig, contextConfigsCompanions);
    });
  }

  @override
  Future<void> insertOrUpdateContentConfigs(
    ContentConfigDbModel contextConfig,
  ) async {
    await db.into(db.contentAndConfig).insertOnConflictUpdate(
          ContentAndConfigCompanion.insert(
            key: contextConfig.key,
            valueEn: contextConfig.valueEn,
            valueAr: contextConfig.valueAr,
          ),
        );
  }

  @override
  Future<List<ContentConfigDbModel>> fetchAllContentConfigs() async {
    var contentAndConfigList = <ContentAndConfigData>[];
    contentAndConfigList = await db.select(db.contentAndConfig).get();

    return Future.value(
      contentAndConfigList
          .map((e) => ContentConfigDbModelMapper.fromContentAndConfigTblData(e))
          .toList(),
    );
  }

  @override
  Future<ContentConfigDbModel?> fetchContentConfigs({
    required ContentConfigKeys whereKey,
  }) async {
    var contentAndConfigList = <ContentAndConfigData>[];
    contentAndConfigList = await (db.select(db.contentAndConfig)
          ..where(
            (t) => t.key.equalsValue(whereKey),
          ))
        .get();
    if (contentAndConfigList.isEmpty) {
      return Future.value(null);
    }
    return Future.value(
      ContentConfigDbModelMapper.fromContentAndConfigTblData(
        contentAndConfigList.first,
      ),
    );
  }
}
