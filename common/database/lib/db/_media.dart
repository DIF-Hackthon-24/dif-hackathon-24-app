part of 'wsa_database.dart';

class Media extends Table {
  TextColumn get mediaId => text()();

  TextColumn get multimediaId => text().references(Multimedia, #multimediaId)();

  IntColumn get mediaOrder => integer()();

  TextColumn get title => text()();

  TextColumn get subTitle => text()();

  TextColumn get categoryId => text()();

  TextColumn get categoryLabel => text()();

  IntColumn get categoryOrder => integer()();

  TextColumn get subCategoryId => text()();

  TextColumn get subCategoryLabel => text()();

  IntColumn get subCategoryOrder => integer()();

  DateTimeColumn get sysUpdateAt => dateTime()();

  IntColumn get language => intEnum<Language>()();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {mediaId, categoryId, subCategoryId, language}
      ];
}
