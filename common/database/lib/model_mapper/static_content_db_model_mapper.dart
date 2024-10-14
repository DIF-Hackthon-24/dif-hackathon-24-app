
import 'package:database/db/wsa_database.dart';
import 'package:database/model/static_content_db_model.dart';
import 'package:drift/drift.dart';

class StaticContentDbModelMapper {
  static StaticContentDbModel fromContentAndConfigTblData(
      ContentAndConfigData contentAndConfigTblData) {
    return StaticContentDbModel(
      key: contentAndConfigTblData.key,
      valueAr: contentAndConfigTblData.valueAr,
      valueEn: contentAndConfigTblData.valueEn,
    );
  }

  static toContentAndConfigTblCompanion(StaticContentDbModel staticContentDbModel) {
    return ContentAndConfigCompanion(
      key: Value(staticContentDbModel.key),
      valueEn: Value(staticContentDbModel.valueEn),
      valueAr: Value(staticContentDbModel.valueAr),
    );
  }
}
