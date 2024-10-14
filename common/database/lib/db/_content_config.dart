part of 'wsa_database.dart';

class ContentAndConfig extends Table {
  //TextColumn get key => text()();
  TextColumn get key => textEnum<ContentConfigKeys>()();

  TextColumn get valueEn => text()();
  TextColumn get valueAr => text()();

  @override
  Set<Column> get primaryKey => {key};
}
