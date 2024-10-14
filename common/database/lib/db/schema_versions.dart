import 'package:drift/internal/versioned_schema.dart' as i0;
import 'package:drift/drift.dart' as i1;
import 'package:drift/drift.dart'; // ignore_for_file: type=lint,unused_import

// GENERATED BY drift_dev, DO NOT MODIFY.
final class Schema2 extends i0.VersionedSchema {
  Schema2({required super.database}) : super(version: 2);
  @override
  late final List<i1.DatabaseSchemaEntity> entities = [
    syncStatusTbl,
    plot,
    asset,
    multimedia,
    media,
    multimediaMapping,
    contentAndConfig,
  ];
  late final Shape0 syncStatusTbl = Shape0(
      source: i0.VersionedTable(
        entityName: 'sync_status_tbl',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY(sync_type)',
        ],
        columns: [
          _column_0,
          _column_1,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape1 plot = Shape1(
      source: i0.VersionedTable(
        entityName: 'plot',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY(id)',
        ],
        columns: [
          _column_2,
          _column_3,
          _column_4,
          _column_5,
          _column_6,
          _column_7,
          _column_8,
          _column_9,
          _column_10,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape2 asset = Shape2(
      source: i0.VersionedTable(
        entityName: 'asset',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'UNIQUE(id, language)',
        ],
        columns: [
          _column_2,
          _column_11,
          _column_4,
          _column_5,
          _column_6,
          _column_12,
          _column_13,
          _column_14,
          _column_10,
          _column_15,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape3 multimedia = Shape3(
      source: i0.VersionedTable(
        entityName: 'multimedia',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY(multimedia_id)',
        ],
        columns: [
          _column_16,
          _column_17,
          _column_18,
          _column_19,
          _column_20,
          _column_21,
          _column_10,
          _column_22,
          _column_23,
          _column_24,
          _column_25,
          _column_26,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape4 media = Shape4(
      source: i0.VersionedTable(
        entityName: 'media',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'UNIQUE(media_id, category_id, sub_category_id, language)',
        ],
        columns: [
          _column_27,
          _column_28,
          _column_29,
          _column_30,
          _column_31,
          _column_32,
          _column_33,
          _column_34,
          _column_35,
          _column_36,
          _column_37,
          _column_10,
          _column_15,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape5 multimediaMapping = Shape5(
      source: i0.VersionedTable(
        entityName: 'multimedia_mapping',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [],
        columns: [
          _column_38,
          _column_39,
          _column_28,
          _column_40,
        ],
        attachedDatabase: database,
      ),
      alias: null);
  late final Shape6 contentAndConfig = Shape6(
      source: i0.VersionedTable(
        entityName: 'content_and_config',
        withoutRowId: false,
        isStrict: false,
        tableConstraints: [
          'PRIMARY KEY("key")',
        ],
        columns: [
          _column_41,
          _column_42,
          _column_43,
        ],
        attachedDatabase: database,
      ),
      alias: null);
}

class Shape0 extends i0.VersionedTable {
  Shape0({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<int> get syncType =>
      columnsByName['sync_type']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<DateTime> get syncedAt =>
      columnsByName['synced_at']! as i1.GeneratedColumn<DateTime>;
}

i1.GeneratedColumn<int> _column_0(String aliasedName) =>
    i1.GeneratedColumn<int>('sync_type', aliasedName, false,
        type: i1.DriftSqlType.int);
i1.GeneratedColumn<DateTime> _column_1(String aliasedName) =>
    i1.GeneratedColumn<DateTime>('synced_at', aliasedName, false,
        type: i1.DriftSqlType.dateTime);

class Shape1 extends i0.VersionedTable {
  Shape1({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<String> get id =>
      columnsByName['id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<bool> get isPlotSold =>
      columnsByName['is_plot_sold']! as i1.GeneratedColumn<bool>;
  i1.GeneratedColumn<bool> get isPropertyPlot =>
      columnsByName['is_property_plot']! as i1.GeneratedColumn<bool>;
  i1.GeneratedColumn<int> get xCoordinate =>
      columnsByName['x_coordinate']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<int> get yCoordinate =>
      columnsByName['y_coordinate']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get plotArea =>
      columnsByName['plot_area']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get plotNumber =>
      columnsByName['plot_number']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get plotCharacteristics =>
      columnsByName['plot_characteristics']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<DateTime> get sysUpdateAt =>
      columnsByName['sys_update_at']! as i1.GeneratedColumn<DateTime>;
}

i1.GeneratedColumn<String> _column_2(String aliasedName) =>
    i1.GeneratedColumn<String>('id', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<bool> _column_3(String aliasedName) =>
    i1.GeneratedColumn<bool>('is_plot_sold', aliasedName, false,
        type: i1.DriftSqlType.bool,
        defaultConstraints: i1.GeneratedColumn.constraintIsAlways(
            'CHECK ("is_plot_sold" IN (0, 1))'));
i1.GeneratedColumn<bool> _column_4(String aliasedName) =>
    i1.GeneratedColumn<bool>('is_property_plot', aliasedName, false,
        type: i1.DriftSqlType.bool,
        defaultConstraints: i1.GeneratedColumn.constraintIsAlways(
            'CHECK ("is_property_plot" IN (0, 1))'));
i1.GeneratedColumn<int> _column_5(String aliasedName) =>
    i1.GeneratedColumn<int>('x_coordinate', aliasedName, false,
        type: i1.DriftSqlType.int);
i1.GeneratedColumn<int> _column_6(String aliasedName) =>
    i1.GeneratedColumn<int>('y_coordinate', aliasedName, false,
        type: i1.DriftSqlType.int);
i1.GeneratedColumn<String> _column_7(String aliasedName) =>
    i1.GeneratedColumn<String>('plot_area', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_8(String aliasedName) =>
    i1.GeneratedColumn<String>('plot_number', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_9(String aliasedName) =>
    i1.GeneratedColumn<String>('plot_characteristics', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<DateTime> _column_10(String aliasedName) =>
    i1.GeneratedColumn<DateTime>('sys_update_at', aliasedName, false,
        type: i1.DriftSqlType.dateTime);

class Shape2 extends i0.VersionedTable {
  Shape2({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<String> get id =>
      columnsByName['id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get assetDescription =>
      columnsByName['asset_description']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<bool> get isPropertyPlot =>
      columnsByName['is_property_plot']! as i1.GeneratedColumn<bool>;
  i1.GeneratedColumn<int> get xCoordinate =>
      columnsByName['x_coordinate']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<int> get yCoordinate =>
      columnsByName['y_coordinate']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get name =>
      columnsByName['name']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get assetsCategory =>
      columnsByName['assets_category']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get iconKey =>
      columnsByName['icon_key']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<DateTime> get sysUpdateAt =>
      columnsByName['sys_update_at']! as i1.GeneratedColumn<DateTime>;
  i1.GeneratedColumn<int> get language =>
      columnsByName['language']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<String> _column_11(String aliasedName) =>
    i1.GeneratedColumn<String>('asset_description', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_12(String aliasedName) =>
    i1.GeneratedColumn<String>('name', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_13(String aliasedName) =>
    i1.GeneratedColumn<String>('assets_category', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_14(String aliasedName) =>
    i1.GeneratedColumn<String>('icon_key', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<int> _column_15(String aliasedName) =>
    i1.GeneratedColumn<int>('language', aliasedName, false,
        type: i1.DriftSqlType.int);

class Shape3 extends i0.VersionedTable {
  Shape3({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<String> get multimediaId =>
      columnsByName['multimedia_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get fileId =>
      columnsByName['file_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get fileName =>
      columnsByName['file_name']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get description =>
      columnsByName['description']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get mimeType =>
      columnsByName['mime_type']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get remotePath =>
      columnsByName['remote_path']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<DateTime> get sysUpdateAt =>
      columnsByName['sys_update_at']! as i1.GeneratedColumn<DateTime>;
  i1.GeneratedColumn<int> get mediaStatus =>
      columnsByName['media_status']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get localFolder =>
      columnsByName['local_folder']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get localFileName =>
      columnsByName['local_file_name']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get downloadTaskId =>
      columnsByName['download_task_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<int> get downloadProgress =>
      columnsByName['download_progress']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<String> _column_16(String aliasedName) =>
    i1.GeneratedColumn<String>('multimedia_id', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_17(String aliasedName) =>
    i1.GeneratedColumn<String>('file_id', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_18(String aliasedName) =>
    i1.GeneratedColumn<String>('file_name', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_19(String aliasedName) =>
    i1.GeneratedColumn<String>('description', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_20(String aliasedName) =>
    i1.GeneratedColumn<String>('mime_type', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_21(String aliasedName) =>
    i1.GeneratedColumn<String>('remote_path', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<int> _column_22(String aliasedName) =>
    i1.GeneratedColumn<int>('media_status', aliasedName, true,
        type: i1.DriftSqlType.int);
i1.GeneratedColumn<String> _column_23(String aliasedName) =>
    i1.GeneratedColumn<String>('local_folder', aliasedName, true,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_24(String aliasedName) =>
    i1.GeneratedColumn<String>('local_file_name', aliasedName, true,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_25(String aliasedName) =>
    i1.GeneratedColumn<String>('download_task_id', aliasedName, true,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<int> _column_26(String aliasedName) =>
    i1.GeneratedColumn<int>('download_progress', aliasedName, true,
        type: i1.DriftSqlType.int);

class Shape4 extends i0.VersionedTable {
  Shape4({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<String> get mediaId =>
      columnsByName['media_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get multimediaId =>
      columnsByName['multimedia_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<int> get mediaOrder =>
      columnsByName['media_order']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get title =>
      columnsByName['title']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get subTitle =>
      columnsByName['sub_title']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get categoryId =>
      columnsByName['category_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get categoryLabel =>
      columnsByName['category_label']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<int> get categoryOrder =>
      columnsByName['category_order']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<String> get subCategoryId =>
      columnsByName['sub_category_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get subCategoryLabel =>
      columnsByName['sub_category_label']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<int> get subCategoryOrder =>
      columnsByName['sub_category_order']! as i1.GeneratedColumn<int>;
  i1.GeneratedColumn<DateTime> get sysUpdateAt =>
      columnsByName['sys_update_at']! as i1.GeneratedColumn<DateTime>;
  i1.GeneratedColumn<int> get language =>
      columnsByName['language']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<String> _column_27(String aliasedName) =>
    i1.GeneratedColumn<String>('media_id', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_28(String aliasedName) =>
    i1.GeneratedColumn<String>('multimedia_id', aliasedName, false,
        type: i1.DriftSqlType.string,
        defaultConstraints: i1.GeneratedColumn.constraintIsAlways(
            'REFERENCES multimedia (multimedia_id)'));
i1.GeneratedColumn<int> _column_29(String aliasedName) =>
    i1.GeneratedColumn<int>('media_order', aliasedName, false,
        type: i1.DriftSqlType.int);
i1.GeneratedColumn<String> _column_30(String aliasedName) =>
    i1.GeneratedColumn<String>('title', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_31(String aliasedName) =>
    i1.GeneratedColumn<String>('sub_title', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_32(String aliasedName) =>
    i1.GeneratedColumn<String>('category_id', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_33(String aliasedName) =>
    i1.GeneratedColumn<String>('category_label', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<int> _column_34(String aliasedName) =>
    i1.GeneratedColumn<int>('category_order', aliasedName, false,
        type: i1.DriftSqlType.int);
i1.GeneratedColumn<String> _column_35(String aliasedName) =>
    i1.GeneratedColumn<String>('sub_category_id', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_36(String aliasedName) =>
    i1.GeneratedColumn<String>('sub_category_label', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<int> _column_37(String aliasedName) =>
    i1.GeneratedColumn<int>('sub_category_order', aliasedName, false,
        type: i1.DriftSqlType.int);

class Shape5 extends i0.VersionedTable {
  Shape5({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<String> get plotId =>
      columnsByName['plot_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get assetId =>
      columnsByName['asset_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get multimediaId =>
      columnsByName['multimedia_id']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<int> get useAs =>
      columnsByName['use_as']! as i1.GeneratedColumn<int>;
}

i1.GeneratedColumn<String> _column_38(String aliasedName) =>
    i1.GeneratedColumn<String>('plot_id', aliasedName, true,
        type: i1.DriftSqlType.string,
        defaultConstraints:
            i1.GeneratedColumn.constraintIsAlways('REFERENCES plot (id)'));
i1.GeneratedColumn<String> _column_39(String aliasedName) =>
    i1.GeneratedColumn<String>('asset_id', aliasedName, true,
        type: i1.DriftSqlType.string,
        defaultConstraints:
            i1.GeneratedColumn.constraintIsAlways('REFERENCES asset (id)'));
i1.GeneratedColumn<int> _column_40(String aliasedName) =>
    i1.GeneratedColumn<int>('use_as', aliasedName, false,
        type: i1.DriftSqlType.int);

class Shape6 extends i0.VersionedTable {
  Shape6({required super.source, required super.alias}) : super.aliased();
  i1.GeneratedColumn<String> get key =>
      columnsByName['key']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get valueEn =>
      columnsByName['value_en']! as i1.GeneratedColumn<String>;
  i1.GeneratedColumn<String> get valueAr =>
      columnsByName['value_ar']! as i1.GeneratedColumn<String>;
}

i1.GeneratedColumn<String> _column_41(String aliasedName) =>
    i1.GeneratedColumn<String>('key', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_42(String aliasedName) =>
    i1.GeneratedColumn<String>('value_en', aliasedName, false,
        type: i1.DriftSqlType.string);
i1.GeneratedColumn<String> _column_43(String aliasedName) =>
    i1.GeneratedColumn<String>('value_ar', aliasedName, false,
        type: i1.DriftSqlType.string);
i0.MigrationStepWithVersion migrationSteps({
  required Future<void> Function(i1.Migrator m, Schema2 schema) from1To2,
}) {
  return (currentVersion, database) async {
    switch (currentVersion) {
      case 1:
        final schema = Schema2(database: database);
        final migrator = i1.Migrator(database, schema);
        await from1To2(migrator, schema);
        return 2;
      default:
        throw ArgumentError.value('Unknown migration from $currentVersion');
    }
  };
}

i1.OnUpgrade stepByStep({
  required Future<void> Function(i1.Migrator m, Schema2 schema) from1To2,
}) =>
    i0.VersionedSchema.stepByStepHelper(
        step: migrationSteps(
      from1To2: from1To2,
    ));
