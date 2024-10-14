import 'package:database/types/content_config_keys.dart';

class ContentConfigDbModel {
  final ContentConfigKeys key;
  final String valueEn;
  final String valueAr;

  ContentConfigDbModel({
    required this.key,
    required this.valueEn,
    required this.valueAr,
  });
}
