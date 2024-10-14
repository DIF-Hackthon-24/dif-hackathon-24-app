part of 'wsa_database.dart';

class MultimediaMapping extends Table {
  TextColumn get plotId => text().nullable().references(Plot, #id)();

  TextColumn get assetId => text().nullable()();

  TextColumn get multimediaId => text().references(Multimedia, #multimediaId)();

  IntColumn get useAs => intEnum<MultimediaCategory>()();
}
