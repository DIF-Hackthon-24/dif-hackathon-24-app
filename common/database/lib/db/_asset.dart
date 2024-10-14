part of 'wsa_database.dart';

class Asset extends Table {
  TextColumn get id => text()();

  TextColumn get assetDescription => text()();

  BoolColumn get isPropertyPlot => boolean()();

  IntColumn get xCoordinate => integer()();

  IntColumn get yCoordinate => integer()();

  TextColumn get name => text()();

  TextColumn get assetsCategory => text()();

  TextColumn get iconKey => text()();

  DateTimeColumn get sysUpdateAt => dateTime()();

  IntColumn get language => intEnum<Language>()();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {id, language}
      ];
}
