// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wsa_database.dart';

// ignore_for_file: type=lint
class $SyncStatusTblTable extends SyncStatusTbl
    with TableInfo<$SyncStatusTblTable, SyncStatusTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStatusTblTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _syncTypeMeta =
      const VerificationMeta('syncType');
  @override
  late final GeneratedColumnWithTypeConverter<SyncType, int> syncType =
      GeneratedColumn<int>('sync_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<SyncType>($SyncStatusTblTable.$convertersyncType);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [syncType, syncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_status_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<SyncStatusTblData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_syncTypeMeta, const VerificationResult.success());
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {syncType};
  @override
  SyncStatusTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStatusTblData(
      syncType: $SyncStatusTblTable.$convertersyncType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_type'])!),
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at'])!,
    );
  }

  @override
  $SyncStatusTblTable createAlias(String alias) {
    return $SyncStatusTblTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncType, int, int> $convertersyncType =
      const EnumIndexConverter<SyncType>(SyncType.values);
}

class SyncStatusTblData extends DataClass
    implements Insertable<SyncStatusTblData> {
  final SyncType syncType;
  final DateTime syncedAt;
  const SyncStatusTblData({required this.syncType, required this.syncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['sync_type'] =
          Variable<int>($SyncStatusTblTable.$convertersyncType.toSql(syncType));
    }
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  SyncStatusTblCompanion toCompanion(bool nullToAbsent) {
    return SyncStatusTblCompanion(
      syncType: Value(syncType),
      syncedAt: Value(syncedAt),
    );
  }

  factory SyncStatusTblData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStatusTblData(
      syncType: $SyncStatusTblTable.$convertersyncType
          .fromJson(serializer.fromJson<int>(json['syncType'])),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'syncType': serializer
          .toJson<int>($SyncStatusTblTable.$convertersyncType.toJson(syncType)),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  SyncStatusTblData copyWith({SyncType? syncType, DateTime? syncedAt}) =>
      SyncStatusTblData(
        syncType: syncType ?? this.syncType,
        syncedAt: syncedAt ?? this.syncedAt,
      );
  SyncStatusTblData copyWithCompanion(SyncStatusTblCompanion data) {
    return SyncStatusTblData(
      syncType: data.syncType.present ? data.syncType.value : this.syncType,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatusTblData(')
          ..write('syncType: $syncType, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(syncType, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStatusTblData &&
          other.syncType == this.syncType &&
          other.syncedAt == this.syncedAt);
}

class SyncStatusTblCompanion extends UpdateCompanion<SyncStatusTblData> {
  final Value<SyncType> syncType;
  final Value<DateTime> syncedAt;
  const SyncStatusTblCompanion({
    this.syncType = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  SyncStatusTblCompanion.insert({
    this.syncType = const Value.absent(),
    required DateTime syncedAt,
  }) : syncedAt = Value(syncedAt);
  static Insertable<SyncStatusTblData> custom({
    Expression<int>? syncType,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (syncType != null) 'sync_type': syncType,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  SyncStatusTblCompanion copyWith(
      {Value<SyncType>? syncType, Value<DateTime>? syncedAt}) {
    return SyncStatusTblCompanion(
      syncType: syncType ?? this.syncType,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (syncType.present) {
      map['sync_type'] = Variable<int>(
          $SyncStatusTblTable.$convertersyncType.toSql(syncType.value));
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatusTblCompanion(')
          ..write('syncType: $syncType, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $PlotTable extends Plot with TableInfo<$PlotTable, PlotData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlotTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPlotSoldMeta =
      const VerificationMeta('isPlotSold');
  @override
  late final GeneratedColumn<bool> isPlotSold = GeneratedColumn<bool>(
      'is_plot_sold', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_plot_sold" IN (0, 1))'));
  static const VerificationMeta _isPropertyPlotMeta =
      const VerificationMeta('isPropertyPlot');
  @override
  late final GeneratedColumn<bool> isPropertyPlot = GeneratedColumn<bool>(
      'is_property_plot', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_property_plot" IN (0, 1))'));
  static const VerificationMeta _isPlotUnavailableOrInNegotiationMeta =
      const VerificationMeta('isPlotUnavailableOrInNegotiation');
  @override
  late final GeneratedColumn<bool> isPlotUnavailableOrInNegotiation =
      GeneratedColumn<bool>(
          'is_plot_unavailable_or_in_negotiation', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("is_plot_unavailable_or_in_negotiation" IN (0, 1))'));
  static const VerificationMeta _xCoordinateMeta =
      const VerificationMeta('xCoordinate');
  @override
  late final GeneratedColumn<int> xCoordinate = GeneratedColumn<int>(
      'x_coordinate', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yCoordinateMeta =
      const VerificationMeta('yCoordinate');
  @override
  late final GeneratedColumn<int> yCoordinate = GeneratedColumn<int>(
      'y_coordinate', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _plotAreaMeta =
      const VerificationMeta('plotArea');
  @override
  late final GeneratedColumn<String> plotArea = GeneratedColumn<String>(
      'plot_area', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _plotNumberMeta =
      const VerificationMeta('plotNumber');
  @override
  late final GeneratedColumn<String> plotNumber = GeneratedColumn<String>(
      'plot_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _plotCharacteristicsMeta =
      const VerificationMeta('plotCharacteristics');
  @override
  late final GeneratedColumn<String> plotCharacteristics =
      GeneratedColumn<String>('plot_characteristics', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sysUpdateAtMeta =
      const VerificationMeta('sysUpdateAt');
  @override
  late final GeneratedColumn<DateTime> sysUpdateAt = GeneratedColumn<DateTime>(
      'sys_update_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        isPlotSold,
        isPropertyPlot,
        isPlotUnavailableOrInNegotiation,
        xCoordinate,
        yCoordinate,
        plotArea,
        plotNumber,
        plotCharacteristics,
        sysUpdateAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plot';
  @override
  VerificationContext validateIntegrity(Insertable<PlotData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('is_plot_sold')) {
      context.handle(
          _isPlotSoldMeta,
          isPlotSold.isAcceptableOrUnknown(
              data['is_plot_sold']!, _isPlotSoldMeta));
    } else if (isInserting) {
      context.missing(_isPlotSoldMeta);
    }
    if (data.containsKey('is_property_plot')) {
      context.handle(
          _isPropertyPlotMeta,
          isPropertyPlot.isAcceptableOrUnknown(
              data['is_property_plot']!, _isPropertyPlotMeta));
    } else if (isInserting) {
      context.missing(_isPropertyPlotMeta);
    }
    if (data.containsKey('is_plot_unavailable_or_in_negotiation')) {
      context.handle(
          _isPlotUnavailableOrInNegotiationMeta,
          isPlotUnavailableOrInNegotiation.isAcceptableOrUnknown(
              data['is_plot_unavailable_or_in_negotiation']!,
              _isPlotUnavailableOrInNegotiationMeta));
    } else if (isInserting) {
      context.missing(_isPlotUnavailableOrInNegotiationMeta);
    }
    if (data.containsKey('x_coordinate')) {
      context.handle(
          _xCoordinateMeta,
          xCoordinate.isAcceptableOrUnknown(
              data['x_coordinate']!, _xCoordinateMeta));
    } else if (isInserting) {
      context.missing(_xCoordinateMeta);
    }
    if (data.containsKey('y_coordinate')) {
      context.handle(
          _yCoordinateMeta,
          yCoordinate.isAcceptableOrUnknown(
              data['y_coordinate']!, _yCoordinateMeta));
    } else if (isInserting) {
      context.missing(_yCoordinateMeta);
    }
    if (data.containsKey('plot_area')) {
      context.handle(_plotAreaMeta,
          plotArea.isAcceptableOrUnknown(data['plot_area']!, _plotAreaMeta));
    } else if (isInserting) {
      context.missing(_plotAreaMeta);
    }
    if (data.containsKey('plot_number')) {
      context.handle(
          _plotNumberMeta,
          plotNumber.isAcceptableOrUnknown(
              data['plot_number']!, _plotNumberMeta));
    } else if (isInserting) {
      context.missing(_plotNumberMeta);
    }
    if (data.containsKey('plot_characteristics')) {
      context.handle(
          _plotCharacteristicsMeta,
          plotCharacteristics.isAcceptableOrUnknown(
              data['plot_characteristics']!, _plotCharacteristicsMeta));
    } else if (isInserting) {
      context.missing(_plotCharacteristicsMeta);
    }
    if (data.containsKey('sys_update_at')) {
      context.handle(
          _sysUpdateAtMeta,
          sysUpdateAt.isAcceptableOrUnknown(
              data['sys_update_at']!, _sysUpdateAtMeta));
    } else if (isInserting) {
      context.missing(_sysUpdateAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlotData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlotData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      isPlotSold: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_plot_sold'])!,
      isPropertyPlot: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_property_plot'])!,
      isPlotUnavailableOrInNegotiation: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}is_plot_unavailable_or_in_negotiation'])!,
      xCoordinate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}x_coordinate'])!,
      yCoordinate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}y_coordinate'])!,
      plotArea: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plot_area'])!,
      plotNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plot_number'])!,
      plotCharacteristics: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}plot_characteristics'])!,
      sysUpdateAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}sys_update_at'])!,
    );
  }

  @override
  $PlotTable createAlias(String alias) {
    return $PlotTable(attachedDatabase, alias);
  }
}

class PlotData extends DataClass implements Insertable<PlotData> {
  final String id;
  final bool isPlotSold;
  final bool isPropertyPlot;
  final bool isPlotUnavailableOrInNegotiation;
  final int xCoordinate;
  final int yCoordinate;
  final String plotArea;
  final String plotNumber;
  final String plotCharacteristics;
  final DateTime sysUpdateAt;
  const PlotData(
      {required this.id,
      required this.isPlotSold,
      required this.isPropertyPlot,
      required this.isPlotUnavailableOrInNegotiation,
      required this.xCoordinate,
      required this.yCoordinate,
      required this.plotArea,
      required this.plotNumber,
      required this.plotCharacteristics,
      required this.sysUpdateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['is_plot_sold'] = Variable<bool>(isPlotSold);
    map['is_property_plot'] = Variable<bool>(isPropertyPlot);
    map['is_plot_unavailable_or_in_negotiation'] =
        Variable<bool>(isPlotUnavailableOrInNegotiation);
    map['x_coordinate'] = Variable<int>(xCoordinate);
    map['y_coordinate'] = Variable<int>(yCoordinate);
    map['plot_area'] = Variable<String>(plotArea);
    map['plot_number'] = Variable<String>(plotNumber);
    map['plot_characteristics'] = Variable<String>(plotCharacteristics);
    map['sys_update_at'] = Variable<DateTime>(sysUpdateAt);
    return map;
  }

  PlotCompanion toCompanion(bool nullToAbsent) {
    return PlotCompanion(
      id: Value(id),
      isPlotSold: Value(isPlotSold),
      isPropertyPlot: Value(isPropertyPlot),
      isPlotUnavailableOrInNegotiation: Value(isPlotUnavailableOrInNegotiation),
      xCoordinate: Value(xCoordinate),
      yCoordinate: Value(yCoordinate),
      plotArea: Value(plotArea),
      plotNumber: Value(plotNumber),
      plotCharacteristics: Value(plotCharacteristics),
      sysUpdateAt: Value(sysUpdateAt),
    );
  }

  factory PlotData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlotData(
      id: serializer.fromJson<String>(json['id']),
      isPlotSold: serializer.fromJson<bool>(json['isPlotSold']),
      isPropertyPlot: serializer.fromJson<bool>(json['isPropertyPlot']),
      isPlotUnavailableOrInNegotiation:
          serializer.fromJson<bool>(json['isPlotUnavailableOrInNegotiation']),
      xCoordinate: serializer.fromJson<int>(json['xCoordinate']),
      yCoordinate: serializer.fromJson<int>(json['yCoordinate']),
      plotArea: serializer.fromJson<String>(json['plotArea']),
      plotNumber: serializer.fromJson<String>(json['plotNumber']),
      plotCharacteristics:
          serializer.fromJson<String>(json['plotCharacteristics']),
      sysUpdateAt: serializer.fromJson<DateTime>(json['sysUpdateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'isPlotSold': serializer.toJson<bool>(isPlotSold),
      'isPropertyPlot': serializer.toJson<bool>(isPropertyPlot),
      'isPlotUnavailableOrInNegotiation':
          serializer.toJson<bool>(isPlotUnavailableOrInNegotiation),
      'xCoordinate': serializer.toJson<int>(xCoordinate),
      'yCoordinate': serializer.toJson<int>(yCoordinate),
      'plotArea': serializer.toJson<String>(plotArea),
      'plotNumber': serializer.toJson<String>(plotNumber),
      'plotCharacteristics': serializer.toJson<String>(plotCharacteristics),
      'sysUpdateAt': serializer.toJson<DateTime>(sysUpdateAt),
    };
  }

  PlotData copyWith(
          {String? id,
          bool? isPlotSold,
          bool? isPropertyPlot,
          bool? isPlotUnavailableOrInNegotiation,
          int? xCoordinate,
          int? yCoordinate,
          String? plotArea,
          String? plotNumber,
          String? plotCharacteristics,
          DateTime? sysUpdateAt}) =>
      PlotData(
        id: id ?? this.id,
        isPlotSold: isPlotSold ?? this.isPlotSold,
        isPropertyPlot: isPropertyPlot ?? this.isPropertyPlot,
        isPlotUnavailableOrInNegotiation: isPlotUnavailableOrInNegotiation ??
            this.isPlotUnavailableOrInNegotiation,
        xCoordinate: xCoordinate ?? this.xCoordinate,
        yCoordinate: yCoordinate ?? this.yCoordinate,
        plotArea: plotArea ?? this.plotArea,
        plotNumber: plotNumber ?? this.plotNumber,
        plotCharacteristics: plotCharacteristics ?? this.plotCharacteristics,
        sysUpdateAt: sysUpdateAt ?? this.sysUpdateAt,
      );
  PlotData copyWithCompanion(PlotCompanion data) {
    return PlotData(
      id: data.id.present ? data.id.value : this.id,
      isPlotSold:
          data.isPlotSold.present ? data.isPlotSold.value : this.isPlotSold,
      isPropertyPlot: data.isPropertyPlot.present
          ? data.isPropertyPlot.value
          : this.isPropertyPlot,
      isPlotUnavailableOrInNegotiation:
          data.isPlotUnavailableOrInNegotiation.present
              ? data.isPlotUnavailableOrInNegotiation.value
              : this.isPlotUnavailableOrInNegotiation,
      xCoordinate:
          data.xCoordinate.present ? data.xCoordinate.value : this.xCoordinate,
      yCoordinate:
          data.yCoordinate.present ? data.yCoordinate.value : this.yCoordinate,
      plotArea: data.plotArea.present ? data.plotArea.value : this.plotArea,
      plotNumber:
          data.plotNumber.present ? data.plotNumber.value : this.plotNumber,
      plotCharacteristics: data.plotCharacteristics.present
          ? data.plotCharacteristics.value
          : this.plotCharacteristics,
      sysUpdateAt:
          data.sysUpdateAt.present ? data.sysUpdateAt.value : this.sysUpdateAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlotData(')
          ..write('id: $id, ')
          ..write('isPlotSold: $isPlotSold, ')
          ..write('isPropertyPlot: $isPropertyPlot, ')
          ..write(
              'isPlotUnavailableOrInNegotiation: $isPlotUnavailableOrInNegotiation, ')
          ..write('xCoordinate: $xCoordinate, ')
          ..write('yCoordinate: $yCoordinate, ')
          ..write('plotArea: $plotArea, ')
          ..write('plotNumber: $plotNumber, ')
          ..write('plotCharacteristics: $plotCharacteristics, ')
          ..write('sysUpdateAt: $sysUpdateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      isPlotSold,
      isPropertyPlot,
      isPlotUnavailableOrInNegotiation,
      xCoordinate,
      yCoordinate,
      plotArea,
      plotNumber,
      plotCharacteristics,
      sysUpdateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlotData &&
          other.id == this.id &&
          other.isPlotSold == this.isPlotSold &&
          other.isPropertyPlot == this.isPropertyPlot &&
          other.isPlotUnavailableOrInNegotiation ==
              this.isPlotUnavailableOrInNegotiation &&
          other.xCoordinate == this.xCoordinate &&
          other.yCoordinate == this.yCoordinate &&
          other.plotArea == this.plotArea &&
          other.plotNumber == this.plotNumber &&
          other.plotCharacteristics == this.plotCharacteristics &&
          other.sysUpdateAt == this.sysUpdateAt);
}

class PlotCompanion extends UpdateCompanion<PlotData> {
  final Value<String> id;
  final Value<bool> isPlotSold;
  final Value<bool> isPropertyPlot;
  final Value<bool> isPlotUnavailableOrInNegotiation;
  final Value<int> xCoordinate;
  final Value<int> yCoordinate;
  final Value<String> plotArea;
  final Value<String> plotNumber;
  final Value<String> plotCharacteristics;
  final Value<DateTime> sysUpdateAt;
  final Value<int> rowid;
  const PlotCompanion({
    this.id = const Value.absent(),
    this.isPlotSold = const Value.absent(),
    this.isPropertyPlot = const Value.absent(),
    this.isPlotUnavailableOrInNegotiation = const Value.absent(),
    this.xCoordinate = const Value.absent(),
    this.yCoordinate = const Value.absent(),
    this.plotArea = const Value.absent(),
    this.plotNumber = const Value.absent(),
    this.plotCharacteristics = const Value.absent(),
    this.sysUpdateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlotCompanion.insert({
    required String id,
    required bool isPlotSold,
    required bool isPropertyPlot,
    required bool isPlotUnavailableOrInNegotiation,
    required int xCoordinate,
    required int yCoordinate,
    required String plotArea,
    required String plotNumber,
    required String plotCharacteristics,
    required DateTime sysUpdateAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        isPlotSold = Value(isPlotSold),
        isPropertyPlot = Value(isPropertyPlot),
        isPlotUnavailableOrInNegotiation =
            Value(isPlotUnavailableOrInNegotiation),
        xCoordinate = Value(xCoordinate),
        yCoordinate = Value(yCoordinate),
        plotArea = Value(plotArea),
        plotNumber = Value(plotNumber),
        plotCharacteristics = Value(plotCharacteristics),
        sysUpdateAt = Value(sysUpdateAt);
  static Insertable<PlotData> custom({
    Expression<String>? id,
    Expression<bool>? isPlotSold,
    Expression<bool>? isPropertyPlot,
    Expression<bool>? isPlotUnavailableOrInNegotiation,
    Expression<int>? xCoordinate,
    Expression<int>? yCoordinate,
    Expression<String>? plotArea,
    Expression<String>? plotNumber,
    Expression<String>? plotCharacteristics,
    Expression<DateTime>? sysUpdateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isPlotSold != null) 'is_plot_sold': isPlotSold,
      if (isPropertyPlot != null) 'is_property_plot': isPropertyPlot,
      if (isPlotUnavailableOrInNegotiation != null)
        'is_plot_unavailable_or_in_negotiation':
            isPlotUnavailableOrInNegotiation,
      if (xCoordinate != null) 'x_coordinate': xCoordinate,
      if (yCoordinate != null) 'y_coordinate': yCoordinate,
      if (plotArea != null) 'plot_area': plotArea,
      if (plotNumber != null) 'plot_number': plotNumber,
      if (plotCharacteristics != null)
        'plot_characteristics': plotCharacteristics,
      if (sysUpdateAt != null) 'sys_update_at': sysUpdateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlotCompanion copyWith(
      {Value<String>? id,
      Value<bool>? isPlotSold,
      Value<bool>? isPropertyPlot,
      Value<bool>? isPlotUnavailableOrInNegotiation,
      Value<int>? xCoordinate,
      Value<int>? yCoordinate,
      Value<String>? plotArea,
      Value<String>? plotNumber,
      Value<String>? plotCharacteristics,
      Value<DateTime>? sysUpdateAt,
      Value<int>? rowid}) {
    return PlotCompanion(
      id: id ?? this.id,
      isPlotSold: isPlotSold ?? this.isPlotSold,
      isPropertyPlot: isPropertyPlot ?? this.isPropertyPlot,
      isPlotUnavailableOrInNegotiation: isPlotUnavailableOrInNegotiation ??
          this.isPlotUnavailableOrInNegotiation,
      xCoordinate: xCoordinate ?? this.xCoordinate,
      yCoordinate: yCoordinate ?? this.yCoordinate,
      plotArea: plotArea ?? this.plotArea,
      plotNumber: plotNumber ?? this.plotNumber,
      plotCharacteristics: plotCharacteristics ?? this.plotCharacteristics,
      sysUpdateAt: sysUpdateAt ?? this.sysUpdateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (isPlotSold.present) {
      map['is_plot_sold'] = Variable<bool>(isPlotSold.value);
    }
    if (isPropertyPlot.present) {
      map['is_property_plot'] = Variable<bool>(isPropertyPlot.value);
    }
    if (isPlotUnavailableOrInNegotiation.present) {
      map['is_plot_unavailable_or_in_negotiation'] =
          Variable<bool>(isPlotUnavailableOrInNegotiation.value);
    }
    if (xCoordinate.present) {
      map['x_coordinate'] = Variable<int>(xCoordinate.value);
    }
    if (yCoordinate.present) {
      map['y_coordinate'] = Variable<int>(yCoordinate.value);
    }
    if (plotArea.present) {
      map['plot_area'] = Variable<String>(plotArea.value);
    }
    if (plotNumber.present) {
      map['plot_number'] = Variable<String>(plotNumber.value);
    }
    if (plotCharacteristics.present) {
      map['plot_characteristics'] = Variable<String>(plotCharacteristics.value);
    }
    if (sysUpdateAt.present) {
      map['sys_update_at'] = Variable<DateTime>(sysUpdateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlotCompanion(')
          ..write('id: $id, ')
          ..write('isPlotSold: $isPlotSold, ')
          ..write('isPropertyPlot: $isPropertyPlot, ')
          ..write(
              'isPlotUnavailableOrInNegotiation: $isPlotUnavailableOrInNegotiation, ')
          ..write('xCoordinate: $xCoordinate, ')
          ..write('yCoordinate: $yCoordinate, ')
          ..write('plotArea: $plotArea, ')
          ..write('plotNumber: $plotNumber, ')
          ..write('plotCharacteristics: $plotCharacteristics, ')
          ..write('sysUpdateAt: $sysUpdateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetTable extends Asset with TableInfo<$AssetTable, AssetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetDescriptionMeta =
      const VerificationMeta('assetDescription');
  @override
  late final GeneratedColumn<String> assetDescription = GeneratedColumn<String>(
      'asset_description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPropertyPlotMeta =
      const VerificationMeta('isPropertyPlot');
  @override
  late final GeneratedColumn<bool> isPropertyPlot = GeneratedColumn<bool>(
      'is_property_plot', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_property_plot" IN (0, 1))'));
  static const VerificationMeta _xCoordinateMeta =
      const VerificationMeta('xCoordinate');
  @override
  late final GeneratedColumn<int> xCoordinate = GeneratedColumn<int>(
      'x_coordinate', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yCoordinateMeta =
      const VerificationMeta('yCoordinate');
  @override
  late final GeneratedColumn<int> yCoordinate = GeneratedColumn<int>(
      'y_coordinate', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetsCategoryMeta =
      const VerificationMeta('assetsCategory');
  @override
  late final GeneratedColumn<String> assetsCategory = GeneratedColumn<String>(
      'assets_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconKeyMeta =
      const VerificationMeta('iconKey');
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
      'icon_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sysUpdateAtMeta =
      const VerificationMeta('sysUpdateAt');
  @override
  late final GeneratedColumn<DateTime> sysUpdateAt = GeneratedColumn<DateTime>(
      'sys_update_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumnWithTypeConverter<Language, int> language =
      GeneratedColumn<int>('language', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Language>($AssetTable.$converterlanguage);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        assetDescription,
        isPropertyPlot,
        xCoordinate,
        yCoordinate,
        name,
        assetsCategory,
        iconKey,
        sysUpdateAt,
        language
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'asset';
  @override
  VerificationContext validateIntegrity(Insertable<AssetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('asset_description')) {
      context.handle(
          _assetDescriptionMeta,
          assetDescription.isAcceptableOrUnknown(
              data['asset_description']!, _assetDescriptionMeta));
    } else if (isInserting) {
      context.missing(_assetDescriptionMeta);
    }
    if (data.containsKey('is_property_plot')) {
      context.handle(
          _isPropertyPlotMeta,
          isPropertyPlot.isAcceptableOrUnknown(
              data['is_property_plot']!, _isPropertyPlotMeta));
    } else if (isInserting) {
      context.missing(_isPropertyPlotMeta);
    }
    if (data.containsKey('x_coordinate')) {
      context.handle(
          _xCoordinateMeta,
          xCoordinate.isAcceptableOrUnknown(
              data['x_coordinate']!, _xCoordinateMeta));
    } else if (isInserting) {
      context.missing(_xCoordinateMeta);
    }
    if (data.containsKey('y_coordinate')) {
      context.handle(
          _yCoordinateMeta,
          yCoordinate.isAcceptableOrUnknown(
              data['y_coordinate']!, _yCoordinateMeta));
    } else if (isInserting) {
      context.missing(_yCoordinateMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('assets_category')) {
      context.handle(
          _assetsCategoryMeta,
          assetsCategory.isAcceptableOrUnknown(
              data['assets_category']!, _assetsCategoryMeta));
    } else if (isInserting) {
      context.missing(_assetsCategoryMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(_iconKeyMeta,
          iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta));
    } else if (isInserting) {
      context.missing(_iconKeyMeta);
    }
    if (data.containsKey('sys_update_at')) {
      context.handle(
          _sysUpdateAtMeta,
          sysUpdateAt.isAcceptableOrUnknown(
              data['sys_update_at']!, _sysUpdateAtMeta));
    } else if (isInserting) {
      context.missing(_sysUpdateAtMeta);
    }
    context.handle(_languageMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {id, language},
      ];
  @override
  AssetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      assetDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}asset_description'])!,
      isPropertyPlot: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_property_plot'])!,
      xCoordinate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}x_coordinate'])!,
      yCoordinate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}y_coordinate'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      assetsCategory: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}assets_category'])!,
      iconKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_key'])!,
      sysUpdateAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}sys_update_at'])!,
      language: $AssetTable.$converterlanguage.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}language'])!),
    );
  }

  @override
  $AssetTable createAlias(String alias) {
    return $AssetTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Language, int, int> $converterlanguage =
      const EnumIndexConverter<Language>(Language.values);
}

class AssetData extends DataClass implements Insertable<AssetData> {
  final String id;
  final String assetDescription;
  final bool isPropertyPlot;
  final int xCoordinate;
  final int yCoordinate;
  final String name;
  final String assetsCategory;
  final String iconKey;
  final DateTime sysUpdateAt;
  final Language language;
  const AssetData(
      {required this.id,
      required this.assetDescription,
      required this.isPropertyPlot,
      required this.xCoordinate,
      required this.yCoordinate,
      required this.name,
      required this.assetsCategory,
      required this.iconKey,
      required this.sysUpdateAt,
      required this.language});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['asset_description'] = Variable<String>(assetDescription);
    map['is_property_plot'] = Variable<bool>(isPropertyPlot);
    map['x_coordinate'] = Variable<int>(xCoordinate);
    map['y_coordinate'] = Variable<int>(yCoordinate);
    map['name'] = Variable<String>(name);
    map['assets_category'] = Variable<String>(assetsCategory);
    map['icon_key'] = Variable<String>(iconKey);
    map['sys_update_at'] = Variable<DateTime>(sysUpdateAt);
    {
      map['language'] =
          Variable<int>($AssetTable.$converterlanguage.toSql(language));
    }
    return map;
  }

  AssetCompanion toCompanion(bool nullToAbsent) {
    return AssetCompanion(
      id: Value(id),
      assetDescription: Value(assetDescription),
      isPropertyPlot: Value(isPropertyPlot),
      xCoordinate: Value(xCoordinate),
      yCoordinate: Value(yCoordinate),
      name: Value(name),
      assetsCategory: Value(assetsCategory),
      iconKey: Value(iconKey),
      sysUpdateAt: Value(sysUpdateAt),
      language: Value(language),
    );
  }

  factory AssetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetData(
      id: serializer.fromJson<String>(json['id']),
      assetDescription: serializer.fromJson<String>(json['assetDescription']),
      isPropertyPlot: serializer.fromJson<bool>(json['isPropertyPlot']),
      xCoordinate: serializer.fromJson<int>(json['xCoordinate']),
      yCoordinate: serializer.fromJson<int>(json['yCoordinate']),
      name: serializer.fromJson<String>(json['name']),
      assetsCategory: serializer.fromJson<String>(json['assetsCategory']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      sysUpdateAt: serializer.fromJson<DateTime>(json['sysUpdateAt']),
      language: $AssetTable.$converterlanguage
          .fromJson(serializer.fromJson<int>(json['language'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'assetDescription': serializer.toJson<String>(assetDescription),
      'isPropertyPlot': serializer.toJson<bool>(isPropertyPlot),
      'xCoordinate': serializer.toJson<int>(xCoordinate),
      'yCoordinate': serializer.toJson<int>(yCoordinate),
      'name': serializer.toJson<String>(name),
      'assetsCategory': serializer.toJson<String>(assetsCategory),
      'iconKey': serializer.toJson<String>(iconKey),
      'sysUpdateAt': serializer.toJson<DateTime>(sysUpdateAt),
      'language': serializer
          .toJson<int>($AssetTable.$converterlanguage.toJson(language)),
    };
  }

  AssetData copyWith(
          {String? id,
          String? assetDescription,
          bool? isPropertyPlot,
          int? xCoordinate,
          int? yCoordinate,
          String? name,
          String? assetsCategory,
          String? iconKey,
          DateTime? sysUpdateAt,
          Language? language}) =>
      AssetData(
        id: id ?? this.id,
        assetDescription: assetDescription ?? this.assetDescription,
        isPropertyPlot: isPropertyPlot ?? this.isPropertyPlot,
        xCoordinate: xCoordinate ?? this.xCoordinate,
        yCoordinate: yCoordinate ?? this.yCoordinate,
        name: name ?? this.name,
        assetsCategory: assetsCategory ?? this.assetsCategory,
        iconKey: iconKey ?? this.iconKey,
        sysUpdateAt: sysUpdateAt ?? this.sysUpdateAt,
        language: language ?? this.language,
      );
  AssetData copyWithCompanion(AssetCompanion data) {
    return AssetData(
      id: data.id.present ? data.id.value : this.id,
      assetDescription: data.assetDescription.present
          ? data.assetDescription.value
          : this.assetDescription,
      isPropertyPlot: data.isPropertyPlot.present
          ? data.isPropertyPlot.value
          : this.isPropertyPlot,
      xCoordinate:
          data.xCoordinate.present ? data.xCoordinate.value : this.xCoordinate,
      yCoordinate:
          data.yCoordinate.present ? data.yCoordinate.value : this.yCoordinate,
      name: data.name.present ? data.name.value : this.name,
      assetsCategory: data.assetsCategory.present
          ? data.assetsCategory.value
          : this.assetsCategory,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      sysUpdateAt:
          data.sysUpdateAt.present ? data.sysUpdateAt.value : this.sysUpdateAt,
      language: data.language.present ? data.language.value : this.language,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetData(')
          ..write('id: $id, ')
          ..write('assetDescription: $assetDescription, ')
          ..write('isPropertyPlot: $isPropertyPlot, ')
          ..write('xCoordinate: $xCoordinate, ')
          ..write('yCoordinate: $yCoordinate, ')
          ..write('name: $name, ')
          ..write('assetsCategory: $assetsCategory, ')
          ..write('iconKey: $iconKey, ')
          ..write('sysUpdateAt: $sysUpdateAt, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      assetDescription,
      isPropertyPlot,
      xCoordinate,
      yCoordinate,
      name,
      assetsCategory,
      iconKey,
      sysUpdateAt,
      language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetData &&
          other.id == this.id &&
          other.assetDescription == this.assetDescription &&
          other.isPropertyPlot == this.isPropertyPlot &&
          other.xCoordinate == this.xCoordinate &&
          other.yCoordinate == this.yCoordinate &&
          other.name == this.name &&
          other.assetsCategory == this.assetsCategory &&
          other.iconKey == this.iconKey &&
          other.sysUpdateAt == this.sysUpdateAt &&
          other.language == this.language);
}

class AssetCompanion extends UpdateCompanion<AssetData> {
  final Value<String> id;
  final Value<String> assetDescription;
  final Value<bool> isPropertyPlot;
  final Value<int> xCoordinate;
  final Value<int> yCoordinate;
  final Value<String> name;
  final Value<String> assetsCategory;
  final Value<String> iconKey;
  final Value<DateTime> sysUpdateAt;
  final Value<Language> language;
  final Value<int> rowid;
  const AssetCompanion({
    this.id = const Value.absent(),
    this.assetDescription = const Value.absent(),
    this.isPropertyPlot = const Value.absent(),
    this.xCoordinate = const Value.absent(),
    this.yCoordinate = const Value.absent(),
    this.name = const Value.absent(),
    this.assetsCategory = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.sysUpdateAt = const Value.absent(),
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetCompanion.insert({
    required String id,
    required String assetDescription,
    required bool isPropertyPlot,
    required int xCoordinate,
    required int yCoordinate,
    required String name,
    required String assetsCategory,
    required String iconKey,
    required DateTime sysUpdateAt,
    required Language language,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        assetDescription = Value(assetDescription),
        isPropertyPlot = Value(isPropertyPlot),
        xCoordinate = Value(xCoordinate),
        yCoordinate = Value(yCoordinate),
        name = Value(name),
        assetsCategory = Value(assetsCategory),
        iconKey = Value(iconKey),
        sysUpdateAt = Value(sysUpdateAt),
        language = Value(language);
  static Insertable<AssetData> custom({
    Expression<String>? id,
    Expression<String>? assetDescription,
    Expression<bool>? isPropertyPlot,
    Expression<int>? xCoordinate,
    Expression<int>? yCoordinate,
    Expression<String>? name,
    Expression<String>? assetsCategory,
    Expression<String>? iconKey,
    Expression<DateTime>? sysUpdateAt,
    Expression<int>? language,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetDescription != null) 'asset_description': assetDescription,
      if (isPropertyPlot != null) 'is_property_plot': isPropertyPlot,
      if (xCoordinate != null) 'x_coordinate': xCoordinate,
      if (yCoordinate != null) 'y_coordinate': yCoordinate,
      if (name != null) 'name': name,
      if (assetsCategory != null) 'assets_category': assetsCategory,
      if (iconKey != null) 'icon_key': iconKey,
      if (sysUpdateAt != null) 'sys_update_at': sysUpdateAt,
      if (language != null) 'language': language,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetCompanion copyWith(
      {Value<String>? id,
      Value<String>? assetDescription,
      Value<bool>? isPropertyPlot,
      Value<int>? xCoordinate,
      Value<int>? yCoordinate,
      Value<String>? name,
      Value<String>? assetsCategory,
      Value<String>? iconKey,
      Value<DateTime>? sysUpdateAt,
      Value<Language>? language,
      Value<int>? rowid}) {
    return AssetCompanion(
      id: id ?? this.id,
      assetDescription: assetDescription ?? this.assetDescription,
      isPropertyPlot: isPropertyPlot ?? this.isPropertyPlot,
      xCoordinate: xCoordinate ?? this.xCoordinate,
      yCoordinate: yCoordinate ?? this.yCoordinate,
      name: name ?? this.name,
      assetsCategory: assetsCategory ?? this.assetsCategory,
      iconKey: iconKey ?? this.iconKey,
      sysUpdateAt: sysUpdateAt ?? this.sysUpdateAt,
      language: language ?? this.language,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (assetDescription.present) {
      map['asset_description'] = Variable<String>(assetDescription.value);
    }
    if (isPropertyPlot.present) {
      map['is_property_plot'] = Variable<bool>(isPropertyPlot.value);
    }
    if (xCoordinate.present) {
      map['x_coordinate'] = Variable<int>(xCoordinate.value);
    }
    if (yCoordinate.present) {
      map['y_coordinate'] = Variable<int>(yCoordinate.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (assetsCategory.present) {
      map['assets_category'] = Variable<String>(assetsCategory.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (sysUpdateAt.present) {
      map['sys_update_at'] = Variable<DateTime>(sysUpdateAt.value);
    }
    if (language.present) {
      map['language'] =
          Variable<int>($AssetTable.$converterlanguage.toSql(language.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetCompanion(')
          ..write('id: $id, ')
          ..write('assetDescription: $assetDescription, ')
          ..write('isPropertyPlot: $isPropertyPlot, ')
          ..write('xCoordinate: $xCoordinate, ')
          ..write('yCoordinate: $yCoordinate, ')
          ..write('name: $name, ')
          ..write('assetsCategory: $assetsCategory, ')
          ..write('iconKey: $iconKey, ')
          ..write('sysUpdateAt: $sysUpdateAt, ')
          ..write('language: $language, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MultimediaTable extends Multimedia
    with TableInfo<$MultimediaTable, MultimediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MultimediaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _multimediaIdMeta =
      const VerificationMeta('multimediaId');
  @override
  late final GeneratedColumn<String> multimediaId = GeneratedColumn<String>(
      'multimedia_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<String> fileId = GeneratedColumn<String>(
      'file_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remotePathMeta =
      const VerificationMeta('remotePath');
  @override
  late final GeneratedColumn<String> remotePath = GeneratedColumn<String>(
      'remote_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sysUpdateAtMeta =
      const VerificationMeta('sysUpdateAt');
  @override
  late final GeneratedColumn<DateTime> sysUpdateAt = GeneratedColumn<DateTime>(
      'sys_update_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _mediaStatusMeta =
      const VerificationMeta('mediaStatus');
  @override
  late final GeneratedColumnWithTypeConverter<MediaDownloadStatus?, int>
      mediaStatus = GeneratedColumn<int>('media_status', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<MediaDownloadStatus?>(
              $MultimediaTable.$convertermediaStatusn);
  static const VerificationMeta _localFolderMeta =
      const VerificationMeta('localFolder');
  @override
  late final GeneratedColumn<String> localFolder = GeneratedColumn<String>(
      'local_folder', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localFileNameMeta =
      const VerificationMeta('localFileName');
  @override
  late final GeneratedColumn<String> localFileName = GeneratedColumn<String>(
      'local_file_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _downloadTaskIdMeta =
      const VerificationMeta('downloadTaskId');
  @override
  late final GeneratedColumn<String> downloadTaskId = GeneratedColumn<String>(
      'download_task_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _downloadProgressMeta =
      const VerificationMeta('downloadProgress');
  @override
  late final GeneratedColumn<int> downloadProgress = GeneratedColumn<int>(
      'download_progress', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        multimediaId,
        fileId,
        fileName,
        description,
        mimeType,
        remotePath,
        sysUpdateAt,
        mediaStatus,
        localFolder,
        localFileName,
        downloadTaskId,
        downloadProgress
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'multimedia';
  @override
  VerificationContext validateIntegrity(Insertable<MultimediaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('multimedia_id')) {
      context.handle(
          _multimediaIdMeta,
          multimediaId.isAcceptableOrUnknown(
              data['multimedia_id']!, _multimediaIdMeta));
    } else if (isInserting) {
      context.missing(_multimediaIdMeta);
    }
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta));
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('remote_path')) {
      context.handle(
          _remotePathMeta,
          remotePath.isAcceptableOrUnknown(
              data['remote_path']!, _remotePathMeta));
    } else if (isInserting) {
      context.missing(_remotePathMeta);
    }
    if (data.containsKey('sys_update_at')) {
      context.handle(
          _sysUpdateAtMeta,
          sysUpdateAt.isAcceptableOrUnknown(
              data['sys_update_at']!, _sysUpdateAtMeta));
    } else if (isInserting) {
      context.missing(_sysUpdateAtMeta);
    }
    context.handle(_mediaStatusMeta, const VerificationResult.success());
    if (data.containsKey('local_folder')) {
      context.handle(
          _localFolderMeta,
          localFolder.isAcceptableOrUnknown(
              data['local_folder']!, _localFolderMeta));
    }
    if (data.containsKey('local_file_name')) {
      context.handle(
          _localFileNameMeta,
          localFileName.isAcceptableOrUnknown(
              data['local_file_name']!, _localFileNameMeta));
    }
    if (data.containsKey('download_task_id')) {
      context.handle(
          _downloadTaskIdMeta,
          downloadTaskId.isAcceptableOrUnknown(
              data['download_task_id']!, _downloadTaskIdMeta));
    }
    if (data.containsKey('download_progress')) {
      context.handle(
          _downloadProgressMeta,
          downloadProgress.isAcceptableOrUnknown(
              data['download_progress']!, _downloadProgressMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {multimediaId};
  @override
  MultimediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MultimediaData(
      multimediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}multimedia_id'])!,
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_id'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type'])!,
      remotePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_path'])!,
      sysUpdateAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}sys_update_at'])!,
      mediaStatus: $MultimediaTable.$convertermediaStatusn.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}media_status'])),
      localFolder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_folder']),
      localFileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_file_name']),
      downloadTaskId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}download_task_id']),
      downloadProgress: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}download_progress']),
    );
  }

  @override
  $MultimediaTable createAlias(String alias) {
    return $MultimediaTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MediaDownloadStatus, int, int>
      $convertermediaStatus =
      const EnumIndexConverter<MediaDownloadStatus>(MediaDownloadStatus.values);
  static JsonTypeConverter2<MediaDownloadStatus?, int?, int?>
      $convertermediaStatusn =
      JsonTypeConverter2.asNullable($convertermediaStatus);
}

class MultimediaData extends DataClass implements Insertable<MultimediaData> {
  final String multimediaId;
  final String fileId;
  final String fileName;
  final String description;
  final String mimeType;
  final String remotePath;
  final DateTime sysUpdateAt;
  final MediaDownloadStatus? mediaStatus;
  final String? localFolder;
  final String? localFileName;
  final String? downloadTaskId;
  final int? downloadProgress;
  const MultimediaData(
      {required this.multimediaId,
      required this.fileId,
      required this.fileName,
      required this.description,
      required this.mimeType,
      required this.remotePath,
      required this.sysUpdateAt,
      this.mediaStatus,
      this.localFolder,
      this.localFileName,
      this.downloadTaskId,
      this.downloadProgress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['multimedia_id'] = Variable<String>(multimediaId);
    map['file_id'] = Variable<String>(fileId);
    map['file_name'] = Variable<String>(fileName);
    map['description'] = Variable<String>(description);
    map['mime_type'] = Variable<String>(mimeType);
    map['remote_path'] = Variable<String>(remotePath);
    map['sys_update_at'] = Variable<DateTime>(sysUpdateAt);
    if (!nullToAbsent || mediaStatus != null) {
      map['media_status'] = Variable<int>(
          $MultimediaTable.$convertermediaStatusn.toSql(mediaStatus));
    }
    if (!nullToAbsent || localFolder != null) {
      map['local_folder'] = Variable<String>(localFolder);
    }
    if (!nullToAbsent || localFileName != null) {
      map['local_file_name'] = Variable<String>(localFileName);
    }
    if (!nullToAbsent || downloadTaskId != null) {
      map['download_task_id'] = Variable<String>(downloadTaskId);
    }
    if (!nullToAbsent || downloadProgress != null) {
      map['download_progress'] = Variable<int>(downloadProgress);
    }
    return map;
  }

  MultimediaCompanion toCompanion(bool nullToAbsent) {
    return MultimediaCompanion(
      multimediaId: Value(multimediaId),
      fileId: Value(fileId),
      fileName: Value(fileName),
      description: Value(description),
      mimeType: Value(mimeType),
      remotePath: Value(remotePath),
      sysUpdateAt: Value(sysUpdateAt),
      mediaStatus: mediaStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaStatus),
      localFolder: localFolder == null && nullToAbsent
          ? const Value.absent()
          : Value(localFolder),
      localFileName: localFileName == null && nullToAbsent
          ? const Value.absent()
          : Value(localFileName),
      downloadTaskId: downloadTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadTaskId),
      downloadProgress: downloadProgress == null && nullToAbsent
          ? const Value.absent()
          : Value(downloadProgress),
    );
  }

  factory MultimediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MultimediaData(
      multimediaId: serializer.fromJson<String>(json['multimediaId']),
      fileId: serializer.fromJson<String>(json['fileId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      description: serializer.fromJson<String>(json['description']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      remotePath: serializer.fromJson<String>(json['remotePath']),
      sysUpdateAt: serializer.fromJson<DateTime>(json['sysUpdateAt']),
      mediaStatus: $MultimediaTable.$convertermediaStatusn
          .fromJson(serializer.fromJson<int?>(json['mediaStatus'])),
      localFolder: serializer.fromJson<String?>(json['localFolder']),
      localFileName: serializer.fromJson<String?>(json['localFileName']),
      downloadTaskId: serializer.fromJson<String?>(json['downloadTaskId']),
      downloadProgress: serializer.fromJson<int?>(json['downloadProgress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'multimediaId': serializer.toJson<String>(multimediaId),
      'fileId': serializer.toJson<String>(fileId),
      'fileName': serializer.toJson<String>(fileName),
      'description': serializer.toJson<String>(description),
      'mimeType': serializer.toJson<String>(mimeType),
      'remotePath': serializer.toJson<String>(remotePath),
      'sysUpdateAt': serializer.toJson<DateTime>(sysUpdateAt),
      'mediaStatus': serializer.toJson<int?>(
          $MultimediaTable.$convertermediaStatusn.toJson(mediaStatus)),
      'localFolder': serializer.toJson<String?>(localFolder),
      'localFileName': serializer.toJson<String?>(localFileName),
      'downloadTaskId': serializer.toJson<String?>(downloadTaskId),
      'downloadProgress': serializer.toJson<int?>(downloadProgress),
    };
  }

  MultimediaData copyWith(
          {String? multimediaId,
          String? fileId,
          String? fileName,
          String? description,
          String? mimeType,
          String? remotePath,
          DateTime? sysUpdateAt,
          Value<MediaDownloadStatus?> mediaStatus = const Value.absent(),
          Value<String?> localFolder = const Value.absent(),
          Value<String?> localFileName = const Value.absent(),
          Value<String?> downloadTaskId = const Value.absent(),
          Value<int?> downloadProgress = const Value.absent()}) =>
      MultimediaData(
        multimediaId: multimediaId ?? this.multimediaId,
        fileId: fileId ?? this.fileId,
        fileName: fileName ?? this.fileName,
        description: description ?? this.description,
        mimeType: mimeType ?? this.mimeType,
        remotePath: remotePath ?? this.remotePath,
        sysUpdateAt: sysUpdateAt ?? this.sysUpdateAt,
        mediaStatus: mediaStatus.present ? mediaStatus.value : this.mediaStatus,
        localFolder: localFolder.present ? localFolder.value : this.localFolder,
        localFileName:
            localFileName.present ? localFileName.value : this.localFileName,
        downloadTaskId:
            downloadTaskId.present ? downloadTaskId.value : this.downloadTaskId,
        downloadProgress: downloadProgress.present
            ? downloadProgress.value
            : this.downloadProgress,
      );
  MultimediaData copyWithCompanion(MultimediaCompanion data) {
    return MultimediaData(
      multimediaId: data.multimediaId.present
          ? data.multimediaId.value
          : this.multimediaId,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      description:
          data.description.present ? data.description.value : this.description,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      remotePath:
          data.remotePath.present ? data.remotePath.value : this.remotePath,
      sysUpdateAt:
          data.sysUpdateAt.present ? data.sysUpdateAt.value : this.sysUpdateAt,
      mediaStatus:
          data.mediaStatus.present ? data.mediaStatus.value : this.mediaStatus,
      localFolder:
          data.localFolder.present ? data.localFolder.value : this.localFolder,
      localFileName: data.localFileName.present
          ? data.localFileName.value
          : this.localFileName,
      downloadTaskId: data.downloadTaskId.present
          ? data.downloadTaskId.value
          : this.downloadTaskId,
      downloadProgress: data.downloadProgress.present
          ? data.downloadProgress.value
          : this.downloadProgress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MultimediaData(')
          ..write('multimediaId: $multimediaId, ')
          ..write('fileId: $fileId, ')
          ..write('fileName: $fileName, ')
          ..write('description: $description, ')
          ..write('mimeType: $mimeType, ')
          ..write('remotePath: $remotePath, ')
          ..write('sysUpdateAt: $sysUpdateAt, ')
          ..write('mediaStatus: $mediaStatus, ')
          ..write('localFolder: $localFolder, ')
          ..write('localFileName: $localFileName, ')
          ..write('downloadTaskId: $downloadTaskId, ')
          ..write('downloadProgress: $downloadProgress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      multimediaId,
      fileId,
      fileName,
      description,
      mimeType,
      remotePath,
      sysUpdateAt,
      mediaStatus,
      localFolder,
      localFileName,
      downloadTaskId,
      downloadProgress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MultimediaData &&
          other.multimediaId == this.multimediaId &&
          other.fileId == this.fileId &&
          other.fileName == this.fileName &&
          other.description == this.description &&
          other.mimeType == this.mimeType &&
          other.remotePath == this.remotePath &&
          other.sysUpdateAt == this.sysUpdateAt &&
          other.mediaStatus == this.mediaStatus &&
          other.localFolder == this.localFolder &&
          other.localFileName == this.localFileName &&
          other.downloadTaskId == this.downloadTaskId &&
          other.downloadProgress == this.downloadProgress);
}

class MultimediaCompanion extends UpdateCompanion<MultimediaData> {
  final Value<String> multimediaId;
  final Value<String> fileId;
  final Value<String> fileName;
  final Value<String> description;
  final Value<String> mimeType;
  final Value<String> remotePath;
  final Value<DateTime> sysUpdateAt;
  final Value<MediaDownloadStatus?> mediaStatus;
  final Value<String?> localFolder;
  final Value<String?> localFileName;
  final Value<String?> downloadTaskId;
  final Value<int?> downloadProgress;
  final Value<int> rowid;
  const MultimediaCompanion({
    this.multimediaId = const Value.absent(),
    this.fileId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.description = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.remotePath = const Value.absent(),
    this.sysUpdateAt = const Value.absent(),
    this.mediaStatus = const Value.absent(),
    this.localFolder = const Value.absent(),
    this.localFileName = const Value.absent(),
    this.downloadTaskId = const Value.absent(),
    this.downloadProgress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MultimediaCompanion.insert({
    required String multimediaId,
    required String fileId,
    required String fileName,
    required String description,
    required String mimeType,
    required String remotePath,
    required DateTime sysUpdateAt,
    this.mediaStatus = const Value.absent(),
    this.localFolder = const Value.absent(),
    this.localFileName = const Value.absent(),
    this.downloadTaskId = const Value.absent(),
    this.downloadProgress = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : multimediaId = Value(multimediaId),
        fileId = Value(fileId),
        fileName = Value(fileName),
        description = Value(description),
        mimeType = Value(mimeType),
        remotePath = Value(remotePath),
        sysUpdateAt = Value(sysUpdateAt);
  static Insertable<MultimediaData> custom({
    Expression<String>? multimediaId,
    Expression<String>? fileId,
    Expression<String>? fileName,
    Expression<String>? description,
    Expression<String>? mimeType,
    Expression<String>? remotePath,
    Expression<DateTime>? sysUpdateAt,
    Expression<int>? mediaStatus,
    Expression<String>? localFolder,
    Expression<String>? localFileName,
    Expression<String>? downloadTaskId,
    Expression<int>? downloadProgress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (multimediaId != null) 'multimedia_id': multimediaId,
      if (fileId != null) 'file_id': fileId,
      if (fileName != null) 'file_name': fileName,
      if (description != null) 'description': description,
      if (mimeType != null) 'mime_type': mimeType,
      if (remotePath != null) 'remote_path': remotePath,
      if (sysUpdateAt != null) 'sys_update_at': sysUpdateAt,
      if (mediaStatus != null) 'media_status': mediaStatus,
      if (localFolder != null) 'local_folder': localFolder,
      if (localFileName != null) 'local_file_name': localFileName,
      if (downloadTaskId != null) 'download_task_id': downloadTaskId,
      if (downloadProgress != null) 'download_progress': downloadProgress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MultimediaCompanion copyWith(
      {Value<String>? multimediaId,
      Value<String>? fileId,
      Value<String>? fileName,
      Value<String>? description,
      Value<String>? mimeType,
      Value<String>? remotePath,
      Value<DateTime>? sysUpdateAt,
      Value<MediaDownloadStatus?>? mediaStatus,
      Value<String?>? localFolder,
      Value<String?>? localFileName,
      Value<String?>? downloadTaskId,
      Value<int?>? downloadProgress,
      Value<int>? rowid}) {
    return MultimediaCompanion(
      multimediaId: multimediaId ?? this.multimediaId,
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      description: description ?? this.description,
      mimeType: mimeType ?? this.mimeType,
      remotePath: remotePath ?? this.remotePath,
      sysUpdateAt: sysUpdateAt ?? this.sysUpdateAt,
      mediaStatus: mediaStatus ?? this.mediaStatus,
      localFolder: localFolder ?? this.localFolder,
      localFileName: localFileName ?? this.localFileName,
      downloadTaskId: downloadTaskId ?? this.downloadTaskId,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (multimediaId.present) {
      map['multimedia_id'] = Variable<String>(multimediaId.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<String>(fileId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (remotePath.present) {
      map['remote_path'] = Variable<String>(remotePath.value);
    }
    if (sysUpdateAt.present) {
      map['sys_update_at'] = Variable<DateTime>(sysUpdateAt.value);
    }
    if (mediaStatus.present) {
      map['media_status'] = Variable<int>(
          $MultimediaTable.$convertermediaStatusn.toSql(mediaStatus.value));
    }
    if (localFolder.present) {
      map['local_folder'] = Variable<String>(localFolder.value);
    }
    if (localFileName.present) {
      map['local_file_name'] = Variable<String>(localFileName.value);
    }
    if (downloadTaskId.present) {
      map['download_task_id'] = Variable<String>(downloadTaskId.value);
    }
    if (downloadProgress.present) {
      map['download_progress'] = Variable<int>(downloadProgress.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MultimediaCompanion(')
          ..write('multimediaId: $multimediaId, ')
          ..write('fileId: $fileId, ')
          ..write('fileName: $fileName, ')
          ..write('description: $description, ')
          ..write('mimeType: $mimeType, ')
          ..write('remotePath: $remotePath, ')
          ..write('sysUpdateAt: $sysUpdateAt, ')
          ..write('mediaStatus: $mediaStatus, ')
          ..write('localFolder: $localFolder, ')
          ..write('localFileName: $localFileName, ')
          ..write('downloadTaskId: $downloadTaskId, ')
          ..write('downloadProgress: $downloadProgress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediaTable extends Media with TableInfo<$MediaTable, MediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mediaIdMeta =
      const VerificationMeta('mediaId');
  @override
  late final GeneratedColumn<String> mediaId = GeneratedColumn<String>(
      'media_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _multimediaIdMeta =
      const VerificationMeta('multimediaId');
  @override
  late final GeneratedColumn<String> multimediaId = GeneratedColumn<String>(
      'multimedia_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES multimedia (multimedia_id)'));
  static const VerificationMeta _mediaOrderMeta =
      const VerificationMeta('mediaOrder');
  @override
  late final GeneratedColumn<int> mediaOrder = GeneratedColumn<int>(
      'media_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subTitleMeta =
      const VerificationMeta('subTitle');
  @override
  late final GeneratedColumn<String> subTitle = GeneratedColumn<String>(
      'sub_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryLabelMeta =
      const VerificationMeta('categoryLabel');
  @override
  late final GeneratedColumn<String> categoryLabel = GeneratedColumn<String>(
      'category_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryOrderMeta =
      const VerificationMeta('categoryOrder');
  @override
  late final GeneratedColumn<int> categoryOrder = GeneratedColumn<int>(
      'category_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subCategoryIdMeta =
      const VerificationMeta('subCategoryId');
  @override
  late final GeneratedColumn<String> subCategoryId = GeneratedColumn<String>(
      'sub_category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subCategoryLabelMeta =
      const VerificationMeta('subCategoryLabel');
  @override
  late final GeneratedColumn<String> subCategoryLabel = GeneratedColumn<String>(
      'sub_category_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subCategoryOrderMeta =
      const VerificationMeta('subCategoryOrder');
  @override
  late final GeneratedColumn<int> subCategoryOrder = GeneratedColumn<int>(
      'sub_category_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sysUpdateAtMeta =
      const VerificationMeta('sysUpdateAt');
  @override
  late final GeneratedColumn<DateTime> sysUpdateAt = GeneratedColumn<DateTime>(
      'sys_update_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumnWithTypeConverter<Language, int> language =
      GeneratedColumn<int>('language', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Language>($MediaTable.$converterlanguage);
  @override
  List<GeneratedColumn> get $columns => [
        mediaId,
        multimediaId,
        mediaOrder,
        title,
        subTitle,
        categoryId,
        categoryLabel,
        categoryOrder,
        subCategoryId,
        subCategoryLabel,
        subCategoryOrder,
        sysUpdateAt,
        language
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media';
  @override
  VerificationContext validateIntegrity(Insertable<MediaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('media_id')) {
      context.handle(_mediaIdMeta,
          mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta));
    } else if (isInserting) {
      context.missing(_mediaIdMeta);
    }
    if (data.containsKey('multimedia_id')) {
      context.handle(
          _multimediaIdMeta,
          multimediaId.isAcceptableOrUnknown(
              data['multimedia_id']!, _multimediaIdMeta));
    } else if (isInserting) {
      context.missing(_multimediaIdMeta);
    }
    if (data.containsKey('media_order')) {
      context.handle(
          _mediaOrderMeta,
          mediaOrder.isAcceptableOrUnknown(
              data['media_order']!, _mediaOrderMeta));
    } else if (isInserting) {
      context.missing(_mediaOrderMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sub_title')) {
      context.handle(_subTitleMeta,
          subTitle.isAcceptableOrUnknown(data['sub_title']!, _subTitleMeta));
    } else if (isInserting) {
      context.missing(_subTitleMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('category_label')) {
      context.handle(
          _categoryLabelMeta,
          categoryLabel.isAcceptableOrUnknown(
              data['category_label']!, _categoryLabelMeta));
    } else if (isInserting) {
      context.missing(_categoryLabelMeta);
    }
    if (data.containsKey('category_order')) {
      context.handle(
          _categoryOrderMeta,
          categoryOrder.isAcceptableOrUnknown(
              data['category_order']!, _categoryOrderMeta));
    } else if (isInserting) {
      context.missing(_categoryOrderMeta);
    }
    if (data.containsKey('sub_category_id')) {
      context.handle(
          _subCategoryIdMeta,
          subCategoryId.isAcceptableOrUnknown(
              data['sub_category_id']!, _subCategoryIdMeta));
    } else if (isInserting) {
      context.missing(_subCategoryIdMeta);
    }
    if (data.containsKey('sub_category_label')) {
      context.handle(
          _subCategoryLabelMeta,
          subCategoryLabel.isAcceptableOrUnknown(
              data['sub_category_label']!, _subCategoryLabelMeta));
    } else if (isInserting) {
      context.missing(_subCategoryLabelMeta);
    }
    if (data.containsKey('sub_category_order')) {
      context.handle(
          _subCategoryOrderMeta,
          subCategoryOrder.isAcceptableOrUnknown(
              data['sub_category_order']!, _subCategoryOrderMeta));
    } else if (isInserting) {
      context.missing(_subCategoryOrderMeta);
    }
    if (data.containsKey('sys_update_at')) {
      context.handle(
          _sysUpdateAtMeta,
          sysUpdateAt.isAcceptableOrUnknown(
              data['sys_update_at']!, _sysUpdateAtMeta));
    } else if (isInserting) {
      context.missing(_sysUpdateAtMeta);
    }
    context.handle(_languageMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {mediaId, categoryId, subCategoryId, language},
      ];
  @override
  MediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaData(
      mediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_id'])!,
      multimediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}multimedia_id'])!,
      mediaOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}media_order'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sub_title'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      categoryLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_label'])!,
      categoryOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_order'])!,
      subCategoryId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sub_category_id'])!,
      subCategoryLabel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sub_category_label'])!,
      subCategoryOrder: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sub_category_order'])!,
      sysUpdateAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}sys_update_at'])!,
      language: $MediaTable.$converterlanguage.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}language'])!),
    );
  }

  @override
  $MediaTable createAlias(String alias) {
    return $MediaTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Language, int, int> $converterlanguage =
      const EnumIndexConverter<Language>(Language.values);
}

class MediaData extends DataClass implements Insertable<MediaData> {
  final String mediaId;
  final String multimediaId;
  final int mediaOrder;
  final String title;
  final String subTitle;
  final String categoryId;
  final String categoryLabel;
  final int categoryOrder;
  final String subCategoryId;
  final String subCategoryLabel;
  final int subCategoryOrder;
  final DateTime sysUpdateAt;
  final Language language;
  const MediaData(
      {required this.mediaId,
      required this.multimediaId,
      required this.mediaOrder,
      required this.title,
      required this.subTitle,
      required this.categoryId,
      required this.categoryLabel,
      required this.categoryOrder,
      required this.subCategoryId,
      required this.subCategoryLabel,
      required this.subCategoryOrder,
      required this.sysUpdateAt,
      required this.language});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['media_id'] = Variable<String>(mediaId);
    map['multimedia_id'] = Variable<String>(multimediaId);
    map['media_order'] = Variable<int>(mediaOrder);
    map['title'] = Variable<String>(title);
    map['sub_title'] = Variable<String>(subTitle);
    map['category_id'] = Variable<String>(categoryId);
    map['category_label'] = Variable<String>(categoryLabel);
    map['category_order'] = Variable<int>(categoryOrder);
    map['sub_category_id'] = Variable<String>(subCategoryId);
    map['sub_category_label'] = Variable<String>(subCategoryLabel);
    map['sub_category_order'] = Variable<int>(subCategoryOrder);
    map['sys_update_at'] = Variable<DateTime>(sysUpdateAt);
    {
      map['language'] =
          Variable<int>($MediaTable.$converterlanguage.toSql(language));
    }
    return map;
  }

  MediaCompanion toCompanion(bool nullToAbsent) {
    return MediaCompanion(
      mediaId: Value(mediaId),
      multimediaId: Value(multimediaId),
      mediaOrder: Value(mediaOrder),
      title: Value(title),
      subTitle: Value(subTitle),
      categoryId: Value(categoryId),
      categoryLabel: Value(categoryLabel),
      categoryOrder: Value(categoryOrder),
      subCategoryId: Value(subCategoryId),
      subCategoryLabel: Value(subCategoryLabel),
      subCategoryOrder: Value(subCategoryOrder),
      sysUpdateAt: Value(sysUpdateAt),
      language: Value(language),
    );
  }

  factory MediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaData(
      mediaId: serializer.fromJson<String>(json['mediaId']),
      multimediaId: serializer.fromJson<String>(json['multimediaId']),
      mediaOrder: serializer.fromJson<int>(json['mediaOrder']),
      title: serializer.fromJson<String>(json['title']),
      subTitle: serializer.fromJson<String>(json['subTitle']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      categoryLabel: serializer.fromJson<String>(json['categoryLabel']),
      categoryOrder: serializer.fromJson<int>(json['categoryOrder']),
      subCategoryId: serializer.fromJson<String>(json['subCategoryId']),
      subCategoryLabel: serializer.fromJson<String>(json['subCategoryLabel']),
      subCategoryOrder: serializer.fromJson<int>(json['subCategoryOrder']),
      sysUpdateAt: serializer.fromJson<DateTime>(json['sysUpdateAt']),
      language: $MediaTable.$converterlanguage
          .fromJson(serializer.fromJson<int>(json['language'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mediaId': serializer.toJson<String>(mediaId),
      'multimediaId': serializer.toJson<String>(multimediaId),
      'mediaOrder': serializer.toJson<int>(mediaOrder),
      'title': serializer.toJson<String>(title),
      'subTitle': serializer.toJson<String>(subTitle),
      'categoryId': serializer.toJson<String>(categoryId),
      'categoryLabel': serializer.toJson<String>(categoryLabel),
      'categoryOrder': serializer.toJson<int>(categoryOrder),
      'subCategoryId': serializer.toJson<String>(subCategoryId),
      'subCategoryLabel': serializer.toJson<String>(subCategoryLabel),
      'subCategoryOrder': serializer.toJson<int>(subCategoryOrder),
      'sysUpdateAt': serializer.toJson<DateTime>(sysUpdateAt),
      'language': serializer
          .toJson<int>($MediaTable.$converterlanguage.toJson(language)),
    };
  }

  MediaData copyWith(
          {String? mediaId,
          String? multimediaId,
          int? mediaOrder,
          String? title,
          String? subTitle,
          String? categoryId,
          String? categoryLabel,
          int? categoryOrder,
          String? subCategoryId,
          String? subCategoryLabel,
          int? subCategoryOrder,
          DateTime? sysUpdateAt,
          Language? language}) =>
      MediaData(
        mediaId: mediaId ?? this.mediaId,
        multimediaId: multimediaId ?? this.multimediaId,
        mediaOrder: mediaOrder ?? this.mediaOrder,
        title: title ?? this.title,
        subTitle: subTitle ?? this.subTitle,
        categoryId: categoryId ?? this.categoryId,
        categoryLabel: categoryLabel ?? this.categoryLabel,
        categoryOrder: categoryOrder ?? this.categoryOrder,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        subCategoryLabel: subCategoryLabel ?? this.subCategoryLabel,
        subCategoryOrder: subCategoryOrder ?? this.subCategoryOrder,
        sysUpdateAt: sysUpdateAt ?? this.sysUpdateAt,
        language: language ?? this.language,
      );
  MediaData copyWithCompanion(MediaCompanion data) {
    return MediaData(
      mediaId: data.mediaId.present ? data.mediaId.value : this.mediaId,
      multimediaId: data.multimediaId.present
          ? data.multimediaId.value
          : this.multimediaId,
      mediaOrder:
          data.mediaOrder.present ? data.mediaOrder.value : this.mediaOrder,
      title: data.title.present ? data.title.value : this.title,
      subTitle: data.subTitle.present ? data.subTitle.value : this.subTitle,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      categoryLabel: data.categoryLabel.present
          ? data.categoryLabel.value
          : this.categoryLabel,
      categoryOrder: data.categoryOrder.present
          ? data.categoryOrder.value
          : this.categoryOrder,
      subCategoryId: data.subCategoryId.present
          ? data.subCategoryId.value
          : this.subCategoryId,
      subCategoryLabel: data.subCategoryLabel.present
          ? data.subCategoryLabel.value
          : this.subCategoryLabel,
      subCategoryOrder: data.subCategoryOrder.present
          ? data.subCategoryOrder.value
          : this.subCategoryOrder,
      sysUpdateAt:
          data.sysUpdateAt.present ? data.sysUpdateAt.value : this.sysUpdateAt,
      language: data.language.present ? data.language.value : this.language,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaData(')
          ..write('mediaId: $mediaId, ')
          ..write('multimediaId: $multimediaId, ')
          ..write('mediaOrder: $mediaOrder, ')
          ..write('title: $title, ')
          ..write('subTitle: $subTitle, ')
          ..write('categoryId: $categoryId, ')
          ..write('categoryLabel: $categoryLabel, ')
          ..write('categoryOrder: $categoryOrder, ')
          ..write('subCategoryId: $subCategoryId, ')
          ..write('subCategoryLabel: $subCategoryLabel, ')
          ..write('subCategoryOrder: $subCategoryOrder, ')
          ..write('sysUpdateAt: $sysUpdateAt, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      mediaId,
      multimediaId,
      mediaOrder,
      title,
      subTitle,
      categoryId,
      categoryLabel,
      categoryOrder,
      subCategoryId,
      subCategoryLabel,
      subCategoryOrder,
      sysUpdateAt,
      language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaData &&
          other.mediaId == this.mediaId &&
          other.multimediaId == this.multimediaId &&
          other.mediaOrder == this.mediaOrder &&
          other.title == this.title &&
          other.subTitle == this.subTitle &&
          other.categoryId == this.categoryId &&
          other.categoryLabel == this.categoryLabel &&
          other.categoryOrder == this.categoryOrder &&
          other.subCategoryId == this.subCategoryId &&
          other.subCategoryLabel == this.subCategoryLabel &&
          other.subCategoryOrder == this.subCategoryOrder &&
          other.sysUpdateAt == this.sysUpdateAt &&
          other.language == this.language);
}

class MediaCompanion extends UpdateCompanion<MediaData> {
  final Value<String> mediaId;
  final Value<String> multimediaId;
  final Value<int> mediaOrder;
  final Value<String> title;
  final Value<String> subTitle;
  final Value<String> categoryId;
  final Value<String> categoryLabel;
  final Value<int> categoryOrder;
  final Value<String> subCategoryId;
  final Value<String> subCategoryLabel;
  final Value<int> subCategoryOrder;
  final Value<DateTime> sysUpdateAt;
  final Value<Language> language;
  final Value<int> rowid;
  const MediaCompanion({
    this.mediaId = const Value.absent(),
    this.multimediaId = const Value.absent(),
    this.mediaOrder = const Value.absent(),
    this.title = const Value.absent(),
    this.subTitle = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categoryLabel = const Value.absent(),
    this.categoryOrder = const Value.absent(),
    this.subCategoryId = const Value.absent(),
    this.subCategoryLabel = const Value.absent(),
    this.subCategoryOrder = const Value.absent(),
    this.sysUpdateAt = const Value.absent(),
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaCompanion.insert({
    required String mediaId,
    required String multimediaId,
    required int mediaOrder,
    required String title,
    required String subTitle,
    required String categoryId,
    required String categoryLabel,
    required int categoryOrder,
    required String subCategoryId,
    required String subCategoryLabel,
    required int subCategoryOrder,
    required DateTime sysUpdateAt,
    required Language language,
    this.rowid = const Value.absent(),
  })  : mediaId = Value(mediaId),
        multimediaId = Value(multimediaId),
        mediaOrder = Value(mediaOrder),
        title = Value(title),
        subTitle = Value(subTitle),
        categoryId = Value(categoryId),
        categoryLabel = Value(categoryLabel),
        categoryOrder = Value(categoryOrder),
        subCategoryId = Value(subCategoryId),
        subCategoryLabel = Value(subCategoryLabel),
        subCategoryOrder = Value(subCategoryOrder),
        sysUpdateAt = Value(sysUpdateAt),
        language = Value(language);
  static Insertable<MediaData> custom({
    Expression<String>? mediaId,
    Expression<String>? multimediaId,
    Expression<int>? mediaOrder,
    Expression<String>? title,
    Expression<String>? subTitle,
    Expression<String>? categoryId,
    Expression<String>? categoryLabel,
    Expression<int>? categoryOrder,
    Expression<String>? subCategoryId,
    Expression<String>? subCategoryLabel,
    Expression<int>? subCategoryOrder,
    Expression<DateTime>? sysUpdateAt,
    Expression<int>? language,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mediaId != null) 'media_id': mediaId,
      if (multimediaId != null) 'multimedia_id': multimediaId,
      if (mediaOrder != null) 'media_order': mediaOrder,
      if (title != null) 'title': title,
      if (subTitle != null) 'sub_title': subTitle,
      if (categoryId != null) 'category_id': categoryId,
      if (categoryLabel != null) 'category_label': categoryLabel,
      if (categoryOrder != null) 'category_order': categoryOrder,
      if (subCategoryId != null) 'sub_category_id': subCategoryId,
      if (subCategoryLabel != null) 'sub_category_label': subCategoryLabel,
      if (subCategoryOrder != null) 'sub_category_order': subCategoryOrder,
      if (sysUpdateAt != null) 'sys_update_at': sysUpdateAt,
      if (language != null) 'language': language,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaCompanion copyWith(
      {Value<String>? mediaId,
      Value<String>? multimediaId,
      Value<int>? mediaOrder,
      Value<String>? title,
      Value<String>? subTitle,
      Value<String>? categoryId,
      Value<String>? categoryLabel,
      Value<int>? categoryOrder,
      Value<String>? subCategoryId,
      Value<String>? subCategoryLabel,
      Value<int>? subCategoryOrder,
      Value<DateTime>? sysUpdateAt,
      Value<Language>? language,
      Value<int>? rowid}) {
    return MediaCompanion(
      mediaId: mediaId ?? this.mediaId,
      multimediaId: multimediaId ?? this.multimediaId,
      mediaOrder: mediaOrder ?? this.mediaOrder,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      categoryId: categoryId ?? this.categoryId,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      categoryOrder: categoryOrder ?? this.categoryOrder,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryLabel: subCategoryLabel ?? this.subCategoryLabel,
      subCategoryOrder: subCategoryOrder ?? this.subCategoryOrder,
      sysUpdateAt: sysUpdateAt ?? this.sysUpdateAt,
      language: language ?? this.language,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mediaId.present) {
      map['media_id'] = Variable<String>(mediaId.value);
    }
    if (multimediaId.present) {
      map['multimedia_id'] = Variable<String>(multimediaId.value);
    }
    if (mediaOrder.present) {
      map['media_order'] = Variable<int>(mediaOrder.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subTitle.present) {
      map['sub_title'] = Variable<String>(subTitle.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (categoryLabel.present) {
      map['category_label'] = Variable<String>(categoryLabel.value);
    }
    if (categoryOrder.present) {
      map['category_order'] = Variable<int>(categoryOrder.value);
    }
    if (subCategoryId.present) {
      map['sub_category_id'] = Variable<String>(subCategoryId.value);
    }
    if (subCategoryLabel.present) {
      map['sub_category_label'] = Variable<String>(subCategoryLabel.value);
    }
    if (subCategoryOrder.present) {
      map['sub_category_order'] = Variable<int>(subCategoryOrder.value);
    }
    if (sysUpdateAt.present) {
      map['sys_update_at'] = Variable<DateTime>(sysUpdateAt.value);
    }
    if (language.present) {
      map['language'] =
          Variable<int>($MediaTable.$converterlanguage.toSql(language.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaCompanion(')
          ..write('mediaId: $mediaId, ')
          ..write('multimediaId: $multimediaId, ')
          ..write('mediaOrder: $mediaOrder, ')
          ..write('title: $title, ')
          ..write('subTitle: $subTitle, ')
          ..write('categoryId: $categoryId, ')
          ..write('categoryLabel: $categoryLabel, ')
          ..write('categoryOrder: $categoryOrder, ')
          ..write('subCategoryId: $subCategoryId, ')
          ..write('subCategoryLabel: $subCategoryLabel, ')
          ..write('subCategoryOrder: $subCategoryOrder, ')
          ..write('sysUpdateAt: $sysUpdateAt, ')
          ..write('language: $language, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MultimediaMappingTable extends MultimediaMapping
    with TableInfo<$MultimediaMappingTable, MultimediaMappingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MultimediaMappingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _plotIdMeta = const VerificationMeta('plotId');
  @override
  late final GeneratedColumn<String> plotId = GeneratedColumn<String>(
      'plot_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES plot (id)'));
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
      'asset_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _multimediaIdMeta =
      const VerificationMeta('multimediaId');
  @override
  late final GeneratedColumn<String> multimediaId = GeneratedColumn<String>(
      'multimedia_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES multimedia (multimedia_id)'));
  static const VerificationMeta _useAsMeta = const VerificationMeta('useAs');
  @override
  late final GeneratedColumnWithTypeConverter<MultimediaCategory, int> useAs =
      GeneratedColumn<int>('use_as', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MultimediaCategory>(
              $MultimediaMappingTable.$converteruseAs);
  @override
  List<GeneratedColumn> get $columns => [plotId, assetId, multimediaId, useAs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'multimedia_mapping';
  @override
  VerificationContext validateIntegrity(
      Insertable<MultimediaMappingData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('plot_id')) {
      context.handle(_plotIdMeta,
          plotId.isAcceptableOrUnknown(data['plot_id']!, _plotIdMeta));
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    }
    if (data.containsKey('multimedia_id')) {
      context.handle(
          _multimediaIdMeta,
          multimediaId.isAcceptableOrUnknown(
              data['multimedia_id']!, _multimediaIdMeta));
    } else if (isInserting) {
      context.missing(_multimediaIdMeta);
    }
    context.handle(_useAsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MultimediaMappingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MultimediaMappingData(
      plotId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plot_id']),
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}asset_id']),
      multimediaId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}multimedia_id'])!,
      useAs: $MultimediaMappingTable.$converteruseAs.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}use_as'])!),
    );
  }

  @override
  $MultimediaMappingTable createAlias(String alias) {
    return $MultimediaMappingTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MultimediaCategory, int, int> $converteruseAs =
      const EnumIndexConverter<MultimediaCategory>(MultimediaCategory.values);
}

class MultimediaMappingData extends DataClass
    implements Insertable<MultimediaMappingData> {
  final String? plotId;
  final String? assetId;
  final String multimediaId;
  final MultimediaCategory useAs;
  const MultimediaMappingData(
      {this.plotId,
      this.assetId,
      required this.multimediaId,
      required this.useAs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || plotId != null) {
      map['plot_id'] = Variable<String>(plotId);
    }
    if (!nullToAbsent || assetId != null) {
      map['asset_id'] = Variable<String>(assetId);
    }
    map['multimedia_id'] = Variable<String>(multimediaId);
    {
      map['use_as'] =
          Variable<int>($MultimediaMappingTable.$converteruseAs.toSql(useAs));
    }
    return map;
  }

  MultimediaMappingCompanion toCompanion(bool nullToAbsent) {
    return MultimediaMappingCompanion(
      plotId:
          plotId == null && nullToAbsent ? const Value.absent() : Value(plotId),
      assetId: assetId == null && nullToAbsent
          ? const Value.absent()
          : Value(assetId),
      multimediaId: Value(multimediaId),
      useAs: Value(useAs),
    );
  }

  factory MultimediaMappingData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MultimediaMappingData(
      plotId: serializer.fromJson<String?>(json['plotId']),
      assetId: serializer.fromJson<String?>(json['assetId']),
      multimediaId: serializer.fromJson<String>(json['multimediaId']),
      useAs: $MultimediaMappingTable.$converteruseAs
          .fromJson(serializer.fromJson<int>(json['useAs'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'plotId': serializer.toJson<String?>(plotId),
      'assetId': serializer.toJson<String?>(assetId),
      'multimediaId': serializer.toJson<String>(multimediaId),
      'useAs': serializer
          .toJson<int>($MultimediaMappingTable.$converteruseAs.toJson(useAs)),
    };
  }

  MultimediaMappingData copyWith(
          {Value<String?> plotId = const Value.absent(),
          Value<String?> assetId = const Value.absent(),
          String? multimediaId,
          MultimediaCategory? useAs}) =>
      MultimediaMappingData(
        plotId: plotId.present ? plotId.value : this.plotId,
        assetId: assetId.present ? assetId.value : this.assetId,
        multimediaId: multimediaId ?? this.multimediaId,
        useAs: useAs ?? this.useAs,
      );
  MultimediaMappingData copyWithCompanion(MultimediaMappingCompanion data) {
    return MultimediaMappingData(
      plotId: data.plotId.present ? data.plotId.value : this.plotId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      multimediaId: data.multimediaId.present
          ? data.multimediaId.value
          : this.multimediaId,
      useAs: data.useAs.present ? data.useAs.value : this.useAs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MultimediaMappingData(')
          ..write('plotId: $plotId, ')
          ..write('assetId: $assetId, ')
          ..write('multimediaId: $multimediaId, ')
          ..write('useAs: $useAs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(plotId, assetId, multimediaId, useAs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MultimediaMappingData &&
          other.plotId == this.plotId &&
          other.assetId == this.assetId &&
          other.multimediaId == this.multimediaId &&
          other.useAs == this.useAs);
}

class MultimediaMappingCompanion
    extends UpdateCompanion<MultimediaMappingData> {
  final Value<String?> plotId;
  final Value<String?> assetId;
  final Value<String> multimediaId;
  final Value<MultimediaCategory> useAs;
  final Value<int> rowid;
  const MultimediaMappingCompanion({
    this.plotId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.multimediaId = const Value.absent(),
    this.useAs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MultimediaMappingCompanion.insert({
    this.plotId = const Value.absent(),
    this.assetId = const Value.absent(),
    required String multimediaId,
    required MultimediaCategory useAs,
    this.rowid = const Value.absent(),
  })  : multimediaId = Value(multimediaId),
        useAs = Value(useAs);
  static Insertable<MultimediaMappingData> custom({
    Expression<String>? plotId,
    Expression<String>? assetId,
    Expression<String>? multimediaId,
    Expression<int>? useAs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (plotId != null) 'plot_id': plotId,
      if (assetId != null) 'asset_id': assetId,
      if (multimediaId != null) 'multimedia_id': multimediaId,
      if (useAs != null) 'use_as': useAs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MultimediaMappingCompanion copyWith(
      {Value<String?>? plotId,
      Value<String?>? assetId,
      Value<String>? multimediaId,
      Value<MultimediaCategory>? useAs,
      Value<int>? rowid}) {
    return MultimediaMappingCompanion(
      plotId: plotId ?? this.plotId,
      assetId: assetId ?? this.assetId,
      multimediaId: multimediaId ?? this.multimediaId,
      useAs: useAs ?? this.useAs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (plotId.present) {
      map['plot_id'] = Variable<String>(plotId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (multimediaId.present) {
      map['multimedia_id'] = Variable<String>(multimediaId.value);
    }
    if (useAs.present) {
      map['use_as'] = Variable<int>(
          $MultimediaMappingTable.$converteruseAs.toSql(useAs.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MultimediaMappingCompanion(')
          ..write('plotId: $plotId, ')
          ..write('assetId: $assetId, ')
          ..write('multimediaId: $multimediaId, ')
          ..write('useAs: $useAs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContentAndConfigTable extends ContentAndConfig
    with TableInfo<$ContentAndConfigTable, ContentAndConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentAndConfigTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumnWithTypeConverter<ContentConfigKeys, String> key =
      GeneratedColumn<String>('key', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ContentConfigKeys>(
              $ContentAndConfigTable.$converterkey);
  static const VerificationMeta _valueEnMeta =
      const VerificationMeta('valueEn');
  @override
  late final GeneratedColumn<String> valueEn = GeneratedColumn<String>(
      'value_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueArMeta =
      const VerificationMeta('valueAr');
  @override
  late final GeneratedColumn<String> valueAr = GeneratedColumn<String>(
      'value_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, valueEn, valueAr];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_and_config';
  @override
  VerificationContext validateIntegrity(
      Insertable<ContentAndConfigData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_keyMeta, const VerificationResult.success());
    if (data.containsKey('value_en')) {
      context.handle(_valueEnMeta,
          valueEn.isAcceptableOrUnknown(data['value_en']!, _valueEnMeta));
    } else if (isInserting) {
      context.missing(_valueEnMeta);
    }
    if (data.containsKey('value_ar')) {
      context.handle(_valueArMeta,
          valueAr.isAcceptableOrUnknown(data['value_ar']!, _valueArMeta));
    } else if (isInserting) {
      context.missing(_valueArMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  ContentAndConfigData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentAndConfigData(
      key: $ContentAndConfigTable.$converterkey.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!),
      valueEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value_en'])!,
      valueAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value_ar'])!,
    );
  }

  @override
  $ContentAndConfigTable createAlias(String alias) {
    return $ContentAndConfigTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContentConfigKeys, String, String> $converterkey =
      const EnumNameConverter<ContentConfigKeys>(ContentConfigKeys.values);
}

class ContentAndConfigData extends DataClass
    implements Insertable<ContentAndConfigData> {
  final ContentConfigKeys key;
  final String valueEn;
  final String valueAr;
  const ContentAndConfigData(
      {required this.key, required this.valueEn, required this.valueAr});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['key'] =
          Variable<String>($ContentAndConfigTable.$converterkey.toSql(key));
    }
    map['value_en'] = Variable<String>(valueEn);
    map['value_ar'] = Variable<String>(valueAr);
    return map;
  }

  ContentAndConfigCompanion toCompanion(bool nullToAbsent) {
    return ContentAndConfigCompanion(
      key: Value(key),
      valueEn: Value(valueEn),
      valueAr: Value(valueAr),
    );
  }

  factory ContentAndConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentAndConfigData(
      key: $ContentAndConfigTable.$converterkey
          .fromJson(serializer.fromJson<String>(json['key'])),
      valueEn: serializer.fromJson<String>(json['valueEn']),
      valueAr: serializer.fromJson<String>(json['valueAr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer
          .toJson<String>($ContentAndConfigTable.$converterkey.toJson(key)),
      'valueEn': serializer.toJson<String>(valueEn),
      'valueAr': serializer.toJson<String>(valueAr),
    };
  }

  ContentAndConfigData copyWith(
          {ContentConfigKeys? key, String? valueEn, String? valueAr}) =>
      ContentAndConfigData(
        key: key ?? this.key,
        valueEn: valueEn ?? this.valueEn,
        valueAr: valueAr ?? this.valueAr,
      );
  ContentAndConfigData copyWithCompanion(ContentAndConfigCompanion data) {
    return ContentAndConfigData(
      key: data.key.present ? data.key.value : this.key,
      valueEn: data.valueEn.present ? data.valueEn.value : this.valueEn,
      valueAr: data.valueAr.present ? data.valueAr.value : this.valueAr,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentAndConfigData(')
          ..write('key: $key, ')
          ..write('valueEn: $valueEn, ')
          ..write('valueAr: $valueAr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, valueEn, valueAr);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentAndConfigData &&
          other.key == this.key &&
          other.valueEn == this.valueEn &&
          other.valueAr == this.valueAr);
}

class ContentAndConfigCompanion extends UpdateCompanion<ContentAndConfigData> {
  final Value<ContentConfigKeys> key;
  final Value<String> valueEn;
  final Value<String> valueAr;
  final Value<int> rowid;
  const ContentAndConfigCompanion({
    this.key = const Value.absent(),
    this.valueEn = const Value.absent(),
    this.valueAr = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentAndConfigCompanion.insert({
    required ContentConfigKeys key,
    required String valueEn,
    required String valueAr,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        valueEn = Value(valueEn),
        valueAr = Value(valueAr);
  static Insertable<ContentAndConfigData> custom({
    Expression<String>? key,
    Expression<String>? valueEn,
    Expression<String>? valueAr,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (valueEn != null) 'value_en': valueEn,
      if (valueAr != null) 'value_ar': valueAr,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentAndConfigCompanion copyWith(
      {Value<ContentConfigKeys>? key,
      Value<String>? valueEn,
      Value<String>? valueAr,
      Value<int>? rowid}) {
    return ContentAndConfigCompanion(
      key: key ?? this.key,
      valueEn: valueEn ?? this.valueEn,
      valueAr: valueAr ?? this.valueAr,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(
          $ContentAndConfigTable.$converterkey.toSql(key.value));
    }
    if (valueEn.present) {
      map['value_en'] = Variable<String>(valueEn.value);
    }
    if (valueAr.present) {
      map['value_ar'] = Variable<String>(valueAr.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentAndConfigCompanion(')
          ..write('key: $key, ')
          ..write('valueEn: $valueEn, ')
          ..write('valueAr: $valueAr, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$WSADatabase extends GeneratedDatabase {
  _$WSADatabase(QueryExecutor e) : super(e);
  $WSADatabaseManager get managers => $WSADatabaseManager(this);
  late final $SyncStatusTblTable syncStatusTbl = $SyncStatusTblTable(this);
  late final $PlotTable plot = $PlotTable(this);
  late final $AssetTable asset = $AssetTable(this);
  late final $MultimediaTable multimedia = $MultimediaTable(this);
  late final $MediaTable media = $MediaTable(this);
  late final $MultimediaMappingTable multimediaMapping =
      $MultimediaMappingTable(this);
  late final $ContentAndConfigTable contentAndConfig =
      $ContentAndConfigTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        syncStatusTbl,
        plot,
        asset,
        multimedia,
        media,
        multimediaMapping,
        contentAndConfig
      ];
}

typedef $$SyncStatusTblTableCreateCompanionBuilder = SyncStatusTblCompanion
    Function({
  Value<SyncType> syncType,
  required DateTime syncedAt,
});
typedef $$SyncStatusTblTableUpdateCompanionBuilder = SyncStatusTblCompanion
    Function({
  Value<SyncType> syncType,
  Value<DateTime> syncedAt,
});

class $$SyncStatusTblTableFilterComposer
    extends FilterComposer<_$WSADatabase, $SyncStatusTblTable> {
  $$SyncStatusTblTableFilterComposer(super.$state);
  ColumnWithTypeConverterFilters<SyncType, SyncType, int> get syncType =>
      $state.composableBuilder(
          column: $state.table.syncType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get syncedAt => $state.composableBuilder(
      column: $state.table.syncedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SyncStatusTblTableOrderingComposer
    extends OrderingComposer<_$WSADatabase, $SyncStatusTblTable> {
  $$SyncStatusTblTableOrderingComposer(super.$state);
  ColumnOrderings<int> get syncType => $state.composableBuilder(
      column: $state.table.syncType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get syncedAt => $state.composableBuilder(
      column: $state.table.syncedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$SyncStatusTblTableTableManager extends RootTableManager<
    _$WSADatabase,
    $SyncStatusTblTable,
    SyncStatusTblData,
    $$SyncStatusTblTableFilterComposer,
    $$SyncStatusTblTableOrderingComposer,
    $$SyncStatusTblTableCreateCompanionBuilder,
    $$SyncStatusTblTableUpdateCompanionBuilder,
    (
      SyncStatusTblData,
      BaseReferences<_$WSADatabase, $SyncStatusTblTable, SyncStatusTblData>
    ),
    SyncStatusTblData,
    PrefetchHooks Function()> {
  $$SyncStatusTblTableTableManager(_$WSADatabase db, $SyncStatusTblTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SyncStatusTblTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SyncStatusTblTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<SyncType> syncType = const Value.absent(),
            Value<DateTime> syncedAt = const Value.absent(),
          }) =>
              SyncStatusTblCompanion(
            syncType: syncType,
            syncedAt: syncedAt,
          ),
          createCompanionCallback: ({
            Value<SyncType> syncType = const Value.absent(),
            required DateTime syncedAt,
          }) =>
              SyncStatusTblCompanion.insert(
            syncType: syncType,
            syncedAt: syncedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncStatusTblTableProcessedTableManager = ProcessedTableManager<
    _$WSADatabase,
    $SyncStatusTblTable,
    SyncStatusTblData,
    $$SyncStatusTblTableFilterComposer,
    $$SyncStatusTblTableOrderingComposer,
    $$SyncStatusTblTableCreateCompanionBuilder,
    $$SyncStatusTblTableUpdateCompanionBuilder,
    (
      SyncStatusTblData,
      BaseReferences<_$WSADatabase, $SyncStatusTblTable, SyncStatusTblData>
    ),
    SyncStatusTblData,
    PrefetchHooks Function()>;
typedef $$PlotTableCreateCompanionBuilder = PlotCompanion Function({
  required String id,
  required bool isPlotSold,
  required bool isPropertyPlot,
  required bool isPlotUnavailableOrInNegotiation,
  required int xCoordinate,
  required int yCoordinate,
  required String plotArea,
  required String plotNumber,
  required String plotCharacteristics,
  required DateTime sysUpdateAt,
  Value<int> rowid,
});
typedef $$PlotTableUpdateCompanionBuilder = PlotCompanion Function({
  Value<String> id,
  Value<bool> isPlotSold,
  Value<bool> isPropertyPlot,
  Value<bool> isPlotUnavailableOrInNegotiation,
  Value<int> xCoordinate,
  Value<int> yCoordinate,
  Value<String> plotArea,
  Value<String> plotNumber,
  Value<String> plotCharacteristics,
  Value<DateTime> sysUpdateAt,
  Value<int> rowid,
});

final class $$PlotTableReferences
    extends BaseReferences<_$WSADatabase, $PlotTable, PlotData> {
  $$PlotTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MultimediaMappingTable,
      List<MultimediaMappingData>> _multimediaMappingRefsTable(
          _$WSADatabase db) =>
      MultiTypedResultKey.fromTable(db.multimediaMapping,
          aliasName:
              $_aliasNameGenerator(db.plot.id, db.multimediaMapping.plotId));

  $$MultimediaMappingTableProcessedTableManager get multimediaMappingRefs {
    final manager =
        $$MultimediaMappingTableTableManager($_db, $_db.multimediaMapping)
            .filter((f) => f.plotId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_multimediaMappingRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlotTableFilterComposer
    extends FilterComposer<_$WSADatabase, $PlotTable> {
  $$PlotTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPlotSold => $state.composableBuilder(
      column: $state.table.isPlotSold,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPropertyPlot => $state.composableBuilder(
      column: $state.table.isPropertyPlot,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPlotUnavailableOrInNegotiation =>
      $state.composableBuilder(
          column: $state.table.isPlotUnavailableOrInNegotiation,
          builder: (column, joinBuilders) =>
              ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get xCoordinate => $state.composableBuilder(
      column: $state.table.xCoordinate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get yCoordinate => $state.composableBuilder(
      column: $state.table.yCoordinate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get plotArea => $state.composableBuilder(
      column: $state.table.plotArea,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get plotNumber => $state.composableBuilder(
      column: $state.table.plotNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get plotCharacteristics => $state.composableBuilder(
      column: $state.table.plotCharacteristics,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get sysUpdateAt => $state.composableBuilder(
      column: $state.table.sysUpdateAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter multimediaMappingRefs(
      ComposableFilter Function($$MultimediaMappingTableFilterComposer f) f) {
    final $$MultimediaMappingTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.multimediaMapping,
            getReferencedColumn: (t) => t.plotId,
            builder: (joinBuilder, parentComposers) =>
                $$MultimediaMappingTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.multimediaMapping,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$PlotTableOrderingComposer
    extends OrderingComposer<_$WSADatabase, $PlotTable> {
  $$PlotTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPlotSold => $state.composableBuilder(
      column: $state.table.isPlotSold,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPropertyPlot => $state.composableBuilder(
      column: $state.table.isPropertyPlot,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPlotUnavailableOrInNegotiation =>
      $state.composableBuilder(
          column: $state.table.isPlotUnavailableOrInNegotiation,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get xCoordinate => $state.composableBuilder(
      column: $state.table.xCoordinate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get yCoordinate => $state.composableBuilder(
      column: $state.table.yCoordinate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get plotArea => $state.composableBuilder(
      column: $state.table.plotArea,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get plotNumber => $state.composableBuilder(
      column: $state.table.plotNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get plotCharacteristics => $state.composableBuilder(
      column: $state.table.plotCharacteristics,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get sysUpdateAt => $state.composableBuilder(
      column: $state.table.sysUpdateAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$PlotTableTableManager extends RootTableManager<
    _$WSADatabase,
    $PlotTable,
    PlotData,
    $$PlotTableFilterComposer,
    $$PlotTableOrderingComposer,
    $$PlotTableCreateCompanionBuilder,
    $$PlotTableUpdateCompanionBuilder,
    (PlotData, $$PlotTableReferences),
    PlotData,
    PrefetchHooks Function({bool multimediaMappingRefs})> {
  $$PlotTableTableManager(_$WSADatabase db, $PlotTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PlotTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PlotTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<bool> isPlotSold = const Value.absent(),
            Value<bool> isPropertyPlot = const Value.absent(),
            Value<bool> isPlotUnavailableOrInNegotiation = const Value.absent(),
            Value<int> xCoordinate = const Value.absent(),
            Value<int> yCoordinate = const Value.absent(),
            Value<String> plotArea = const Value.absent(),
            Value<String> plotNumber = const Value.absent(),
            Value<String> plotCharacteristics = const Value.absent(),
            Value<DateTime> sysUpdateAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlotCompanion(
            id: id,
            isPlotSold: isPlotSold,
            isPropertyPlot: isPropertyPlot,
            isPlotUnavailableOrInNegotiation: isPlotUnavailableOrInNegotiation,
            xCoordinate: xCoordinate,
            yCoordinate: yCoordinate,
            plotArea: plotArea,
            plotNumber: plotNumber,
            plotCharacteristics: plotCharacteristics,
            sysUpdateAt: sysUpdateAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required bool isPlotSold,
            required bool isPropertyPlot,
            required bool isPlotUnavailableOrInNegotiation,
            required int xCoordinate,
            required int yCoordinate,
            required String plotArea,
            required String plotNumber,
            required String plotCharacteristics,
            required DateTime sysUpdateAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlotCompanion.insert(
            id: id,
            isPlotSold: isPlotSold,
            isPropertyPlot: isPropertyPlot,
            isPlotUnavailableOrInNegotiation: isPlotUnavailableOrInNegotiation,
            xCoordinate: xCoordinate,
            yCoordinate: yCoordinate,
            plotArea: plotArea,
            plotNumber: plotNumber,
            plotCharacteristics: plotCharacteristics,
            sysUpdateAt: sysUpdateAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PlotTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({multimediaMappingRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (multimediaMappingRefs) db.multimediaMapping
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (multimediaMappingRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlotTableReferences
                            ._multimediaMappingRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlotTableReferences(db, table, p0)
                                .multimediaMappingRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.plotId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlotTableProcessedTableManager = ProcessedTableManager<
    _$WSADatabase,
    $PlotTable,
    PlotData,
    $$PlotTableFilterComposer,
    $$PlotTableOrderingComposer,
    $$PlotTableCreateCompanionBuilder,
    $$PlotTableUpdateCompanionBuilder,
    (PlotData, $$PlotTableReferences),
    PlotData,
    PrefetchHooks Function({bool multimediaMappingRefs})>;
typedef $$AssetTableCreateCompanionBuilder = AssetCompanion Function({
  required String id,
  required String assetDescription,
  required bool isPropertyPlot,
  required int xCoordinate,
  required int yCoordinate,
  required String name,
  required String assetsCategory,
  required String iconKey,
  required DateTime sysUpdateAt,
  required Language language,
  Value<int> rowid,
});
typedef $$AssetTableUpdateCompanionBuilder = AssetCompanion Function({
  Value<String> id,
  Value<String> assetDescription,
  Value<bool> isPropertyPlot,
  Value<int> xCoordinate,
  Value<int> yCoordinate,
  Value<String> name,
  Value<String> assetsCategory,
  Value<String> iconKey,
  Value<DateTime> sysUpdateAt,
  Value<Language> language,
  Value<int> rowid,
});

class $$AssetTableFilterComposer
    extends FilterComposer<_$WSADatabase, $AssetTable> {
  $$AssetTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get assetDescription => $state.composableBuilder(
      column: $state.table.assetDescription,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPropertyPlot => $state.composableBuilder(
      column: $state.table.isPropertyPlot,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get xCoordinate => $state.composableBuilder(
      column: $state.table.xCoordinate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get yCoordinate => $state.composableBuilder(
      column: $state.table.yCoordinate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get assetsCategory => $state.composableBuilder(
      column: $state.table.assetsCategory,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get iconKey => $state.composableBuilder(
      column: $state.table.iconKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get sysUpdateAt => $state.composableBuilder(
      column: $state.table.sysUpdateAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Language, Language, int> get language =>
      $state.composableBuilder(
          column: $state.table.language,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$AssetTableOrderingComposer
    extends OrderingComposer<_$WSADatabase, $AssetTable> {
  $$AssetTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get assetDescription => $state.composableBuilder(
      column: $state.table.assetDescription,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPropertyPlot => $state.composableBuilder(
      column: $state.table.isPropertyPlot,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get xCoordinate => $state.composableBuilder(
      column: $state.table.xCoordinate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get yCoordinate => $state.composableBuilder(
      column: $state.table.yCoordinate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get assetsCategory => $state.composableBuilder(
      column: $state.table.assetsCategory,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get iconKey => $state.composableBuilder(
      column: $state.table.iconKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get sysUpdateAt => $state.composableBuilder(
      column: $state.table.sysUpdateAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$AssetTableTableManager extends RootTableManager<
    _$WSADatabase,
    $AssetTable,
    AssetData,
    $$AssetTableFilterComposer,
    $$AssetTableOrderingComposer,
    $$AssetTableCreateCompanionBuilder,
    $$AssetTableUpdateCompanionBuilder,
    (AssetData, BaseReferences<_$WSADatabase, $AssetTable, AssetData>),
    AssetData,
    PrefetchHooks Function()> {
  $$AssetTableTableManager(_$WSADatabase db, $AssetTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AssetTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AssetTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> assetDescription = const Value.absent(),
            Value<bool> isPropertyPlot = const Value.absent(),
            Value<int> xCoordinate = const Value.absent(),
            Value<int> yCoordinate = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> assetsCategory = const Value.absent(),
            Value<String> iconKey = const Value.absent(),
            Value<DateTime> sysUpdateAt = const Value.absent(),
            Value<Language> language = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetCompanion(
            id: id,
            assetDescription: assetDescription,
            isPropertyPlot: isPropertyPlot,
            xCoordinate: xCoordinate,
            yCoordinate: yCoordinate,
            name: name,
            assetsCategory: assetsCategory,
            iconKey: iconKey,
            sysUpdateAt: sysUpdateAt,
            language: language,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String assetDescription,
            required bool isPropertyPlot,
            required int xCoordinate,
            required int yCoordinate,
            required String name,
            required String assetsCategory,
            required String iconKey,
            required DateTime sysUpdateAt,
            required Language language,
            Value<int> rowid = const Value.absent(),
          }) =>
              AssetCompanion.insert(
            id: id,
            assetDescription: assetDescription,
            isPropertyPlot: isPropertyPlot,
            xCoordinate: xCoordinate,
            yCoordinate: yCoordinate,
            name: name,
            assetsCategory: assetsCategory,
            iconKey: iconKey,
            sysUpdateAt: sysUpdateAt,
            language: language,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AssetTableProcessedTableManager = ProcessedTableManager<
    _$WSADatabase,
    $AssetTable,
    AssetData,
    $$AssetTableFilterComposer,
    $$AssetTableOrderingComposer,
    $$AssetTableCreateCompanionBuilder,
    $$AssetTableUpdateCompanionBuilder,
    (AssetData, BaseReferences<_$WSADatabase, $AssetTable, AssetData>),
    AssetData,
    PrefetchHooks Function()>;
typedef $$MultimediaTableCreateCompanionBuilder = MultimediaCompanion Function({
  required String multimediaId,
  required String fileId,
  required String fileName,
  required String description,
  required String mimeType,
  required String remotePath,
  required DateTime sysUpdateAt,
  Value<MediaDownloadStatus?> mediaStatus,
  Value<String?> localFolder,
  Value<String?> localFileName,
  Value<String?> downloadTaskId,
  Value<int?> downloadProgress,
  Value<int> rowid,
});
typedef $$MultimediaTableUpdateCompanionBuilder = MultimediaCompanion Function({
  Value<String> multimediaId,
  Value<String> fileId,
  Value<String> fileName,
  Value<String> description,
  Value<String> mimeType,
  Value<String> remotePath,
  Value<DateTime> sysUpdateAt,
  Value<MediaDownloadStatus?> mediaStatus,
  Value<String?> localFolder,
  Value<String?> localFileName,
  Value<String?> downloadTaskId,
  Value<int?> downloadProgress,
  Value<int> rowid,
});

final class $$MultimediaTableReferences
    extends BaseReferences<_$WSADatabase, $MultimediaTable, MultimediaData> {
  $$MultimediaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MediaTable, List<MediaData>> _mediaRefsTable(
          _$WSADatabase db) =>
      MultiTypedResultKey.fromTable(db.media,
          aliasName: $_aliasNameGenerator(
              db.multimedia.multimediaId, db.media.multimediaId));

  $$MediaTableProcessedTableManager get mediaRefs {
    final manager = $$MediaTableTableManager($_db, $_db.media)
        .filter((f) => f.multimediaId.multimediaId($_item.multimediaId));

    final cache = $_typedResult.readTableOrNull(_mediaRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MultimediaMappingTable,
      List<MultimediaMappingData>> _multimediaMappingRefsTable(
          _$WSADatabase db) =>
      MultiTypedResultKey.fromTable(db.multimediaMapping,
          aliasName: $_aliasNameGenerator(
              db.multimedia.multimediaId, db.multimediaMapping.multimediaId));

  $$MultimediaMappingTableProcessedTableManager get multimediaMappingRefs {
    final manager =
        $$MultimediaMappingTableTableManager($_db, $_db.multimediaMapping)
            .filter((f) => f.multimediaId.multimediaId($_item.multimediaId));

    final cache =
        $_typedResult.readTableOrNull(_multimediaMappingRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MultimediaTableFilterComposer
    extends FilterComposer<_$WSADatabase, $MultimediaTable> {
  $$MultimediaTableFilterComposer(super.$state);
  ColumnFilters<String> get multimediaId => $state.composableBuilder(
      column: $state.table.multimediaId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fileId => $state.composableBuilder(
      column: $state.table.fileId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mimeType => $state.composableBuilder(
      column: $state.table.mimeType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get remotePath => $state.composableBuilder(
      column: $state.table.remotePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get sysUpdateAt => $state.composableBuilder(
      column: $state.table.sysUpdateAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<MediaDownloadStatus?, MediaDownloadStatus, int>
      get mediaStatus => $state.composableBuilder(
          column: $state.table.mediaStatus,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get localFolder => $state.composableBuilder(
      column: $state.table.localFolder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get localFileName => $state.composableBuilder(
      column: $state.table.localFileName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get downloadTaskId => $state.composableBuilder(
      column: $state.table.downloadTaskId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get downloadProgress => $state.composableBuilder(
      column: $state.table.downloadProgress,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter mediaRefs(
      ComposableFilter Function($$MediaTableFilterComposer f) f) {
    final $$MediaTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.multimediaId,
        referencedTable: $state.db.media,
        getReferencedColumn: (t) => t.multimediaId,
        builder: (joinBuilder, parentComposers) => $$MediaTableFilterComposer(
            ComposerState(
                $state.db, $state.db.media, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter multimediaMappingRefs(
      ComposableFilter Function($$MultimediaMappingTableFilterComposer f) f) {
    final $$MultimediaMappingTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.multimediaId,
            referencedTable: $state.db.multimediaMapping,
            getReferencedColumn: (t) => t.multimediaId,
            builder: (joinBuilder, parentComposers) =>
                $$MultimediaMappingTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.multimediaMapping,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$MultimediaTableOrderingComposer
    extends OrderingComposer<_$WSADatabase, $MultimediaTable> {
  $$MultimediaTableOrderingComposer(super.$state);
  ColumnOrderings<String> get multimediaId => $state.composableBuilder(
      column: $state.table.multimediaId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fileId => $state.composableBuilder(
      column: $state.table.fileId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fileName => $state.composableBuilder(
      column: $state.table.fileName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mimeType => $state.composableBuilder(
      column: $state.table.mimeType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get remotePath => $state.composableBuilder(
      column: $state.table.remotePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get sysUpdateAt => $state.composableBuilder(
      column: $state.table.sysUpdateAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get mediaStatus => $state.composableBuilder(
      column: $state.table.mediaStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get localFolder => $state.composableBuilder(
      column: $state.table.localFolder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get localFileName => $state.composableBuilder(
      column: $state.table.localFileName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get downloadTaskId => $state.composableBuilder(
      column: $state.table.downloadTaskId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get downloadProgress => $state.composableBuilder(
      column: $state.table.downloadProgress,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$MultimediaTableTableManager extends RootTableManager<
    _$WSADatabase,
    $MultimediaTable,
    MultimediaData,
    $$MultimediaTableFilterComposer,
    $$MultimediaTableOrderingComposer,
    $$MultimediaTableCreateCompanionBuilder,
    $$MultimediaTableUpdateCompanionBuilder,
    (MultimediaData, $$MultimediaTableReferences),
    MultimediaData,
    PrefetchHooks Function({bool mediaRefs, bool multimediaMappingRefs})> {
  $$MultimediaTableTableManager(_$WSADatabase db, $MultimediaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MultimediaTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MultimediaTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> multimediaId = const Value.absent(),
            Value<String> fileId = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> mimeType = const Value.absent(),
            Value<String> remotePath = const Value.absent(),
            Value<DateTime> sysUpdateAt = const Value.absent(),
            Value<MediaDownloadStatus?> mediaStatus = const Value.absent(),
            Value<String?> localFolder = const Value.absent(),
            Value<String?> localFileName = const Value.absent(),
            Value<String?> downloadTaskId = const Value.absent(),
            Value<int?> downloadProgress = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MultimediaCompanion(
            multimediaId: multimediaId,
            fileId: fileId,
            fileName: fileName,
            description: description,
            mimeType: mimeType,
            remotePath: remotePath,
            sysUpdateAt: sysUpdateAt,
            mediaStatus: mediaStatus,
            localFolder: localFolder,
            localFileName: localFileName,
            downloadTaskId: downloadTaskId,
            downloadProgress: downloadProgress,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String multimediaId,
            required String fileId,
            required String fileName,
            required String description,
            required String mimeType,
            required String remotePath,
            required DateTime sysUpdateAt,
            Value<MediaDownloadStatus?> mediaStatus = const Value.absent(),
            Value<String?> localFolder = const Value.absent(),
            Value<String?> localFileName = const Value.absent(),
            Value<String?> downloadTaskId = const Value.absent(),
            Value<int?> downloadProgress = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MultimediaCompanion.insert(
            multimediaId: multimediaId,
            fileId: fileId,
            fileName: fileName,
            description: description,
            mimeType: mimeType,
            remotePath: remotePath,
            sysUpdateAt: sysUpdateAt,
            mediaStatus: mediaStatus,
            localFolder: localFolder,
            localFileName: localFileName,
            downloadTaskId: downloadTaskId,
            downloadProgress: downloadProgress,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MultimediaTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {mediaRefs = false, multimediaMappingRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mediaRefs) db.media,
                if (multimediaMappingRefs) db.multimediaMapping
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mediaRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MultimediaTableReferences._mediaRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MultimediaTableReferences(db, table, p0)
                                .mediaRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.multimediaId == item.multimediaId),
                        typedResults: items),
                  if (multimediaMappingRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$MultimediaTableReferences
                            ._multimediaMappingRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MultimediaTableReferences(db, table, p0)
                                .multimediaMappingRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.multimediaId == item.multimediaId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MultimediaTableProcessedTableManager = ProcessedTableManager<
    _$WSADatabase,
    $MultimediaTable,
    MultimediaData,
    $$MultimediaTableFilterComposer,
    $$MultimediaTableOrderingComposer,
    $$MultimediaTableCreateCompanionBuilder,
    $$MultimediaTableUpdateCompanionBuilder,
    (MultimediaData, $$MultimediaTableReferences),
    MultimediaData,
    PrefetchHooks Function({bool mediaRefs, bool multimediaMappingRefs})>;
typedef $$MediaTableCreateCompanionBuilder = MediaCompanion Function({
  required String mediaId,
  required String multimediaId,
  required int mediaOrder,
  required String title,
  required String subTitle,
  required String categoryId,
  required String categoryLabel,
  required int categoryOrder,
  required String subCategoryId,
  required String subCategoryLabel,
  required int subCategoryOrder,
  required DateTime sysUpdateAt,
  required Language language,
  Value<int> rowid,
});
typedef $$MediaTableUpdateCompanionBuilder = MediaCompanion Function({
  Value<String> mediaId,
  Value<String> multimediaId,
  Value<int> mediaOrder,
  Value<String> title,
  Value<String> subTitle,
  Value<String> categoryId,
  Value<String> categoryLabel,
  Value<int> categoryOrder,
  Value<String> subCategoryId,
  Value<String> subCategoryLabel,
  Value<int> subCategoryOrder,
  Value<DateTime> sysUpdateAt,
  Value<Language> language,
  Value<int> rowid,
});

final class $$MediaTableReferences
    extends BaseReferences<_$WSADatabase, $MediaTable, MediaData> {
  $$MediaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MultimediaTable _multimediaIdTable(_$WSADatabase db) =>
      db.multimedia.createAlias($_aliasNameGenerator(
          db.media.multimediaId, db.multimedia.multimediaId));

  $$MultimediaTableProcessedTableManager? get multimediaId {
    if ($_item.multimediaId == null) return null;
    final manager = $$MultimediaTableTableManager($_db, $_db.multimedia)
        .filter((f) => f.multimediaId($_item.multimediaId!));
    final item = $_typedResult.readTableOrNull(_multimediaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MediaTableFilterComposer
    extends FilterComposer<_$WSADatabase, $MediaTable> {
  $$MediaTableFilterComposer(super.$state);
  ColumnFilters<String> get mediaId => $state.composableBuilder(
      column: $state.table.mediaId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get mediaOrder => $state.composableBuilder(
      column: $state.table.mediaOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get subTitle => $state.composableBuilder(
      column: $state.table.subTitle,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoryId => $state.composableBuilder(
      column: $state.table.categoryId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoryLabel => $state.composableBuilder(
      column: $state.table.categoryLabel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get categoryOrder => $state.composableBuilder(
      column: $state.table.categoryOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get subCategoryId => $state.composableBuilder(
      column: $state.table.subCategoryId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get subCategoryLabel => $state.composableBuilder(
      column: $state.table.subCategoryLabel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get subCategoryOrder => $state.composableBuilder(
      column: $state.table.subCategoryOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get sysUpdateAt => $state.composableBuilder(
      column: $state.table.sysUpdateAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Language, Language, int> get language =>
      $state.composableBuilder(
          column: $state.table.language,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  $$MultimediaTableFilterComposer get multimediaId {
    final $$MultimediaTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.multimediaId,
        referencedTable: $state.db.multimedia,
        getReferencedColumn: (t) => t.multimediaId,
        builder: (joinBuilder, parentComposers) =>
            $$MultimediaTableFilterComposer(ComposerState($state.db,
                $state.db.multimedia, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$MediaTableOrderingComposer
    extends OrderingComposer<_$WSADatabase, $MediaTable> {
  $$MediaTableOrderingComposer(super.$state);
  ColumnOrderings<String> get mediaId => $state.composableBuilder(
      column: $state.table.mediaId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get mediaOrder => $state.composableBuilder(
      column: $state.table.mediaOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get subTitle => $state.composableBuilder(
      column: $state.table.subTitle,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoryId => $state.composableBuilder(
      column: $state.table.categoryId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoryLabel => $state.composableBuilder(
      column: $state.table.categoryLabel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get categoryOrder => $state.composableBuilder(
      column: $state.table.categoryOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get subCategoryId => $state.composableBuilder(
      column: $state.table.subCategoryId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get subCategoryLabel => $state.composableBuilder(
      column: $state.table.subCategoryLabel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get subCategoryOrder => $state.composableBuilder(
      column: $state.table.subCategoryOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get sysUpdateAt => $state.composableBuilder(
      column: $state.table.sysUpdateAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$MultimediaTableOrderingComposer get multimediaId {
    final $$MultimediaTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.multimediaId,
        referencedTable: $state.db.multimedia,
        getReferencedColumn: (t) => t.multimediaId,
        builder: (joinBuilder, parentComposers) =>
            $$MultimediaTableOrderingComposer(ComposerState($state.db,
                $state.db.multimedia, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$MediaTableTableManager extends RootTableManager<
    _$WSADatabase,
    $MediaTable,
    MediaData,
    $$MediaTableFilterComposer,
    $$MediaTableOrderingComposer,
    $$MediaTableCreateCompanionBuilder,
    $$MediaTableUpdateCompanionBuilder,
    (MediaData, $$MediaTableReferences),
    MediaData,
    PrefetchHooks Function({bool multimediaId})> {
  $$MediaTableTableManager(_$WSADatabase db, $MediaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MediaTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MediaTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> mediaId = const Value.absent(),
            Value<String> multimediaId = const Value.absent(),
            Value<int> mediaOrder = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> subTitle = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String> categoryLabel = const Value.absent(),
            Value<int> categoryOrder = const Value.absent(),
            Value<String> subCategoryId = const Value.absent(),
            Value<String> subCategoryLabel = const Value.absent(),
            Value<int> subCategoryOrder = const Value.absent(),
            Value<DateTime> sysUpdateAt = const Value.absent(),
            Value<Language> language = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaCompanion(
            mediaId: mediaId,
            multimediaId: multimediaId,
            mediaOrder: mediaOrder,
            title: title,
            subTitle: subTitle,
            categoryId: categoryId,
            categoryLabel: categoryLabel,
            categoryOrder: categoryOrder,
            subCategoryId: subCategoryId,
            subCategoryLabel: subCategoryLabel,
            subCategoryOrder: subCategoryOrder,
            sysUpdateAt: sysUpdateAt,
            language: language,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String mediaId,
            required String multimediaId,
            required int mediaOrder,
            required String title,
            required String subTitle,
            required String categoryId,
            required String categoryLabel,
            required int categoryOrder,
            required String subCategoryId,
            required String subCategoryLabel,
            required int subCategoryOrder,
            required DateTime sysUpdateAt,
            required Language language,
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaCompanion.insert(
            mediaId: mediaId,
            multimediaId: multimediaId,
            mediaOrder: mediaOrder,
            title: title,
            subTitle: subTitle,
            categoryId: categoryId,
            categoryLabel: categoryLabel,
            categoryOrder: categoryOrder,
            subCategoryId: subCategoryId,
            subCategoryLabel: subCategoryLabel,
            subCategoryOrder: subCategoryOrder,
            sysUpdateAt: sysUpdateAt,
            language: language,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MediaTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({multimediaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (multimediaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.multimediaId,
                    referencedTable:
                        $$MediaTableReferences._multimediaIdTable(db),
                    referencedColumn: $$MediaTableReferences
                        ._multimediaIdTable(db)
                        .multimediaId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MediaTableProcessedTableManager = ProcessedTableManager<
    _$WSADatabase,
    $MediaTable,
    MediaData,
    $$MediaTableFilterComposer,
    $$MediaTableOrderingComposer,
    $$MediaTableCreateCompanionBuilder,
    $$MediaTableUpdateCompanionBuilder,
    (MediaData, $$MediaTableReferences),
    MediaData,
    PrefetchHooks Function({bool multimediaId})>;
typedef $$MultimediaMappingTableCreateCompanionBuilder
    = MultimediaMappingCompanion Function({
  Value<String?> plotId,
  Value<String?> assetId,
  required String multimediaId,
  required MultimediaCategory useAs,
  Value<int> rowid,
});
typedef $$MultimediaMappingTableUpdateCompanionBuilder
    = MultimediaMappingCompanion Function({
  Value<String?> plotId,
  Value<String?> assetId,
  Value<String> multimediaId,
  Value<MultimediaCategory> useAs,
  Value<int> rowid,
});

final class $$MultimediaMappingTableReferences extends BaseReferences<
    _$WSADatabase, $MultimediaMappingTable, MultimediaMappingData> {
  $$MultimediaMappingTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlotTable _plotIdTable(_$WSADatabase db) => db.plot.createAlias(
      $_aliasNameGenerator(db.multimediaMapping.plotId, db.plot.id));

  $$PlotTableProcessedTableManager? get plotId {
    if ($_item.plotId == null) return null;
    final manager = $$PlotTableTableManager($_db, $_db.plot)
        .filter((f) => f.id($_item.plotId!));
    final item = $_typedResult.readTableOrNull(_plotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MultimediaTable _multimediaIdTable(_$WSADatabase db) =>
      db.multimedia.createAlias($_aliasNameGenerator(
          db.multimediaMapping.multimediaId, db.multimedia.multimediaId));

  $$MultimediaTableProcessedTableManager? get multimediaId {
    if ($_item.multimediaId == null) return null;
    final manager = $$MultimediaTableTableManager($_db, $_db.multimedia)
        .filter((f) => f.multimediaId($_item.multimediaId!));
    final item = $_typedResult.readTableOrNull(_multimediaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MultimediaMappingTableFilterComposer
    extends FilterComposer<_$WSADatabase, $MultimediaMappingTable> {
  $$MultimediaMappingTableFilterComposer(super.$state);
  ColumnFilters<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<MultimediaCategory, MultimediaCategory, int>
      get useAs => $state.composableBuilder(
          column: $state.table.useAs,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  $$PlotTableFilterComposer get plotId {
    final $$PlotTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plotId,
        referencedTable: $state.db.plot,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$PlotTableFilterComposer(
            ComposerState(
                $state.db, $state.db.plot, joinBuilder, parentComposers)));
    return composer;
  }

  $$MultimediaTableFilterComposer get multimediaId {
    final $$MultimediaTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.multimediaId,
        referencedTable: $state.db.multimedia,
        getReferencedColumn: (t) => t.multimediaId,
        builder: (joinBuilder, parentComposers) =>
            $$MultimediaTableFilterComposer(ComposerState($state.db,
                $state.db.multimedia, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$MultimediaMappingTableOrderingComposer
    extends OrderingComposer<_$WSADatabase, $MultimediaMappingTable> {
  $$MultimediaMappingTableOrderingComposer(super.$state);
  ColumnOrderings<String> get assetId => $state.composableBuilder(
      column: $state.table.assetId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get useAs => $state.composableBuilder(
      column: $state.table.useAs,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PlotTableOrderingComposer get plotId {
    final $$PlotTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plotId,
        referencedTable: $state.db.plot,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$PlotTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.plot, joinBuilder, parentComposers)));
    return composer;
  }

  $$MultimediaTableOrderingComposer get multimediaId {
    final $$MultimediaTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.multimediaId,
        referencedTable: $state.db.multimedia,
        getReferencedColumn: (t) => t.multimediaId,
        builder: (joinBuilder, parentComposers) =>
            $$MultimediaTableOrderingComposer(ComposerState($state.db,
                $state.db.multimedia, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$MultimediaMappingTableTableManager extends RootTableManager<
    _$WSADatabase,
    $MultimediaMappingTable,
    MultimediaMappingData,
    $$MultimediaMappingTableFilterComposer,
    $$MultimediaMappingTableOrderingComposer,
    $$MultimediaMappingTableCreateCompanionBuilder,
    $$MultimediaMappingTableUpdateCompanionBuilder,
    (MultimediaMappingData, $$MultimediaMappingTableReferences),
    MultimediaMappingData,
    PrefetchHooks Function({bool plotId, bool multimediaId})> {
  $$MultimediaMappingTableTableManager(
      _$WSADatabase db, $MultimediaMappingTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MultimediaMappingTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$MultimediaMappingTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String?> plotId = const Value.absent(),
            Value<String?> assetId = const Value.absent(),
            Value<String> multimediaId = const Value.absent(),
            Value<MultimediaCategory> useAs = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MultimediaMappingCompanion(
            plotId: plotId,
            assetId: assetId,
            multimediaId: multimediaId,
            useAs: useAs,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> plotId = const Value.absent(),
            Value<String?> assetId = const Value.absent(),
            required String multimediaId,
            required MultimediaCategory useAs,
            Value<int> rowid = const Value.absent(),
          }) =>
              MultimediaMappingCompanion.insert(
            plotId: plotId,
            assetId: assetId,
            multimediaId: multimediaId,
            useAs: useAs,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MultimediaMappingTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({plotId = false, multimediaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (plotId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.plotId,
                    referencedTable:
                        $$MultimediaMappingTableReferences._plotIdTable(db),
                    referencedColumn:
                        $$MultimediaMappingTableReferences._plotIdTable(db).id,
                  ) as T;
                }
                if (multimediaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.multimediaId,
                    referencedTable: $$MultimediaMappingTableReferences
                        ._multimediaIdTable(db),
                    referencedColumn: $$MultimediaMappingTableReferences
                        ._multimediaIdTable(db)
                        .multimediaId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MultimediaMappingTableProcessedTableManager = ProcessedTableManager<
    _$WSADatabase,
    $MultimediaMappingTable,
    MultimediaMappingData,
    $$MultimediaMappingTableFilterComposer,
    $$MultimediaMappingTableOrderingComposer,
    $$MultimediaMappingTableCreateCompanionBuilder,
    $$MultimediaMappingTableUpdateCompanionBuilder,
    (MultimediaMappingData, $$MultimediaMappingTableReferences),
    MultimediaMappingData,
    PrefetchHooks Function({bool plotId, bool multimediaId})>;
typedef $$ContentAndConfigTableCreateCompanionBuilder
    = ContentAndConfigCompanion Function({
  required ContentConfigKeys key,
  required String valueEn,
  required String valueAr,
  Value<int> rowid,
});
typedef $$ContentAndConfigTableUpdateCompanionBuilder
    = ContentAndConfigCompanion Function({
  Value<ContentConfigKeys> key,
  Value<String> valueEn,
  Value<String> valueAr,
  Value<int> rowid,
});

class $$ContentAndConfigTableFilterComposer
    extends FilterComposer<_$WSADatabase, $ContentAndConfigTable> {
  $$ContentAndConfigTableFilterComposer(super.$state);
  ColumnWithTypeConverterFilters<ContentConfigKeys, ContentConfigKeys, String>
      get key => $state.composableBuilder(
          column: $state.table.key,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get valueEn => $state.composableBuilder(
      column: $state.table.valueEn,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get valueAr => $state.composableBuilder(
      column: $state.table.valueAr,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ContentAndConfigTableOrderingComposer
    extends OrderingComposer<_$WSADatabase, $ContentAndConfigTable> {
  $$ContentAndConfigTableOrderingComposer(super.$state);
  ColumnOrderings<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get valueEn => $state.composableBuilder(
      column: $state.table.valueEn,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get valueAr => $state.composableBuilder(
      column: $state.table.valueAr,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$ContentAndConfigTableTableManager extends RootTableManager<
    _$WSADatabase,
    $ContentAndConfigTable,
    ContentAndConfigData,
    $$ContentAndConfigTableFilterComposer,
    $$ContentAndConfigTableOrderingComposer,
    $$ContentAndConfigTableCreateCompanionBuilder,
    $$ContentAndConfigTableUpdateCompanionBuilder,
    (
      ContentAndConfigData,
      BaseReferences<_$WSADatabase, $ContentAndConfigTable,
          ContentAndConfigData>
    ),
    ContentAndConfigData,
    PrefetchHooks Function()> {
  $$ContentAndConfigTableTableManager(
      _$WSADatabase db, $ContentAndConfigTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ContentAndConfigTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ContentAndConfigTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<ContentConfigKeys> key = const Value.absent(),
            Value<String> valueEn = const Value.absent(),
            Value<String> valueAr = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ContentAndConfigCompanion(
            key: key,
            valueEn: valueEn,
            valueAr: valueAr,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required ContentConfigKeys key,
            required String valueEn,
            required String valueAr,
            Value<int> rowid = const Value.absent(),
          }) =>
              ContentAndConfigCompanion.insert(
            key: key,
            valueEn: valueEn,
            valueAr: valueAr,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ContentAndConfigTableProcessedTableManager = ProcessedTableManager<
    _$WSADatabase,
    $ContentAndConfigTable,
    ContentAndConfigData,
    $$ContentAndConfigTableFilterComposer,
    $$ContentAndConfigTableOrderingComposer,
    $$ContentAndConfigTableCreateCompanionBuilder,
    $$ContentAndConfigTableUpdateCompanionBuilder,
    (
      ContentAndConfigData,
      BaseReferences<_$WSADatabase, $ContentAndConfigTable,
          ContentAndConfigData>
    ),
    ContentAndConfigData,
    PrefetchHooks Function()>;

class $WSADatabaseManager {
  final _$WSADatabase _db;
  $WSADatabaseManager(this._db);
  $$SyncStatusTblTableTableManager get syncStatusTbl =>
      $$SyncStatusTblTableTableManager(_db, _db.syncStatusTbl);
  $$PlotTableTableManager get plot => $$PlotTableTableManager(_db, _db.plot);
  $$AssetTableTableManager get asset =>
      $$AssetTableTableManager(_db, _db.asset);
  $$MultimediaTableTableManager get multimedia =>
      $$MultimediaTableTableManager(_db, _db.multimedia);
  $$MediaTableTableManager get media =>
      $$MediaTableTableManager(_db, _db.media);
  $$MultimediaMappingTableTableManager get multimediaMapping =>
      $$MultimediaMappingTableTableManager(_db, _db.multimediaMapping);
  $$ContentAndConfigTableTableManager get contentAndConfig =>
      $$ContentAndConfigTableTableManager(_db, _db.contentAndConfig);
}
