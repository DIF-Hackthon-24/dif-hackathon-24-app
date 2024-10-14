import 'package:database/model/static_content_db_model.dart';
import 'package:database/types/content_config_keys.dart';

abstract class IStaticContentDao {
  void onDispose();

  Future<StaticContentDbModel?> fetchScreenContent({
    required ContentConfigKeys key,
  });

}
