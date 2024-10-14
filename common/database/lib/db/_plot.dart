part of 'wsa_database.dart';

class Plot extends Table {
  TextColumn get id => text()();

  BoolColumn get isPlotSold => boolean()();

  BoolColumn get isPropertyPlot => boolean()();

  BoolColumn get isPlotUnavailableOrInNegotiation => boolean()();

  IntColumn get xCoordinate => integer()();

  IntColumn get yCoordinate => integer()();

  TextColumn get plotArea => text()();

  TextColumn get plotNumber => text()();

  TextColumn get plotCharacteristics => text()();

  DateTimeColumn get sysUpdateAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
