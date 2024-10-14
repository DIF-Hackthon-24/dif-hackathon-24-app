library database;

import 'dart:io';

import 'package:core/encryption/i_encryption.dart';
import 'package:core/ioc/di_container.dart';
import 'package:database/types/content_config_keys.dart';
import 'package:database/types/media_download_status.dart';
import 'package:database/types/multimedia_category.dart';
import 'package:database/types/sync_type.dart';
import 'package:drift/drift.dart';
import 'package:drift/internal/versioned_schema.dart';
import 'package:encrypted_drift/encrypted_drift.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../types/language.dart';
import 'schema_versions.dart';

part '_asset.dart';
part '_content_config.dart';
part '_media.dart';
part '_multimedia.dart';
part '_multimedia_mapping.dart';
part '_plot.dart';
part '_sync_status_tbl.dart';
part 'wsa_database.g.dart';

class _Constants {
  static const dbName = '3BU06Iwbn85CSdiPY/15RA==';
  static const encryptedCred = '/CYR3ssLkMRzQdm7NM5Odcz/iUXbOr/8IEkjC3YtN0E=';
}

@DriftDatabase(
  tables: [
    SyncStatusTbl,
    Plot,
    Asset,
    Media,
    Multimedia,
    MultimediaMapping,
    ContentAndConfig,
  ],
)
class WSADatabase extends _$WSADatabase {
  WSADatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        /// Run migration steps without foreign keys and re-enable them later
        await customStatement('PRAGMA foreign_keys = OFF');
        await transaction(
          () => VersionedSchema.runMigrationSteps(
            migrator: m,
            from: from,
            to: to,
            steps: migrationSteps(
              /// From version 1 to 2
              from1To2: (Migrator m, Schema2 schema) async {
                /// Write version 2 changes here
                // Migrate asset table
                await customStatement(
                    '''CREATE TABLE "new_${schema.asset.actualTableName}" ("id" TEXT NOT NULL, "asset_description" TEXT NOT NULL, "is_property_plot" INTEGER NOT NULL CHECK ("is_property_plot" IN (0, 1)), "x_coordinate" INTEGER NOT NULL, "y_coordinate" INTEGER NOT NULL, "name" TEXT NOT NULL, "assets_category" TEXT NOT NULL, "icon_key" TEXT NOT NULL, "sys_update_at" INTEGER NOT NULL, "language" INTEGER NOT NULL, UNIQUE ("id", "language"))''');
                // Copy data from old table to new table.
                await customStatement(
                    '''INSERT INTO new_${schema.asset.actualTableName} (id, asset_description , is_property_plot , x_coordinate , y_coordinate , name , assets_category , icon_key , sys_update_at,language) SELECT  id, asset_description , is_property_plot , x_coordinate , y_coordinate , name , assets_category , icon_key , sys_update_at , 0  from ${schema.asset.actualTableName}''');
                // Drop old table
                await customStatement(
                    '''DROP TABLE ${schema.asset.actualTableName}''');
                // Rename new table as old to replace the old one.
                await customStatement(
                    '''ALTER TABLE new_${schema.asset.actualTableName} RENAME TO ${schema.asset.actualTableName}''');

                // Migrate plot table
                await customStatement(
                    '''CREATE TABLE new_${schema.plot.actualTableName} ("id" TEXT NOT NULL, "is_plot_sold" INTEGER NOT NULL CHECK ("is_plot_sold" IN (0, 1)), "is_property_plot" INTEGER NOT NULL CHECK ("is_property_plot" IN (0, 1)), "is_plot_unavailable_or_in_negotiation" INTEGER NOT NULL CHECK ("is_plot_unavailable_or_in_negotiation" IN (0, 1)), "x_coordinate" INTEGER NOT NULL, "y_coordinate" INTEGER NOT NULL, "plot_area" TEXT NOT NULL, "plot_number" TEXT NOT NULL, "plot_characteristics" TEXT NOT NULL, "sys_update_at" INTEGER NOT NULL, PRIMARY KEY ("id"))''');
                // Copy data from old table to new table.
                await customStatement(
                    '''INSERT INTO new_${schema.plot.actualTableName} (id, is_plot_sold , is_property_plot , is_property_plot , is_plot_unavailable_or_in_negotiation ,x_coordinate,y_coordinate ,plot_area,plot_number,plot_characteristics,sys_update_at) SELECT  id, is_plot_sold , is_property_plot , is_property_plot , false ,x_coordinate,y_coordinate ,plot_area,plot_number,plot_characteristics,sys_update_at  from ${schema.plot.actualTableName}''');
                // Drop old table
                await customStatement(
                    '''DROP TABLE ${schema.plot.actualTableName}''');
                // Rename new table as old to replace the old one.
                await customStatement(
                    '''ALTER TABLE new_${schema.plot.actualTableName} RENAME TO ${schema.plot.actualTableName}''');

                // Update multimedia_mapping table constraints.
                // Create a temp table to hold data
                await customStatement(
                    '''CREATE TABLE "new_${schema.multimediaMapping.actualTableName}" ("plot_id" TEXT NULL REFERENCES plot (id), "asset_id" TEXT NULL , "multimedia_id" TEXT NOT NULL REFERENCES multimedia (multimedia_id), "use_as" INTEGER NOT NULL)''');
                // Copy data from old table to new table.
                await customStatement(
                    '''INSERT INTO new_${schema.multimediaMapping.actualTableName} (plot_id, asset_id , multimedia_id , use_as )SELECT  plot_id, asset_id , multimedia_id , use_as from ${schema.multimediaMapping.actualTableName}''');
                // Drop old table
                await customStatement(
                    '''DROP TABLE ${schema.multimediaMapping.actualTableName}''');
                // Rename new table as old to replace the old one.
                await customStatement(
                    '''ALTER TABLE new_${schema.multimediaMapping.actualTableName} RENAME TO ${schema.multimediaMapping.actualTableName}''');

                // Create Media table
                await m.createTable(schema.media);
              },
            ),
          ),
        );

        if (kDebugMode) {
          final wrongForeignKeys =
              await customSelect('PRAGMA foreign_key_check').get();
          assert(wrongForeignKeys.isEmpty,
              '${wrongForeignKeys.map((e) => e.data)}');
        }
      },
    );
  }
}

QueryExecutor _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(
    () async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      final encrypter = DIContainer.container.resolve<IEncryption>();
      final dbName = encrypter.decrypt(_Constants.dbName);
      final file = File(p.join(dbFolder.path, dbName));
      final password = encrypter.decrypt(_Constants.encryptedCred);
      if (kDebugMode) {
        debugPrint('##### DB Path : ${dbFolder.path}/$dbName');
        debugPrint('##### password : $password');
      }

      return EncryptedExecutor.inDatabaseFolder(
        path: file.path,
        password: password,
        creator: (file) async {},
      );
    },
  );
}
