import 'package:database/dao/static_content/i_static_content_dao.dart';
import 'package:database/db/wsa_database.dart';
import 'package:database/model/static_content_db_model.dart';
import 'package:database/model_mapper/static_content_db_model_mapper.dart';
import 'package:database/types/content_config_keys.dart';

class StaticContentDao implements IStaticContentDao {
  WSADatabase db;

  StaticContentDao(this.db);

  @override
  void onDispose() {}

  @override
  Future<StaticContentDbModel?> fetchScreenContent(
      {required ContentConfigKeys key}) async {

    var contentAndConfigList = <ContentAndConfigData>[];
    contentAndConfigList = await (db.select(db.contentAndConfig)
          ..where(
            (t) => t.key.equalsValue(key),
          ))
        .get();
    if (contentAndConfigList.isEmpty) {
      return Future.value(null);
    }
    return Future.value(
      StaticContentDbModelMapper.fromContentAndConfigTblData(
        contentAndConfigList.first,
      ),
    );
  }
}
