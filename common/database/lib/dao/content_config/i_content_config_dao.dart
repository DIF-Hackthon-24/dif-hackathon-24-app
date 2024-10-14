import 'package:database/model/content_config_model.dart';
import 'package:database/types/content_config_keys.dart';

abstract class IContentConfigDao {
  void onDispose();

  Future<void> insertAllContentConfigs({
    required List<ContentConfigDbModel> contextConfigs,
  });

  Future<List<ContentConfigDbModel>> fetchAllContentConfigs();

  Future<ContentConfigDbModel?> fetchContentConfigs({
    required ContentConfigKeys whereKey,
  });

  Future<void> insertOrUpdateContentConfigs(
    ContentConfigDbModel contextConfig,
  );
}
