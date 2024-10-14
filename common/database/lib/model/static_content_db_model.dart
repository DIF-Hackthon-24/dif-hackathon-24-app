import 'package:database/types/content_config_keys.dart';

class StaticContentDbModel {
  final ContentConfigKeys key;
  final String valueEn;
  final String valueAr;

  StaticContentDbModel({
    required this.key,
    required this.valueEn,
    required this.valueAr,
  });
}
