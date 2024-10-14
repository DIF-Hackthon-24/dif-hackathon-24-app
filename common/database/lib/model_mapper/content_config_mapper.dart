import 'package:database/model/content_config_model.dart';
import 'package:database/db/wsa_database.dart';
import 'package:drift/drift.dart';

class ContentConfigDbModelMapper {
  static ContentConfigDbModel fromContentAndConfigTblData(
      ContentAndConfigData contentAndConfigTblData) {
    return ContentConfigDbModel(
      key: contentAndConfigTblData.key,
      valueAr: contentAndConfigTblData.valueAr,
      valueEn: contentAndConfigTblData.valueEn,
    );
  }

  static toContentAndConfigTblCompanion(ContentConfigDbModel configDbModel) {
    return ContentAndConfigCompanion(
      key: Value(configDbModel.key),
      valueEn: Value(configDbModel.valueEn),
      valueAr: Value(configDbModel.valueAr),
    );
  }
}
