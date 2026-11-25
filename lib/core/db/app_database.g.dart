// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingRow extends DataClass implements Insertable<SettingRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String key;
  final String value;
  const SettingRow({
    required this.createdAt,
    required this.updatedAt,
    required this.key,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      key: Value(key),
      value: Value(value),
    );
  }

  factory SettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? key,
    String? value,
  }) => SettingRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    key: key ?? this.key,
    value: value ?? this.value,
  );
  SettingRow copyWithCompanion(SettingsCompanion data) {
    return SettingRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<SettingRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HorsesTable extends Horses with TableInfo<$HorsesTable, HorseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HorsesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _callNameMeta = const VerificationMeta(
    'callName',
  );
  @override
  late final GeneratedColumn<String> callName = GeneratedColumn<String>(
    'call_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate?, String> birthDate =
      GeneratedColumn<String>(
        'birth_date',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<LocalDate?>($HorsesTable.$converterbirthDaten);
  static const VerificationMeta _birthdayReminderMeta = const VerificationMeta(
    'birthdayReminder',
  );
  @override
  late final GeneratedColumn<bool> birthdayReminder = GeneratedColumn<bool>(
    'birthday_reminder',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("birthday_reminder" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMarkingsMeta = const VerificationMeta(
    'colorMarkings',
  );
  @override
  late final GeneratedColumn<String> colorMarkings = GeneratedColumn<String>(
    'color_markings',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<int> heightCm = GeneratedColumn<int>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uelnMeta = const VerificationMeta('ueln');
  @override
  late final GeneratedColumn<String> ueln = GeneratedColumn<String>(
    'ueln',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chipNumberMeta = const VerificationMeta(
    'chipNumber',
  );
  @override
  late final GeneratedColumn<String> chipNumber = GeneratedColumn<String>(
    'chip_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passportNumberMeta = const VerificationMeta(
    'passportNumber',
  );
  @override
  late final GeneratedColumn<String> passportNumber = GeneratedColumn<String>(
    'passport_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sireMeta = const VerificationMeta('sire');
  @override
  late final GeneratedColumn<String> sire = GeneratedColumn<String>(
    'sire',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _damMeta = const VerificationMeta('dam');
  @override
  late final GeneratedColumn<String> dam = GeneratedColumn<String>(
    'dam',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stableLocationMeta = const VerificationMeta(
    'stableLocation',
  );
  @override
  late final GeneratedColumn<String> stableLocation = GeneratedColumn<String>(
    'stable_location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keepingTypeMeta = const VerificationMeta(
    'keepingType',
  );
  @override
  late final GeneratedColumn<String> keepingType = GeneratedColumn<String>(
    'keeping_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
    'owner',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _insuranceMeta = const VerificationMeta(
    'insurance',
  );
  @override
  late final GeneratedColumn<String> insurance = GeneratedColumn<String>(
    'insurance',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intolerancesMeta = const VerificationMeta(
    'intolerances',
  );
  @override
  late final GeneratedColumn<String> intolerances = GeneratedColumn<String>(
    'intolerances',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _medicalHistoryMeta = const VerificationMeta(
    'medicalHistory',
  );
  @override
  late final GeneratedColumn<String> medicalHistory = GeneratedColumn<String>(
    'medical_history',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profilePhotoIdMeta = const VerificationMeta(
    'profilePhotoId',
  );
  @override
  late final GeneratedColumn<String> profilePhotoId = GeneratedColumn<String>(
    'profile_photo_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    name,
    callName,
    birthDate,
    birthdayReminder,
    sex,
    breed,
    colorMarkings,
    heightCm,
    ueln,
    chipNumber,
    passportNumber,
    sire,
    dam,
    stableLocation,
    keepingType,
    owner,
    insurance,
    intolerances,
    medicalHistory,
    notes,
    profilePhotoId,
    archivedAt,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'horses';
  @override
  VerificationContext validateIntegrity(
    Insertable<HorseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('call_name')) {
      context.handle(
        _callNameMeta,
        callName.isAcceptableOrUnknown(data['call_name']!, _callNameMeta),
      );
    }
    if (data.containsKey('birthday_reminder')) {
      context.handle(
        _birthdayReminderMeta,
        birthdayReminder.isAcceptableOrUnknown(
          data['birthday_reminder']!,
          _birthdayReminderMeta,
        ),
      );
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    }
    if (data.containsKey('color_markings')) {
      context.handle(
        _colorMarkingsMeta,
        colorMarkings.isAcceptableOrUnknown(
          data['color_markings']!,
          _colorMarkingsMeta,
        ),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('ueln')) {
      context.handle(
        _uelnMeta,
        ueln.isAcceptableOrUnknown(data['ueln']!, _uelnMeta),
      );
    }
    if (data.containsKey('chip_number')) {
      context.handle(
        _chipNumberMeta,
        chipNumber.isAcceptableOrUnknown(data['chip_number']!, _chipNumberMeta),
      );
    }
    if (data.containsKey('passport_number')) {
      context.handle(
        _passportNumberMeta,
        passportNumber.isAcceptableOrUnknown(
          data['passport_number']!,
          _passportNumberMeta,
        ),
      );
    }
    if (data.containsKey('sire')) {
      context.handle(
        _sireMeta,
        sire.isAcceptableOrUnknown(data['sire']!, _sireMeta),
      );
    }
    if (data.containsKey('dam')) {
      context.handle(
        _damMeta,
        dam.isAcceptableOrUnknown(data['dam']!, _damMeta),
      );
    }
    if (data.containsKey('stable_location')) {
      context.handle(
        _stableLocationMeta,
        stableLocation.isAcceptableOrUnknown(
          data['stable_location']!,
          _stableLocationMeta,
        ),
      );
    }
    if (data.containsKey('keeping_type')) {
      context.handle(
        _keepingTypeMeta,
        keepingType.isAcceptableOrUnknown(
          data['keeping_type']!,
          _keepingTypeMeta,
        ),
      );
    }
    if (data.containsKey('owner')) {
      context.handle(
        _ownerMeta,
        owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta),
      );
    }
    if (data.containsKey('insurance')) {
      context.handle(
        _insuranceMeta,
        insurance.isAcceptableOrUnknown(data['insurance']!, _insuranceMeta),
      );
    }
    if (data.containsKey('intolerances')) {
      context.handle(
        _intolerancesMeta,
        intolerances.isAcceptableOrUnknown(
          data['intolerances']!,
          _intolerancesMeta,
        ),
      );
    }
    if (data.containsKey('medical_history')) {
      context.handle(
        _medicalHistoryMeta,
        medicalHistory.isAcceptableOrUnknown(
          data['medical_history']!,
          _medicalHistoryMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('profile_photo_id')) {
      context.handle(
        _profilePhotoIdMeta,
        profilePhotoId.isAcceptableOrUnknown(
          data['profile_photo_id']!,
          _profilePhotoIdMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HorseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HorseRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      callName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}call_name'],
      ),
      birthDate: $HorsesTable.$converterbirthDaten.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}birth_date'],
        ),
      ),
      birthdayReminder: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}birthday_reminder'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      ),
      breed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breed'],
      ),
      colorMarkings: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_markings'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height_cm'],
      ),
      ueln: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ueln'],
      ),
      chipNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chip_number'],
      ),
      passportNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passport_number'],
      ),
      sire: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sire'],
      ),
      dam: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dam'],
      ),
      stableLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stable_location'],
      ),
      keepingType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keeping_type'],
      ),
      owner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner'],
      ),
      insurance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}insurance'],
      ),
      intolerances: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intolerances'],
      ),
      medicalHistory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medical_history'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      profilePhotoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_photo_id'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $HorsesTable createAlias(String alias) {
    return $HorsesTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterbirthDate =
      const LocalDateConverter();
  static TypeConverter<LocalDate?, String?> $converterbirthDaten =
      NullAwareTypeConverter.wrap($converterbirthDate);
}

class HorseRow extends DataClass implements Insertable<HorseRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String name;
  final String? callName;
  final LocalDate? birthDate;
  final bool birthdayReminder;

  /// `stute` | `wallach` | `hengst`
  final String? sex;
  final String? breed;
  final String? colorMarkings;
  final int? heightCm;
  final String? ueln;
  final String? chipNumber;
  final String? passportNumber;
  final String? sire;
  final String? dam;
  final String? stableLocation;
  final String? keepingType;
  final String? owner;
  final String? insurance;
  final String? intolerances;
  final String? medicalHistory;
  final String? notes;

  /// Kein Fremdschlüssel (Zyklus mit horse_photos); wird im Repository gepflegt.
  final String? profilePhotoId;
  final DateTime? archivedAt;
  final int sortOrder;
  const HorseRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    this.callName,
    this.birthDate,
    required this.birthdayReminder,
    this.sex,
    this.breed,
    this.colorMarkings,
    this.heightCm,
    this.ueln,
    this.chipNumber,
    this.passportNumber,
    this.sire,
    this.dam,
    this.stableLocation,
    this.keepingType,
    this.owner,
    this.insurance,
    this.intolerances,
    this.medicalHistory,
    this.notes,
    this.profilePhotoId,
    this.archivedAt,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || callName != null) {
      map['call_name'] = Variable<String>(callName);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<String>(
        $HorsesTable.$converterbirthDaten.toSql(birthDate),
      );
    }
    map['birthday_reminder'] = Variable<bool>(birthdayReminder);
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String>(sex);
    }
    if (!nullToAbsent || breed != null) {
      map['breed'] = Variable<String>(breed);
    }
    if (!nullToAbsent || colorMarkings != null) {
      map['color_markings'] = Variable<String>(colorMarkings);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<int>(heightCm);
    }
    if (!nullToAbsent || ueln != null) {
      map['ueln'] = Variable<String>(ueln);
    }
    if (!nullToAbsent || chipNumber != null) {
      map['chip_number'] = Variable<String>(chipNumber);
    }
    if (!nullToAbsent || passportNumber != null) {
      map['passport_number'] = Variable<String>(passportNumber);
    }
    if (!nullToAbsent || sire != null) {
      map['sire'] = Variable<String>(sire);
    }
    if (!nullToAbsent || dam != null) {
      map['dam'] = Variable<String>(dam);
    }
    if (!nullToAbsent || stableLocation != null) {
      map['stable_location'] = Variable<String>(stableLocation);
    }
    if (!nullToAbsent || keepingType != null) {
      map['keeping_type'] = Variable<String>(keepingType);
    }
    if (!nullToAbsent || owner != null) {
      map['owner'] = Variable<String>(owner);
    }
    if (!nullToAbsent || insurance != null) {
      map['insurance'] = Variable<String>(insurance);
    }
    if (!nullToAbsent || intolerances != null) {
      map['intolerances'] = Variable<String>(intolerances);
    }
    if (!nullToAbsent || medicalHistory != null) {
      map['medical_history'] = Variable<String>(medicalHistory);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || profilePhotoId != null) {
      map['profile_photo_id'] = Variable<String>(profilePhotoId);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  HorsesCompanion toCompanion(bool nullToAbsent) {
    return HorsesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      name: Value(name),
      callName: callName == null && nullToAbsent
          ? const Value.absent()
          : Value(callName),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      birthdayReminder: Value(birthdayReminder),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      breed: breed == null && nullToAbsent
          ? const Value.absent()
          : Value(breed),
      colorMarkings: colorMarkings == null && nullToAbsent
          ? const Value.absent()
          : Value(colorMarkings),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      ueln: ueln == null && nullToAbsent ? const Value.absent() : Value(ueln),
      chipNumber: chipNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(chipNumber),
      passportNumber: passportNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(passportNumber),
      sire: sire == null && nullToAbsent ? const Value.absent() : Value(sire),
      dam: dam == null && nullToAbsent ? const Value.absent() : Value(dam),
      stableLocation: stableLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(stableLocation),
      keepingType: keepingType == null && nullToAbsent
          ? const Value.absent()
          : Value(keepingType),
      owner: owner == null && nullToAbsent
          ? const Value.absent()
          : Value(owner),
      insurance: insurance == null && nullToAbsent
          ? const Value.absent()
          : Value(insurance),
      intolerances: intolerances == null && nullToAbsent
          ? const Value.absent()
          : Value(intolerances),
      medicalHistory: medicalHistory == null && nullToAbsent
          ? const Value.absent()
          : Value(medicalHistory),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      profilePhotoId: profilePhotoId == null && nullToAbsent
          ? const Value.absent()
          : Value(profilePhotoId),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      sortOrder: Value(sortOrder),
    );
  }

  factory HorseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HorseRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      callName: serializer.fromJson<String?>(json['callName']),
      birthDate: serializer.fromJson<LocalDate?>(json['birthDate']),
      birthdayReminder: serializer.fromJson<bool>(json['birthdayReminder']),
      sex: serializer.fromJson<String?>(json['sex']),
      breed: serializer.fromJson<String?>(json['breed']),
      colorMarkings: serializer.fromJson<String?>(json['colorMarkings']),
      heightCm: serializer.fromJson<int?>(json['heightCm']),
      ueln: serializer.fromJson<String?>(json['ueln']),
      chipNumber: serializer.fromJson<String?>(json['chipNumber']),
      passportNumber: serializer.fromJson<String?>(json['passportNumber']),
      sire: serializer.fromJson<String?>(json['sire']),
      dam: serializer.fromJson<String?>(json['dam']),
      stableLocation: serializer.fromJson<String?>(json['stableLocation']),
      keepingType: serializer.fromJson<String?>(json['keepingType']),
      owner: serializer.fromJson<String?>(json['owner']),
      insurance: serializer.fromJson<String?>(json['insurance']),
      intolerances: serializer.fromJson<String?>(json['intolerances']),
      medicalHistory: serializer.fromJson<String?>(json['medicalHistory']),
      notes: serializer.fromJson<String?>(json['notes']),
      profilePhotoId: serializer.fromJson<String?>(json['profilePhotoId']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'callName': serializer.toJson<String?>(callName),
      'birthDate': serializer.toJson<LocalDate?>(birthDate),
      'birthdayReminder': serializer.toJson<bool>(birthdayReminder),
      'sex': serializer.toJson<String?>(sex),
      'breed': serializer.toJson<String?>(breed),
      'colorMarkings': serializer.toJson<String?>(colorMarkings),
      'heightCm': serializer.toJson<int?>(heightCm),
      'ueln': serializer.toJson<String?>(ueln),
      'chipNumber': serializer.toJson<String?>(chipNumber),
      'passportNumber': serializer.toJson<String?>(passportNumber),
      'sire': serializer.toJson<String?>(sire),
      'dam': serializer.toJson<String?>(dam),
      'stableLocation': serializer.toJson<String?>(stableLocation),
      'keepingType': serializer.toJson<String?>(keepingType),
      'owner': serializer.toJson<String?>(owner),
      'insurance': serializer.toJson<String?>(insurance),
      'intolerances': serializer.toJson<String?>(intolerances),
      'medicalHistory': serializer.toJson<String?>(medicalHistory),
      'notes': serializer.toJson<String?>(notes),
      'profilePhotoId': serializer.toJson<String?>(profilePhotoId),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  HorseRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? name,
    Value<String?> callName = const Value.absent(),
    Value<LocalDate?> birthDate = const Value.absent(),
    bool? birthdayReminder,
    Value<String?> sex = const Value.absent(),
    Value<String?> breed = const Value.absent(),
    Value<String?> colorMarkings = const Value.absent(),
    Value<int?> heightCm = const Value.absent(),
    Value<String?> ueln = const Value.absent(),
    Value<String?> chipNumber = const Value.absent(),
    Value<String?> passportNumber = const Value.absent(),
    Value<String?> sire = const Value.absent(),
    Value<String?> dam = const Value.absent(),
    Value<String?> stableLocation = const Value.absent(),
    Value<String?> keepingType = const Value.absent(),
    Value<String?> owner = const Value.absent(),
    Value<String?> insurance = const Value.absent(),
    Value<String?> intolerances = const Value.absent(),
    Value<String?> medicalHistory = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> profilePhotoId = const Value.absent(),
    Value<DateTime?> archivedAt = const Value.absent(),
    int? sortOrder,
  }) => HorseRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    callName: callName.present ? callName.value : this.callName,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    birthdayReminder: birthdayReminder ?? this.birthdayReminder,
    sex: sex.present ? sex.value : this.sex,
    breed: breed.present ? breed.value : this.breed,
    colorMarkings: colorMarkings.present
        ? colorMarkings.value
        : this.colorMarkings,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    ueln: ueln.present ? ueln.value : this.ueln,
    chipNumber: chipNumber.present ? chipNumber.value : this.chipNumber,
    passportNumber: passportNumber.present
        ? passportNumber.value
        : this.passportNumber,
    sire: sire.present ? sire.value : this.sire,
    dam: dam.present ? dam.value : this.dam,
    stableLocation: stableLocation.present
        ? stableLocation.value
        : this.stableLocation,
    keepingType: keepingType.present ? keepingType.value : this.keepingType,
    owner: owner.present ? owner.value : this.owner,
    insurance: insurance.present ? insurance.value : this.insurance,
    intolerances: intolerances.present ? intolerances.value : this.intolerances,
    medicalHistory: medicalHistory.present
        ? medicalHistory.value
        : this.medicalHistory,
    notes: notes.present ? notes.value : this.notes,
    profilePhotoId: profilePhotoId.present
        ? profilePhotoId.value
        : this.profilePhotoId,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  HorseRow copyWithCompanion(HorsesCompanion data) {
    return HorseRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      callName: data.callName.present ? data.callName.value : this.callName,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      birthdayReminder: data.birthdayReminder.present
          ? data.birthdayReminder.value
          : this.birthdayReminder,
      sex: data.sex.present ? data.sex.value : this.sex,
      breed: data.breed.present ? data.breed.value : this.breed,
      colorMarkings: data.colorMarkings.present
          ? data.colorMarkings.value
          : this.colorMarkings,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      ueln: data.ueln.present ? data.ueln.value : this.ueln,
      chipNumber: data.chipNumber.present
          ? data.chipNumber.value
          : this.chipNumber,
      passportNumber: data.passportNumber.present
          ? data.passportNumber.value
          : this.passportNumber,
      sire: data.sire.present ? data.sire.value : this.sire,
      dam: data.dam.present ? data.dam.value : this.dam,
      stableLocation: data.stableLocation.present
          ? data.stableLocation.value
          : this.stableLocation,
      keepingType: data.keepingType.present
          ? data.keepingType.value
          : this.keepingType,
      owner: data.owner.present ? data.owner.value : this.owner,
      insurance: data.insurance.present ? data.insurance.value : this.insurance,
      intolerances: data.intolerances.present
          ? data.intolerances.value
          : this.intolerances,
      medicalHistory: data.medicalHistory.present
          ? data.medicalHistory.value
          : this.medicalHistory,
      notes: data.notes.present ? data.notes.value : this.notes,
      profilePhotoId: data.profilePhotoId.present
          ? data.profilePhotoId.value
          : this.profilePhotoId,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HorseRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('callName: $callName, ')
          ..write('birthDate: $birthDate, ')
          ..write('birthdayReminder: $birthdayReminder, ')
          ..write('sex: $sex, ')
          ..write('breed: $breed, ')
          ..write('colorMarkings: $colorMarkings, ')
          ..write('heightCm: $heightCm, ')
          ..write('ueln: $ueln, ')
          ..write('chipNumber: $chipNumber, ')
          ..write('passportNumber: $passportNumber, ')
          ..write('sire: $sire, ')
          ..write('dam: $dam, ')
          ..write('stableLocation: $stableLocation, ')
          ..write('keepingType: $keepingType, ')
          ..write('owner: $owner, ')
          ..write('insurance: $insurance, ')
          ..write('intolerances: $intolerances, ')
          ..write('medicalHistory: $medicalHistory, ')
          ..write('notes: $notes, ')
          ..write('profilePhotoId: $profilePhotoId, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    createdAt,
    updatedAt,
    id,
    name,
    callName,
    birthDate,
    birthdayReminder,
    sex,
    breed,
    colorMarkings,
    heightCm,
    ueln,
    chipNumber,
    passportNumber,
    sire,
    dam,
    stableLocation,
    keepingType,
    owner,
    insurance,
    intolerances,
    medicalHistory,
    notes,
    profilePhotoId,
    archivedAt,
    sortOrder,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HorseRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.callName == this.callName &&
          other.birthDate == this.birthDate &&
          other.birthdayReminder == this.birthdayReminder &&
          other.sex == this.sex &&
          other.breed == this.breed &&
          other.colorMarkings == this.colorMarkings &&
          other.heightCm == this.heightCm &&
          other.ueln == this.ueln &&
          other.chipNumber == this.chipNumber &&
          other.passportNumber == this.passportNumber &&
          other.sire == this.sire &&
          other.dam == this.dam &&
          other.stableLocation == this.stableLocation &&
          other.keepingType == this.keepingType &&
          other.owner == this.owner &&
          other.insurance == this.insurance &&
          other.intolerances == this.intolerances &&
          other.medicalHistory == this.medicalHistory &&
          other.notes == this.notes &&
          other.profilePhotoId == this.profilePhotoId &&
          other.archivedAt == this.archivedAt &&
          other.sortOrder == this.sortOrder);
}

class HorsesCompanion extends UpdateCompanion<HorseRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String?> callName;
  final Value<LocalDate?> birthDate;
  final Value<bool> birthdayReminder;
  final Value<String?> sex;
  final Value<String?> breed;
  final Value<String?> colorMarkings;
  final Value<int?> heightCm;
  final Value<String?> ueln;
  final Value<String?> chipNumber;
  final Value<String?> passportNumber;
  final Value<String?> sire;
  final Value<String?> dam;
  final Value<String?> stableLocation;
  final Value<String?> keepingType;
  final Value<String?> owner;
  final Value<String?> insurance;
  final Value<String?> intolerances;
  final Value<String?> medicalHistory;
  final Value<String?> notes;
  final Value<String?> profilePhotoId;
  final Value<DateTime?> archivedAt;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const HorsesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.callName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.birthdayReminder = const Value.absent(),
    this.sex = const Value.absent(),
    this.breed = const Value.absent(),
    this.colorMarkings = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.ueln = const Value.absent(),
    this.chipNumber = const Value.absent(),
    this.passportNumber = const Value.absent(),
    this.sire = const Value.absent(),
    this.dam = const Value.absent(),
    this.stableLocation = const Value.absent(),
    this.keepingType = const Value.absent(),
    this.owner = const Value.absent(),
    this.insurance = const Value.absent(),
    this.intolerances = const Value.absent(),
    this.medicalHistory = const Value.absent(),
    this.notes = const Value.absent(),
    this.profilePhotoId = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HorsesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String name,
    this.callName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.birthdayReminder = const Value.absent(),
    this.sex = const Value.absent(),
    this.breed = const Value.absent(),
    this.colorMarkings = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.ueln = const Value.absent(),
    this.chipNumber = const Value.absent(),
    this.passportNumber = const Value.absent(),
    this.sire = const Value.absent(),
    this.dam = const Value.absent(),
    this.stableLocation = const Value.absent(),
    this.keepingType = const Value.absent(),
    this.owner = const Value.absent(),
    this.insurance = const Value.absent(),
    this.intolerances = const Value.absent(),
    this.medicalHistory = const Value.absent(),
    this.notes = const Value.absent(),
    this.profilePhotoId = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<HorseRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? callName,
    Expression<String>? birthDate,
    Expression<bool>? birthdayReminder,
    Expression<String>? sex,
    Expression<String>? breed,
    Expression<String>? colorMarkings,
    Expression<int>? heightCm,
    Expression<String>? ueln,
    Expression<String>? chipNumber,
    Expression<String>? passportNumber,
    Expression<String>? sire,
    Expression<String>? dam,
    Expression<String>? stableLocation,
    Expression<String>? keepingType,
    Expression<String>? owner,
    Expression<String>? insurance,
    Expression<String>? intolerances,
    Expression<String>? medicalHistory,
    Expression<String>? notes,
    Expression<String>? profilePhotoId,
    Expression<DateTime>? archivedAt,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (callName != null) 'call_name': callName,
      if (birthDate != null) 'birth_date': birthDate,
      if (birthdayReminder != null) 'birthday_reminder': birthdayReminder,
      if (sex != null) 'sex': sex,
      if (breed != null) 'breed': breed,
      if (colorMarkings != null) 'color_markings': colorMarkings,
      if (heightCm != null) 'height_cm': heightCm,
      if (ueln != null) 'ueln': ueln,
      if (chipNumber != null) 'chip_number': chipNumber,
      if (passportNumber != null) 'passport_number': passportNumber,
      if (sire != null) 'sire': sire,
      if (dam != null) 'dam': dam,
      if (stableLocation != null) 'stable_location': stableLocation,
      if (keepingType != null) 'keeping_type': keepingType,
      if (owner != null) 'owner': owner,
      if (insurance != null) 'insurance': insurance,
      if (intolerances != null) 'intolerances': intolerances,
      if (medicalHistory != null) 'medical_history': medicalHistory,
      if (notes != null) 'notes': notes,
      if (profilePhotoId != null) 'profile_photo_id': profilePhotoId,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HorsesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String?>? callName,
    Value<LocalDate?>? birthDate,
    Value<bool>? birthdayReminder,
    Value<String?>? sex,
    Value<String?>? breed,
    Value<String?>? colorMarkings,
    Value<int?>? heightCm,
    Value<String?>? ueln,
    Value<String?>? chipNumber,
    Value<String?>? passportNumber,
    Value<String?>? sire,
    Value<String?>? dam,
    Value<String?>? stableLocation,
    Value<String?>? keepingType,
    Value<String?>? owner,
    Value<String?>? insurance,
    Value<String?>? intolerances,
    Value<String?>? medicalHistory,
    Value<String?>? notes,
    Value<String?>? profilePhotoId,
    Value<DateTime?>? archivedAt,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return HorsesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      callName: callName ?? this.callName,
      birthDate: birthDate ?? this.birthDate,
      birthdayReminder: birthdayReminder ?? this.birthdayReminder,
      sex: sex ?? this.sex,
      breed: breed ?? this.breed,
      colorMarkings: colorMarkings ?? this.colorMarkings,
      heightCm: heightCm ?? this.heightCm,
      ueln: ueln ?? this.ueln,
      chipNumber: chipNumber ?? this.chipNumber,
      passportNumber: passportNumber ?? this.passportNumber,
      sire: sire ?? this.sire,
      dam: dam ?? this.dam,
      stableLocation: stableLocation ?? this.stableLocation,
      keepingType: keepingType ?? this.keepingType,
      owner: owner ?? this.owner,
      insurance: insurance ?? this.insurance,
      intolerances: intolerances ?? this.intolerances,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      notes: notes ?? this.notes,
      profilePhotoId: profilePhotoId ?? this.profilePhotoId,
      archivedAt: archivedAt ?? this.archivedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (callName.present) {
      map['call_name'] = Variable<String>(callName.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<String>(
        $HorsesTable.$converterbirthDaten.toSql(birthDate.value),
      );
    }
    if (birthdayReminder.present) {
      map['birthday_reminder'] = Variable<bool>(birthdayReminder.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (colorMarkings.present) {
      map['color_markings'] = Variable<String>(colorMarkings.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<int>(heightCm.value);
    }
    if (ueln.present) {
      map['ueln'] = Variable<String>(ueln.value);
    }
    if (chipNumber.present) {
      map['chip_number'] = Variable<String>(chipNumber.value);
    }
    if (passportNumber.present) {
      map['passport_number'] = Variable<String>(passportNumber.value);
    }
    if (sire.present) {
      map['sire'] = Variable<String>(sire.value);
    }
    if (dam.present) {
      map['dam'] = Variable<String>(dam.value);
    }
    if (stableLocation.present) {
      map['stable_location'] = Variable<String>(stableLocation.value);
    }
    if (keepingType.present) {
      map['keeping_type'] = Variable<String>(keepingType.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (insurance.present) {
      map['insurance'] = Variable<String>(insurance.value);
    }
    if (intolerances.present) {
      map['intolerances'] = Variable<String>(intolerances.value);
    }
    if (medicalHistory.present) {
      map['medical_history'] = Variable<String>(medicalHistory.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (profilePhotoId.present) {
      map['profile_photo_id'] = Variable<String>(profilePhotoId.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HorsesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('callName: $callName, ')
          ..write('birthDate: $birthDate, ')
          ..write('birthdayReminder: $birthdayReminder, ')
          ..write('sex: $sex, ')
          ..write('breed: $breed, ')
          ..write('colorMarkings: $colorMarkings, ')
          ..write('heightCm: $heightCm, ')
          ..write('ueln: $ueln, ')
          ..write('chipNumber: $chipNumber, ')
          ..write('passportNumber: $passportNumber, ')
          ..write('sire: $sire, ')
          ..write('dam: $dam, ')
          ..write('stableLocation: $stableLocation, ')
          ..write('keepingType: $keepingType, ')
          ..write('owner: $owner, ')
          ..write('insurance: $insurance, ')
          ..write('intolerances: $intolerances, ')
          ..write('medicalHistory: $medicalHistory, ')
          ..write('notes: $notes, ')
          ..write('profilePhotoId: $profilePhotoId, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HorsePhotosTable extends HorsePhotos
    with TableInfo<$HorsePhotosTable, HorsePhotoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HorsePhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horseIdMeta = const VerificationMeta(
    'horseId',
  );
  @override
  late final GeneratedColumn<String> horseId = GeneratedColumn<String>(
    'horse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES horses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    horseId,
    relativePath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'horse_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<HorsePhotoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('horse_id')) {
      context.handle(
        _horseIdMeta,
        horseId.isAcceptableOrUnknown(data['horse_id']!, _horseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_horseIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HorsePhotoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HorsePhotoRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      horseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}horse_id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
    );
  }

  @override
  $HorsePhotosTable createAlias(String alias) {
    return $HorsePhotosTable(attachedDatabase, alias);
  }
}

class HorsePhotoRow extends DataClass implements Insertable<HorsePhotoRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String horseId;

  /// Relativ zum App-Dokumentenverzeichnis, z. B. `photos/<uuid>.jpg`.
  final String relativePath;
  const HorsePhotoRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.horseId,
    required this.relativePath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['horse_id'] = Variable<String>(horseId);
    map['relative_path'] = Variable<String>(relativePath);
    return map;
  }

  HorsePhotosCompanion toCompanion(bool nullToAbsent) {
    return HorsePhotosCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      horseId: Value(horseId),
      relativePath: Value(relativePath),
    );
  }

  factory HorsePhotoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HorsePhotoRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      horseId: serializer.fromJson<String>(json['horseId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'horseId': serializer.toJson<String>(horseId),
      'relativePath': serializer.toJson<String>(relativePath),
    };
  }

  HorsePhotoRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? horseId,
    String? relativePath,
  }) => HorsePhotoRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    horseId: horseId ?? this.horseId,
    relativePath: relativePath ?? this.relativePath,
  );
  HorsePhotoRow copyWithCompanion(HorsePhotosCompanion data) {
    return HorsePhotoRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HorsePhotoRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('relativePath: $relativePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, horseId, relativePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HorsePhotoRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.horseId == this.horseId &&
          other.relativePath == this.relativePath);
}

class HorsePhotosCompanion extends UpdateCompanion<HorsePhotoRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> horseId;
  final Value<String> relativePath;
  final Value<int> rowid;
  const HorsePhotosCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.horseId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HorsePhotosCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String horseId,
    required String relativePath,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       horseId = Value(horseId),
       relativePath = Value(relativePath);
  static Insertable<HorsePhotoRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? horseId,
    Expression<String>? relativePath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (horseId != null) 'horse_id': horseId,
      if (relativePath != null) 'relative_path': relativePath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HorsePhotosCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? horseId,
    Value<String>? relativePath,
    Value<int>? rowid,
  }) {
    return HorsePhotosCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      horseId: horseId ?? this.horseId,
      relativePath: relativePath ?? this.relativePath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (horseId.present) {
      map['horse_id'] = Variable<String>(horseId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HorsePhotosCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('relativePath: $relativePath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HorseWeightsTable extends HorseWeights
    with TableInfo<$HorseWeightsTable, HorseWeightRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HorseWeightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horseIdMeta = const VerificationMeta(
    'horseId',
  );
  @override
  late final GeneratedColumn<String> horseId = GeneratedColumn<String>(
    'horse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES horses (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> date =
      GeneratedColumn<String>(
        'date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>($HorseWeightsTable.$converterdate);
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    horseId,
    date,
    weightKg,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'horse_weights';
  @override
  VerificationContext validateIntegrity(
    Insertable<HorseWeightRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('horse_id')) {
      context.handle(
        _horseIdMeta,
        horseId.isAcceptableOrUnknown(data['horse_id']!, _horseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_horseIdMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HorseWeightRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HorseWeightRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      horseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}horse_id'],
      )!,
      date: $HorseWeightsTable.$converterdate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}date'],
        )!,
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $HorseWeightsTable createAlias(String alias) {
    return $HorseWeightsTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterdate =
      const LocalDateConverter();
}

class HorseWeightRow extends DataClass implements Insertable<HorseWeightRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String horseId;
  final LocalDate date;
  final double weightKg;
  final String? note;
  const HorseWeightRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.horseId,
    required this.date,
    required this.weightKg,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['horse_id'] = Variable<String>(horseId);
    {
      map['date'] = Variable<String>(
        $HorseWeightsTable.$converterdate.toSql(date),
      );
    }
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  HorseWeightsCompanion toCompanion(bool nullToAbsent) {
    return HorseWeightsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      horseId: Value(horseId),
      date: Value(date),
      weightKg: Value(weightKg),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory HorseWeightRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HorseWeightRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      horseId: serializer.fromJson<String>(json['horseId']),
      date: serializer.fromJson<LocalDate>(json['date']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'horseId': serializer.toJson<String>(horseId),
      'date': serializer.toJson<LocalDate>(date),
      'weightKg': serializer.toJson<double>(weightKg),
      'note': serializer.toJson<String?>(note),
    };
  }

  HorseWeightRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? horseId,
    LocalDate? date,
    double? weightKg,
    Value<String?> note = const Value.absent(),
  }) => HorseWeightRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    horseId: horseId ?? this.horseId,
    date: date ?? this.date,
    weightKg: weightKg ?? this.weightKg,
    note: note.present ? note.value : this.note,
  );
  HorseWeightRow copyWithCompanion(HorseWeightsCompanion data) {
    return HorseWeightRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HorseWeightRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, horseId, date, weightKg, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HorseWeightRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.horseId == this.horseId &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.note == this.note);
}

class HorseWeightsCompanion extends UpdateCompanion<HorseWeightRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> horseId;
  final Value<LocalDate> date;
  final Value<double> weightKg;
  final Value<String?> note;
  final Value<int> rowid;
  const HorseWeightsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.horseId = const Value.absent(),
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HorseWeightsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String horseId,
    required LocalDate date,
    required double weightKg,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       horseId = Value(horseId),
       date = Value(date),
       weightKg = Value(weightKg);
  static Insertable<HorseWeightRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? horseId,
    Expression<String>? date,
    Expression<double>? weightKg,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (horseId != null) 'horse_id': horseId,
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HorseWeightsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? horseId,
    Value<LocalDate>? date,
    Value<double>? weightKg,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return HorseWeightsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      horseId: horseId ?? this.horseId,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (horseId.present) {
      map['horse_id'] = Variable<String>(horseId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(
        $HorseWeightsTable.$converterdate.toSql(date.value),
      );
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HorseWeightsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    name,
    role,
    phone,
    email,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class ContactRow extends DataClass implements Insertable<ContactRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String name;

  /// Siehe `ContactRole.key`.
  final String role;
  final String? phone;
  final String? email;
  final String? notes;
  const ContactRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.role,
    this.phone,
    this.email,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      name: Value(name),
      role: Value(role),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory ContactRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  ContactRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? name,
    String? role,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => ContactRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    role: role ?? this.role,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    notes: notes.present ? notes.value : this.notes,
  );
  ContactRow copyWithCompanion(ContactsCompanion data) {
    return ContactRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, name, role, phone, email, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.notes == this.notes);
}

class ContactsCompanion extends UpdateCompanion<ContactRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> role;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> notes;
  final Value<int> rowid;
  const ContactsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String name,
    required String role,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       role = Value(role);
  static Insertable<ContactRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? role,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return ContactsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HorseContactsTable extends HorseContacts
    with TableInfo<$HorseContactsTable, HorseContactRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HorseContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _horseIdMeta = const VerificationMeta(
    'horseId',
  );
  @override
  late final GeneratedColumn<String> horseId = GeneratedColumn<String>(
    'horse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES horses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES contacts (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    horseId,
    contactId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'horse_contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<HorseContactRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('horse_id')) {
      context.handle(
        _horseIdMeta,
        horseId.isAcceptableOrUnknown(data['horse_id']!, _horseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_horseIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {horseId, contactId};
  @override
  HorseContactRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HorseContactRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      horseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}horse_id'],
      )!,
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      )!,
    );
  }

  @override
  $HorseContactsTable createAlias(String alias) {
    return $HorseContactsTable(attachedDatabase, alias);
  }
}

class HorseContactRow extends DataClass implements Insertable<HorseContactRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String horseId;
  final String contactId;
  const HorseContactRow({
    required this.createdAt,
    required this.updatedAt,
    required this.horseId,
    required this.contactId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['horse_id'] = Variable<String>(horseId);
    map['contact_id'] = Variable<String>(contactId);
    return map;
  }

  HorseContactsCompanion toCompanion(bool nullToAbsent) {
    return HorseContactsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      horseId: Value(horseId),
      contactId: Value(contactId),
    );
  }

  factory HorseContactRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HorseContactRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      horseId: serializer.fromJson<String>(json['horseId']),
      contactId: serializer.fromJson<String>(json['contactId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'horseId': serializer.toJson<String>(horseId),
      'contactId': serializer.toJson<String>(contactId),
    };
  }

  HorseContactRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? horseId,
    String? contactId,
  }) => HorseContactRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    horseId: horseId ?? this.horseId,
    contactId: contactId ?? this.contactId,
  );
  HorseContactRow copyWithCompanion(HorseContactsCompanion data) {
    return HorseContactRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HorseContactRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('horseId: $horseId, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, horseId, contactId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HorseContactRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.horseId == this.horseId &&
          other.contactId == this.contactId);
}

class HorseContactsCompanion extends UpdateCompanion<HorseContactRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> horseId;
  final Value<String> contactId;
  final Value<int> rowid;
  const HorseContactsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.horseId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HorseContactsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String horseId,
    required String contactId,
    this.rowid = const Value.absent(),
  }) : horseId = Value(horseId),
       contactId = Value(contactId);
  static Insertable<HorseContactRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? horseId,
    Expression<String>? contactId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (horseId != null) 'horse_id': horseId,
      if (contactId != null) 'contact_id': contactId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HorseContactsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? horseId,
    Value<String>? contactId,
    Value<int>? rowid,
  }) {
    return HorseContactsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      horseId: horseId ?? this.horseId,
      contactId: contactId ?? this.contactId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (horseId.present) {
      map['horse_id'] = Variable<String>(horseId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HorseContactsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('horseId: $horseId, ')
          ..write('contactId: $contactId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareEventTypesTable extends CareEventTypes
    with TableInfo<$CareEventTypesTable, CareTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareEventTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _builtinMeta = const VerificationMeta(
    'builtin',
  );
  @override
  late final GeneratedColumn<bool> builtin = GeneratedColumn<bool>(
    'builtin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("builtin" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    name,
    kind,
    color,
    icon,
    builtin,
    archived,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_event_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('builtin')) {
      context.handle(
        _builtinMeta,
        builtin.isAcceptableOrUnknown(data['builtin']!, _builtinMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareTypeRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      builtin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}builtin'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CareEventTypesTable createAlias(String alias) {
    return $CareEventTypesTable(attachedDatabase, alias);
  }
}

class CareTypeRow extends DataClass implements Insertable<CareTypeRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String name;

  /// Siehe `CareKind.key` – bestimmt das Formular.
  final String kind;
  final int color;
  final String icon;
  final bool builtin;
  final bool archived;
  final int sortOrder;
  const CareTypeRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.kind,
    required this.color,
    required this.icon,
    required this.builtin,
    required this.archived,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['color'] = Variable<int>(color);
    map['icon'] = Variable<String>(icon);
    map['builtin'] = Variable<bool>(builtin);
    map['archived'] = Variable<bool>(archived);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CareEventTypesCompanion toCompanion(bool nullToAbsent) {
    return CareEventTypesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      color: Value(color),
      icon: Value(icon),
      builtin: Value(builtin),
      archived: Value(archived),
      sortOrder: Value(sortOrder),
    );
  }

  factory CareTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareTypeRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      color: serializer.fromJson<int>(json['color']),
      icon: serializer.fromJson<String>(json['icon']),
      builtin: serializer.fromJson<bool>(json['builtin']),
      archived: serializer.fromJson<bool>(json['archived']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'color': serializer.toJson<int>(color),
      'icon': serializer.toJson<String>(icon),
      'builtin': serializer.toJson<bool>(builtin),
      'archived': serializer.toJson<bool>(archived),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  CareTypeRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? name,
    String? kind,
    int? color,
    String? icon,
    bool? builtin,
    bool? archived,
    int? sortOrder,
  }) => CareTypeRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    color: color ?? this.color,
    icon: icon ?? this.icon,
    builtin: builtin ?? this.builtin,
    archived: archived ?? this.archived,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  CareTypeRow copyWithCompanion(CareEventTypesCompanion data) {
    return CareTypeRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      builtin: data.builtin.present ? data.builtin.value : this.builtin,
      archived: data.archived.present ? data.archived.value : this.archived,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareTypeRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('builtin: $builtin, ')
          ..write('archived: $archived, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    name,
    kind,
    color,
    icon,
    builtin,
    archived,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareTypeRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.builtin == this.builtin &&
          other.archived == this.archived &&
          other.sortOrder == this.sortOrder);
}

class CareEventTypesCompanion extends UpdateCompanion<CareTypeRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> kind;
  final Value<int> color;
  final Value<String> icon;
  final Value<bool> builtin;
  final Value<bool> archived;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CareEventTypesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.builtin = const Value.absent(),
    this.archived = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareEventTypesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String name,
    required String kind,
    required int color,
    required String icon,
    this.builtin = const Value.absent(),
    this.archived = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind),
       color = Value(color),
       icon = Value(icon);
  static Insertable<CareTypeRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<int>? color,
    Expression<String>? icon,
    Expression<bool>? builtin,
    Expression<bool>? archived,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (builtin != null) 'builtin': builtin,
      if (archived != null) 'archived': archived,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareEventTypesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? kind,
    Value<int>? color,
    Value<String>? icon,
    Value<bool>? builtin,
    Value<bool>? archived,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CareEventTypesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      builtin: builtin ?? this.builtin,
      archived: archived ?? this.archived,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (builtin.present) {
      map['builtin'] = Variable<bool>(builtin.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareEventTypesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('builtin: $builtin, ')
          ..write('archived: $archived, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareIntervalDefaultsTable extends CareIntervalDefaults
    with TableInfo<$CareIntervalDefaultsTable, CareIntervalDefaultRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareIntervalDefaultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<String> typeId = GeneratedColumn<String>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES care_event_types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _variantKeyMeta = const VerificationMeta(
    'variantKey',
  );
  @override
  late final GeneratedColumn<String> variantKey = GeneratedColumn<String>(
    'variant_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    typeId,
    variantKey,
    value,
    unit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_interval_defaults';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareIntervalDefaultRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('variant_key')) {
      context.handle(
        _variantKeyMeta,
        variantKey.isAcceptableOrUnknown(data['variant_key']!, _variantKeyMeta),
      );
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {typeId, variantKey};
  @override
  CareIntervalDefaultRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareIntervalDefaultRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_id'],
      )!,
      variantKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
    );
  }

  @override
  $CareIntervalDefaultsTable createAlias(String alias) {
    return $CareIntervalDefaultsTable(attachedDatabase, alias);
  }
}

class CareIntervalDefaultRow extends DataClass
    implements Insertable<CareIntervalDefaultRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String typeId;

  /// Leerer Text = gilt für die Art ohne bestimmte Variante.
  /// `value` 0 = „kein Vorschlag“ (Startwerte werden sonst neu ergänzt).
  final String variantKey;
  final int value;

  /// Siehe `IntervalUnit.key`.
  final String unit;
  const CareIntervalDefaultRow({
    required this.createdAt,
    required this.updatedAt,
    required this.typeId,
    required this.variantKey,
    required this.value,
    required this.unit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['type_id'] = Variable<String>(typeId);
    map['variant_key'] = Variable<String>(variantKey);
    map['value'] = Variable<int>(value);
    map['unit'] = Variable<String>(unit);
    return map;
  }

  CareIntervalDefaultsCompanion toCompanion(bool nullToAbsent) {
    return CareIntervalDefaultsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      typeId: Value(typeId),
      variantKey: Value(variantKey),
      value: Value(value),
      unit: Value(unit),
    );
  }

  factory CareIntervalDefaultRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareIntervalDefaultRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      typeId: serializer.fromJson<String>(json['typeId']),
      variantKey: serializer.fromJson<String>(json['variantKey']),
      value: serializer.fromJson<int>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'typeId': serializer.toJson<String>(typeId),
      'variantKey': serializer.toJson<String>(variantKey),
      'value': serializer.toJson<int>(value),
      'unit': serializer.toJson<String>(unit),
    };
  }

  CareIntervalDefaultRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? typeId,
    String? variantKey,
    int? value,
    String? unit,
  }) => CareIntervalDefaultRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    typeId: typeId ?? this.typeId,
    variantKey: variantKey ?? this.variantKey,
    value: value ?? this.value,
    unit: unit ?? this.unit,
  );
  CareIntervalDefaultRow copyWithCompanion(CareIntervalDefaultsCompanion data) {
    return CareIntervalDefaultRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      variantKey: data.variantKey.present
          ? data.variantKey.value
          : this.variantKey,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareIntervalDefaultRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('typeId: $typeId, ')
          ..write('variantKey: $variantKey, ')
          ..write('value: $value, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, typeId, variantKey, value, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareIntervalDefaultRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.typeId == this.typeId &&
          other.variantKey == this.variantKey &&
          other.value == this.value &&
          other.unit == this.unit);
}

class CareIntervalDefaultsCompanion
    extends UpdateCompanion<CareIntervalDefaultRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> typeId;
  final Value<String> variantKey;
  final Value<int> value;
  final Value<String> unit;
  final Value<int> rowid;
  const CareIntervalDefaultsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.typeId = const Value.absent(),
    this.variantKey = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareIntervalDefaultsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String typeId,
    this.variantKey = const Value.absent(),
    required int value,
    required String unit,
    this.rowid = const Value.absent(),
  }) : typeId = Value(typeId),
       value = Value(value),
       unit = Value(unit);
  static Insertable<CareIntervalDefaultRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? typeId,
    Expression<String>? variantKey,
    Expression<int>? value,
    Expression<String>? unit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (typeId != null) 'type_id': typeId,
      if (variantKey != null) 'variant_key': variantKey,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareIntervalDefaultsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? typeId,
    Value<String>? variantKey,
    Value<int>? value,
    Value<String>? unit,
    Value<int>? rowid,
  }) {
    return CareIntervalDefaultsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      typeId: typeId ?? this.typeId,
      variantKey: variantKey ?? this.variantKey,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<String>(typeId.value);
    }
    if (variantKey.present) {
      map['variant_key'] = Variable<String>(variantKey.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareIntervalDefaultsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('typeId: $typeId, ')
          ..write('variantKey: $variantKey, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareEventsTable extends CareEvents
    with TableInfo<$CareEventsTable, CareEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horseIdMeta = const VerificationMeta(
    'horseId',
  );
  @override
  late final GeneratedColumn<String> horseId = GeneratedColumn<String>(
    'horse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES horses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<String> typeId = GeneratedColumn<String>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES care_event_types (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> date =
      GeneratedColumn<String>(
        'date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>($CareEventsTable.$converterdate);
  static const VerificationMeta _timeMinutesMeta = const VerificationMeta(
    'timeMinutes',
  );
  @override
  late final GeneratedColumn<int> timeMinutes = GeneratedColumn<int>(
    'time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool> done = GeneratedColumn<bool>(
    'done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _variantKeyMeta = const VerificationMeta(
    'variantKey',
  );
  @override
  late final GeneratedColumn<String> variantKey = GeneratedColumn<String>(
    'variant_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _personMeta = const VerificationMeta('person');
  @override
  late final GeneratedColumn<String> person = GeneratedColumn<String>(
    'person',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costCentsMeta = const VerificationMeta(
    'costCents',
  );
  @override
  late final GeneratedColumn<int> costCents = GeneratedColumn<int>(
    'cost_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fieldsMeta = const VerificationMeta('fields');
  @override
  late final GeneratedColumn<String> fields = GeneratedColumn<String>(
    'fields',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _repeatValueMeta = const VerificationMeta(
    'repeatValue',
  );
  @override
  late final GeneratedColumn<int> repeatValue = GeneratedColumn<int>(
    'repeat_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repeatUnitMeta = const VerificationMeta(
    'repeatUnit',
  );
  @override
  late final GeneratedColumn<String> repeatUnit = GeneratedColumn<String>(
    'repeat_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parentEventIdMeta = const VerificationMeta(
    'parentEventId',
  );
  @override
  late final GeneratedColumn<String> parentEventId = GeneratedColumn<String>(
    'parent_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seriesIdMeta = const VerificationMeta(
    'seriesId',
  );
  @override
  late final GeneratedColumn<String> seriesId = GeneratedColumn<String>(
    'series_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    horseId,
    typeId,
    date,
    timeMinutes,
    done,
    variantKey,
    title,
    person,
    costCents,
    notes,
    fields,
    repeatValue,
    repeatUnit,
    parentEventId,
    seriesId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('horse_id')) {
      context.handle(
        _horseIdMeta,
        horseId.isAcceptableOrUnknown(data['horse_id']!, _horseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_horseIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('time_minutes')) {
      context.handle(
        _timeMinutesMeta,
        timeMinutes.isAcceptableOrUnknown(
          data['time_minutes']!,
          _timeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('done')) {
      context.handle(
        _doneMeta,
        done.isAcceptableOrUnknown(data['done']!, _doneMeta),
      );
    }
    if (data.containsKey('variant_key')) {
      context.handle(
        _variantKeyMeta,
        variantKey.isAcceptableOrUnknown(data['variant_key']!, _variantKeyMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('person')) {
      context.handle(
        _personMeta,
        person.isAcceptableOrUnknown(data['person']!, _personMeta),
      );
    }
    if (data.containsKey('cost_cents')) {
      context.handle(
        _costCentsMeta,
        costCents.isAcceptableOrUnknown(data['cost_cents']!, _costCentsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('fields')) {
      context.handle(
        _fieldsMeta,
        fields.isAcceptableOrUnknown(data['fields']!, _fieldsMeta),
      );
    }
    if (data.containsKey('repeat_value')) {
      context.handle(
        _repeatValueMeta,
        repeatValue.isAcceptableOrUnknown(
          data['repeat_value']!,
          _repeatValueMeta,
        ),
      );
    }
    if (data.containsKey('repeat_unit')) {
      context.handle(
        _repeatUnitMeta,
        repeatUnit.isAcceptableOrUnknown(data['repeat_unit']!, _repeatUnitMeta),
      );
    }
    if (data.containsKey('parent_event_id')) {
      context.handle(
        _parentEventIdMeta,
        parentEventId.isAcceptableOrUnknown(
          data['parent_event_id']!,
          _parentEventIdMeta,
        ),
      );
    }
    if (data.containsKey('series_id')) {
      context.handle(
        _seriesIdMeta,
        seriesId.isAcceptableOrUnknown(data['series_id']!, _seriesIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareEventRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      horseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}horse_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_id'],
      )!,
      date: $CareEventsTable.$converterdate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}date'],
        )!,
      ),
      timeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_minutes'],
      ),
      done: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}done'],
      )!,
      variantKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_key'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      person: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person'],
      ),
      costCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_cents'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      fields: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fields'],
      )!,
      repeatValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_value'],
      ),
      repeatUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repeat_unit'],
      ),
      parentEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_event_id'],
      ),
      seriesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}series_id'],
      ),
    );
  }

  @override
  $CareEventsTable createAlias(String alias) {
    return $CareEventsTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterdate =
      const LocalDateConverter();
}

class CareEventRow extends DataClass implements Insertable<CareEventRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String horseId;
  final String typeId;
  final LocalDate date;
  final int? timeMinutes;
  final bool done;
  final String? variantKey;
  final String? title;
  final String? person;
  final int? costCents;
  final String? notes;

  /// Typspezifische Felder als JSON-Objekt (siehe `CareFields`).
  final String fields;
  final int? repeatValue;
  final String? repeatUnit;

  /// Kein Fremdschlüssel: Löschen eines Eintrags lässt Folgetermine bestehen.
  final String? parentEventId;
  final String? seriesId;
  const CareEventRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.horseId,
    required this.typeId,
    required this.date,
    this.timeMinutes,
    required this.done,
    this.variantKey,
    this.title,
    this.person,
    this.costCents,
    this.notes,
    required this.fields,
    this.repeatValue,
    this.repeatUnit,
    this.parentEventId,
    this.seriesId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['horse_id'] = Variable<String>(horseId);
    map['type_id'] = Variable<String>(typeId);
    {
      map['date'] = Variable<String>(
        $CareEventsTable.$converterdate.toSql(date),
      );
    }
    if (!nullToAbsent || timeMinutes != null) {
      map['time_minutes'] = Variable<int>(timeMinutes);
    }
    map['done'] = Variable<bool>(done);
    if (!nullToAbsent || variantKey != null) {
      map['variant_key'] = Variable<String>(variantKey);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || person != null) {
      map['person'] = Variable<String>(person);
    }
    if (!nullToAbsent || costCents != null) {
      map['cost_cents'] = Variable<int>(costCents);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['fields'] = Variable<String>(fields);
    if (!nullToAbsent || repeatValue != null) {
      map['repeat_value'] = Variable<int>(repeatValue);
    }
    if (!nullToAbsent || repeatUnit != null) {
      map['repeat_unit'] = Variable<String>(repeatUnit);
    }
    if (!nullToAbsent || parentEventId != null) {
      map['parent_event_id'] = Variable<String>(parentEventId);
    }
    if (!nullToAbsent || seriesId != null) {
      map['series_id'] = Variable<String>(seriesId);
    }
    return map;
  }

  CareEventsCompanion toCompanion(bool nullToAbsent) {
    return CareEventsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      horseId: Value(horseId),
      typeId: Value(typeId),
      date: Value(date),
      timeMinutes: timeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(timeMinutes),
      done: Value(done),
      variantKey: variantKey == null && nullToAbsent
          ? const Value.absent()
          : Value(variantKey),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      person: person == null && nullToAbsent
          ? const Value.absent()
          : Value(person),
      costCents: costCents == null && nullToAbsent
          ? const Value.absent()
          : Value(costCents),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      fields: Value(fields),
      repeatValue: repeatValue == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatValue),
      repeatUnit: repeatUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatUnit),
      parentEventId: parentEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentEventId),
      seriesId: seriesId == null && nullToAbsent
          ? const Value.absent()
          : Value(seriesId),
    );
  }

  factory CareEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareEventRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      horseId: serializer.fromJson<String>(json['horseId']),
      typeId: serializer.fromJson<String>(json['typeId']),
      date: serializer.fromJson<LocalDate>(json['date']),
      timeMinutes: serializer.fromJson<int?>(json['timeMinutes']),
      done: serializer.fromJson<bool>(json['done']),
      variantKey: serializer.fromJson<String?>(json['variantKey']),
      title: serializer.fromJson<String?>(json['title']),
      person: serializer.fromJson<String?>(json['person']),
      costCents: serializer.fromJson<int?>(json['costCents']),
      notes: serializer.fromJson<String?>(json['notes']),
      fields: serializer.fromJson<String>(json['fields']),
      repeatValue: serializer.fromJson<int?>(json['repeatValue']),
      repeatUnit: serializer.fromJson<String?>(json['repeatUnit']),
      parentEventId: serializer.fromJson<String?>(json['parentEventId']),
      seriesId: serializer.fromJson<String?>(json['seriesId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'horseId': serializer.toJson<String>(horseId),
      'typeId': serializer.toJson<String>(typeId),
      'date': serializer.toJson<LocalDate>(date),
      'timeMinutes': serializer.toJson<int?>(timeMinutes),
      'done': serializer.toJson<bool>(done),
      'variantKey': serializer.toJson<String?>(variantKey),
      'title': serializer.toJson<String?>(title),
      'person': serializer.toJson<String?>(person),
      'costCents': serializer.toJson<int?>(costCents),
      'notes': serializer.toJson<String?>(notes),
      'fields': serializer.toJson<String>(fields),
      'repeatValue': serializer.toJson<int?>(repeatValue),
      'repeatUnit': serializer.toJson<String?>(repeatUnit),
      'parentEventId': serializer.toJson<String?>(parentEventId),
      'seriesId': serializer.toJson<String?>(seriesId),
    };
  }

  CareEventRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? horseId,
    String? typeId,
    LocalDate? date,
    Value<int?> timeMinutes = const Value.absent(),
    bool? done,
    Value<String?> variantKey = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<String?> person = const Value.absent(),
    Value<int?> costCents = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? fields,
    Value<int?> repeatValue = const Value.absent(),
    Value<String?> repeatUnit = const Value.absent(),
    Value<String?> parentEventId = const Value.absent(),
    Value<String?> seriesId = const Value.absent(),
  }) => CareEventRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    horseId: horseId ?? this.horseId,
    typeId: typeId ?? this.typeId,
    date: date ?? this.date,
    timeMinutes: timeMinutes.present ? timeMinutes.value : this.timeMinutes,
    done: done ?? this.done,
    variantKey: variantKey.present ? variantKey.value : this.variantKey,
    title: title.present ? title.value : this.title,
    person: person.present ? person.value : this.person,
    costCents: costCents.present ? costCents.value : this.costCents,
    notes: notes.present ? notes.value : this.notes,
    fields: fields ?? this.fields,
    repeatValue: repeatValue.present ? repeatValue.value : this.repeatValue,
    repeatUnit: repeatUnit.present ? repeatUnit.value : this.repeatUnit,
    parentEventId: parentEventId.present
        ? parentEventId.value
        : this.parentEventId,
    seriesId: seriesId.present ? seriesId.value : this.seriesId,
  );
  CareEventRow copyWithCompanion(CareEventsCompanion data) {
    return CareEventRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      date: data.date.present ? data.date.value : this.date,
      timeMinutes: data.timeMinutes.present
          ? data.timeMinutes.value
          : this.timeMinutes,
      done: data.done.present ? data.done.value : this.done,
      variantKey: data.variantKey.present
          ? data.variantKey.value
          : this.variantKey,
      title: data.title.present ? data.title.value : this.title,
      person: data.person.present ? data.person.value : this.person,
      costCents: data.costCents.present ? data.costCents.value : this.costCents,
      notes: data.notes.present ? data.notes.value : this.notes,
      fields: data.fields.present ? data.fields.value : this.fields,
      repeatValue: data.repeatValue.present
          ? data.repeatValue.value
          : this.repeatValue,
      repeatUnit: data.repeatUnit.present
          ? data.repeatUnit.value
          : this.repeatUnit,
      parentEventId: data.parentEventId.present
          ? data.parentEventId.value
          : this.parentEventId,
      seriesId: data.seriesId.present ? data.seriesId.value : this.seriesId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareEventRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('typeId: $typeId, ')
          ..write('date: $date, ')
          ..write('timeMinutes: $timeMinutes, ')
          ..write('done: $done, ')
          ..write('variantKey: $variantKey, ')
          ..write('title: $title, ')
          ..write('person: $person, ')
          ..write('costCents: $costCents, ')
          ..write('notes: $notes, ')
          ..write('fields: $fields, ')
          ..write('repeatValue: $repeatValue, ')
          ..write('repeatUnit: $repeatUnit, ')
          ..write('parentEventId: $parentEventId, ')
          ..write('seriesId: $seriesId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    horseId,
    typeId,
    date,
    timeMinutes,
    done,
    variantKey,
    title,
    person,
    costCents,
    notes,
    fields,
    repeatValue,
    repeatUnit,
    parentEventId,
    seriesId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareEventRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.horseId == this.horseId &&
          other.typeId == this.typeId &&
          other.date == this.date &&
          other.timeMinutes == this.timeMinutes &&
          other.done == this.done &&
          other.variantKey == this.variantKey &&
          other.title == this.title &&
          other.person == this.person &&
          other.costCents == this.costCents &&
          other.notes == this.notes &&
          other.fields == this.fields &&
          other.repeatValue == this.repeatValue &&
          other.repeatUnit == this.repeatUnit &&
          other.parentEventId == this.parentEventId &&
          other.seriesId == this.seriesId);
}

class CareEventsCompanion extends UpdateCompanion<CareEventRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> horseId;
  final Value<String> typeId;
  final Value<LocalDate> date;
  final Value<int?> timeMinutes;
  final Value<bool> done;
  final Value<String?> variantKey;
  final Value<String?> title;
  final Value<String?> person;
  final Value<int?> costCents;
  final Value<String?> notes;
  final Value<String> fields;
  final Value<int?> repeatValue;
  final Value<String?> repeatUnit;
  final Value<String?> parentEventId;
  final Value<String?> seriesId;
  final Value<int> rowid;
  const CareEventsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.horseId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.date = const Value.absent(),
    this.timeMinutes = const Value.absent(),
    this.done = const Value.absent(),
    this.variantKey = const Value.absent(),
    this.title = const Value.absent(),
    this.person = const Value.absent(),
    this.costCents = const Value.absent(),
    this.notes = const Value.absent(),
    this.fields = const Value.absent(),
    this.repeatValue = const Value.absent(),
    this.repeatUnit = const Value.absent(),
    this.parentEventId = const Value.absent(),
    this.seriesId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareEventsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String horseId,
    required String typeId,
    required LocalDate date,
    this.timeMinutes = const Value.absent(),
    this.done = const Value.absent(),
    this.variantKey = const Value.absent(),
    this.title = const Value.absent(),
    this.person = const Value.absent(),
    this.costCents = const Value.absent(),
    this.notes = const Value.absent(),
    this.fields = const Value.absent(),
    this.repeatValue = const Value.absent(),
    this.repeatUnit = const Value.absent(),
    this.parentEventId = const Value.absent(),
    this.seriesId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       horseId = Value(horseId),
       typeId = Value(typeId),
       date = Value(date);
  static Insertable<CareEventRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? horseId,
    Expression<String>? typeId,
    Expression<String>? date,
    Expression<int>? timeMinutes,
    Expression<bool>? done,
    Expression<String>? variantKey,
    Expression<String>? title,
    Expression<String>? person,
    Expression<int>? costCents,
    Expression<String>? notes,
    Expression<String>? fields,
    Expression<int>? repeatValue,
    Expression<String>? repeatUnit,
    Expression<String>? parentEventId,
    Expression<String>? seriesId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (horseId != null) 'horse_id': horseId,
      if (typeId != null) 'type_id': typeId,
      if (date != null) 'date': date,
      if (timeMinutes != null) 'time_minutes': timeMinutes,
      if (done != null) 'done': done,
      if (variantKey != null) 'variant_key': variantKey,
      if (title != null) 'title': title,
      if (person != null) 'person': person,
      if (costCents != null) 'cost_cents': costCents,
      if (notes != null) 'notes': notes,
      if (fields != null) 'fields': fields,
      if (repeatValue != null) 'repeat_value': repeatValue,
      if (repeatUnit != null) 'repeat_unit': repeatUnit,
      if (parentEventId != null) 'parent_event_id': parentEventId,
      if (seriesId != null) 'series_id': seriesId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareEventsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? horseId,
    Value<String>? typeId,
    Value<LocalDate>? date,
    Value<int?>? timeMinutes,
    Value<bool>? done,
    Value<String?>? variantKey,
    Value<String?>? title,
    Value<String?>? person,
    Value<int?>? costCents,
    Value<String?>? notes,
    Value<String>? fields,
    Value<int?>? repeatValue,
    Value<String?>? repeatUnit,
    Value<String?>? parentEventId,
    Value<String?>? seriesId,
    Value<int>? rowid,
  }) {
    return CareEventsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      horseId: horseId ?? this.horseId,
      typeId: typeId ?? this.typeId,
      date: date ?? this.date,
      timeMinutes: timeMinutes ?? this.timeMinutes,
      done: done ?? this.done,
      variantKey: variantKey ?? this.variantKey,
      title: title ?? this.title,
      person: person ?? this.person,
      costCents: costCents ?? this.costCents,
      notes: notes ?? this.notes,
      fields: fields ?? this.fields,
      repeatValue: repeatValue ?? this.repeatValue,
      repeatUnit: repeatUnit ?? this.repeatUnit,
      parentEventId: parentEventId ?? this.parentEventId,
      seriesId: seriesId ?? this.seriesId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (horseId.present) {
      map['horse_id'] = Variable<String>(horseId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<String>(typeId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(
        $CareEventsTable.$converterdate.toSql(date.value),
      );
    }
    if (timeMinutes.present) {
      map['time_minutes'] = Variable<int>(timeMinutes.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (variantKey.present) {
      map['variant_key'] = Variable<String>(variantKey.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (person.present) {
      map['person'] = Variable<String>(person.value);
    }
    if (costCents.present) {
      map['cost_cents'] = Variable<int>(costCents.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (fields.present) {
      map['fields'] = Variable<String>(fields.value);
    }
    if (repeatValue.present) {
      map['repeat_value'] = Variable<int>(repeatValue.value);
    }
    if (repeatUnit.present) {
      map['repeat_unit'] = Variable<String>(repeatUnit.value);
    }
    if (parentEventId.present) {
      map['parent_event_id'] = Variable<String>(parentEventId.value);
    }
    if (seriesId.present) {
      map['series_id'] = Variable<String>(seriesId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareEventsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('typeId: $typeId, ')
          ..write('date: $date, ')
          ..write('timeMinutes: $timeMinutes, ')
          ..write('done: $done, ')
          ..write('variantKey: $variantKey, ')
          ..write('title: $title, ')
          ..write('person: $person, ')
          ..write('costCents: $costCents, ')
          ..write('notes: $notes, ')
          ..write('fields: $fields, ')
          ..write('repeatValue: $repeatValue, ')
          ..write('repeatUnit: $repeatUnit, ')
          ..write('parentEventId: $parentEventId, ')
          ..write('seriesId: $seriesId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareRemindersTable extends CareReminders
    with TableInfo<$CareRemindersTable, CareReminderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareRemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES care_events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _offsetDaysMeta = const VerificationMeta(
    'offsetDays',
  );
  @override
  late final GeneratedColumn<int> offsetDays = GeneratedColumn<int>(
    'offset_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    eventId,
    offsetDays,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareReminderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('offset_days')) {
      context.handle(
        _offsetDaysMeta,
        offsetDays.isAcceptableOrUnknown(data['offset_days']!, _offsetDaysMeta),
      );
    } else if (isInserting) {
      context.missing(_offsetDaysMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId, offsetDays};
  @override
  CareReminderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareReminderRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      offsetDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}offset_days'],
      )!,
    );
  }

  @override
  $CareRemindersTable createAlias(String alias) {
    return $CareRemindersTable(attachedDatabase, alias);
  }
}

class CareReminderRow extends DataClass implements Insertable<CareReminderRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String eventId;

  /// Tage vor dem Termin (0 = am Tag).
  final int offsetDays;
  const CareReminderRow({
    required this.createdAt,
    required this.updatedAt,
    required this.eventId,
    required this.offsetDays,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['event_id'] = Variable<String>(eventId);
    map['offset_days'] = Variable<int>(offsetDays);
    return map;
  }

  CareRemindersCompanion toCompanion(bool nullToAbsent) {
    return CareRemindersCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      eventId: Value(eventId),
      offsetDays: Value(offsetDays),
    );
  }

  factory CareReminderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareReminderRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      eventId: serializer.fromJson<String>(json['eventId']),
      offsetDays: serializer.fromJson<int>(json['offsetDays']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'eventId': serializer.toJson<String>(eventId),
      'offsetDays': serializer.toJson<int>(offsetDays),
    };
  }

  CareReminderRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? eventId,
    int? offsetDays,
  }) => CareReminderRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    eventId: eventId ?? this.eventId,
    offsetDays: offsetDays ?? this.offsetDays,
  );
  CareReminderRow copyWithCompanion(CareRemindersCompanion data) {
    return CareReminderRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      offsetDays: data.offsetDays.present
          ? data.offsetDays.value
          : this.offsetDays,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareReminderRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('eventId: $eventId, ')
          ..write('offsetDays: $offsetDays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, eventId, offsetDays);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareReminderRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.eventId == this.eventId &&
          other.offsetDays == this.offsetDays);
}

class CareRemindersCompanion extends UpdateCompanion<CareReminderRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> eventId;
  final Value<int> offsetDays;
  final Value<int> rowid;
  const CareRemindersCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.eventId = const Value.absent(),
    this.offsetDays = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareRemindersCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String eventId,
    required int offsetDays,
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       offsetDays = Value(offsetDays);
  static Insertable<CareReminderRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? eventId,
    Expression<int>? offsetDays,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (eventId != null) 'event_id': eventId,
      if (offsetDays != null) 'offset_days': offsetDays,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareRemindersCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? eventId,
    Value<int>? offsetDays,
    Value<int>? rowid,
  }) {
    return CareRemindersCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      eventId: eventId ?? this.eventId,
      offsetDays: offsetDays ?? this.offsetDays,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (offsetDays.present) {
      map['offset_days'] = Variable<int>(offsetDays.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareRemindersCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('eventId: $eventId, ')
          ..write('offsetDays: $offsetDays, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShiftTemplatesTable extends ShiftTemplates
    with TableInfo<$ShiftTemplatesTable, ShiftTemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortCodeMeta = const VerificationMeta(
    'shortCode',
  );
  @override
  late final GeneratedColumn<String> shortCode = GeneratedColumn<String>(
    'short_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMinutesMeta = const VerificationMeta(
    'startMinutes',
  );
  @override
  late final GeneratedColumn<int> startMinutes = GeneratedColumn<int>(
    'start_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endMinutesMeta = const VerificationMeta(
    'endMinutes',
  );
  @override
  late final GeneratedColumn<int> endMinutes = GeneratedColumn<int>(
    'end_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stableMinutesMeta = const VerificationMeta(
    'stableMinutes',
  );
  @override
  late final GeneratedColumn<int> stableMinutes = GeneratedColumn<int>(
    'stable_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preferredTimeMeta = const VerificationMeta(
    'preferredTime',
  );
  @override
  late final GeneratedColumn<String> preferredTime = GeneratedColumn<String>(
    'preferred_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isNightMeta = const VerificationMeta(
    'isNight',
  );
  @override
  late final GeneratedColumn<bool> isNight = GeneratedColumn<bool>(
    'is_night',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_night" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    name,
    shortCode,
    color,
    startMinutes,
    endMinutes,
    stableMinutes,
    preferredTime,
    isNight,
    archived,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shift_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShiftTemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('short_code')) {
      context.handle(
        _shortCodeMeta,
        shortCode.isAcceptableOrUnknown(data['short_code']!, _shortCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_shortCodeMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('start_minutes')) {
      context.handle(
        _startMinutesMeta,
        startMinutes.isAcceptableOrUnknown(
          data['start_minutes']!,
          _startMinutesMeta,
        ),
      );
    }
    if (data.containsKey('end_minutes')) {
      context.handle(
        _endMinutesMeta,
        endMinutes.isAcceptableOrUnknown(data['end_minutes']!, _endMinutesMeta),
      );
    }
    if (data.containsKey('stable_minutes')) {
      context.handle(
        _stableMinutesMeta,
        stableMinutes.isAcceptableOrUnknown(
          data['stable_minutes']!,
          _stableMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stableMinutesMeta);
    }
    if (data.containsKey('preferred_time')) {
      context.handle(
        _preferredTimeMeta,
        preferredTime.isAcceptableOrUnknown(
          data['preferred_time']!,
          _preferredTimeMeta,
        ),
      );
    }
    if (data.containsKey('is_night')) {
      context.handle(
        _isNightMeta,
        isNight.isAcceptableOrUnknown(data['is_night']!, _isNightMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShiftTemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftTemplateRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      shortCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_code'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      startMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minutes'],
      ),
      endMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minutes'],
      ),
      stableMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stable_minutes'],
      )!,
      preferredTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_time'],
      ),
      isNight: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_night'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ShiftTemplatesTable createAlias(String alias) {
    return $ShiftTemplatesTable(attachedDatabase, alias);
  }
}

class ShiftTemplateRow extends DataClass
    implements Insertable<ShiftTemplateRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String name;
  final String shortCode;
  final int color;
  final int? startMinutes;
  final int? endMinutes;

  /// Stallzeit an diesem Tag (Minuten).
  final int stableMinutes;

  /// Siehe `DayTime.key`.
  final String? preferredTime;
  final bool isNight;
  final bool archived;
  final int sortOrder;
  const ShiftTemplateRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.shortCode,
    required this.color,
    this.startMinutes,
    this.endMinutes,
    required this.stableMinutes,
    this.preferredTime,
    required this.isNight,
    required this.archived,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['short_code'] = Variable<String>(shortCode);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || startMinutes != null) {
      map['start_minutes'] = Variable<int>(startMinutes);
    }
    if (!nullToAbsent || endMinutes != null) {
      map['end_minutes'] = Variable<int>(endMinutes);
    }
    map['stable_minutes'] = Variable<int>(stableMinutes);
    if (!nullToAbsent || preferredTime != null) {
      map['preferred_time'] = Variable<String>(preferredTime);
    }
    map['is_night'] = Variable<bool>(isNight);
    map['archived'] = Variable<bool>(archived);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ShiftTemplatesCompanion toCompanion(bool nullToAbsent) {
    return ShiftTemplatesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      name: Value(name),
      shortCode: Value(shortCode),
      color: Value(color),
      startMinutes: startMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(startMinutes),
      endMinutes: endMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(endMinutes),
      stableMinutes: Value(stableMinutes),
      preferredTime: preferredTime == null && nullToAbsent
          ? const Value.absent()
          : Value(preferredTime),
      isNight: Value(isNight),
      archived: Value(archived),
      sortOrder: Value(sortOrder),
    );
  }

  factory ShiftTemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftTemplateRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shortCode: serializer.fromJson<String>(json['shortCode']),
      color: serializer.fromJson<int>(json['color']),
      startMinutes: serializer.fromJson<int?>(json['startMinutes']),
      endMinutes: serializer.fromJson<int?>(json['endMinutes']),
      stableMinutes: serializer.fromJson<int>(json['stableMinutes']),
      preferredTime: serializer.fromJson<String?>(json['preferredTime']),
      isNight: serializer.fromJson<bool>(json['isNight']),
      archived: serializer.fromJson<bool>(json['archived']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'shortCode': serializer.toJson<String>(shortCode),
      'color': serializer.toJson<int>(color),
      'startMinutes': serializer.toJson<int?>(startMinutes),
      'endMinutes': serializer.toJson<int?>(endMinutes),
      'stableMinutes': serializer.toJson<int>(stableMinutes),
      'preferredTime': serializer.toJson<String?>(preferredTime),
      'isNight': serializer.toJson<bool>(isNight),
      'archived': serializer.toJson<bool>(archived),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ShiftTemplateRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? name,
    String? shortCode,
    int? color,
    Value<int?> startMinutes = const Value.absent(),
    Value<int?> endMinutes = const Value.absent(),
    int? stableMinutes,
    Value<String?> preferredTime = const Value.absent(),
    bool? isNight,
    bool? archived,
    int? sortOrder,
  }) => ShiftTemplateRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    shortCode: shortCode ?? this.shortCode,
    color: color ?? this.color,
    startMinutes: startMinutes.present ? startMinutes.value : this.startMinutes,
    endMinutes: endMinutes.present ? endMinutes.value : this.endMinutes,
    stableMinutes: stableMinutes ?? this.stableMinutes,
    preferredTime: preferredTime.present
        ? preferredTime.value
        : this.preferredTime,
    isNight: isNight ?? this.isNight,
    archived: archived ?? this.archived,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ShiftTemplateRow copyWithCompanion(ShiftTemplatesCompanion data) {
    return ShiftTemplateRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      shortCode: data.shortCode.present ? data.shortCode.value : this.shortCode,
      color: data.color.present ? data.color.value : this.color,
      startMinutes: data.startMinutes.present
          ? data.startMinutes.value
          : this.startMinutes,
      endMinutes: data.endMinutes.present
          ? data.endMinutes.value
          : this.endMinutes,
      stableMinutes: data.stableMinutes.present
          ? data.stableMinutes.value
          : this.stableMinutes,
      preferredTime: data.preferredTime.present
          ? data.preferredTime.value
          : this.preferredTime,
      isNight: data.isNight.present ? data.isNight.value : this.isNight,
      archived: data.archived.present ? data.archived.value : this.archived,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftTemplateRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortCode: $shortCode, ')
          ..write('color: $color, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes, ')
          ..write('stableMinutes: $stableMinutes, ')
          ..write('preferredTime: $preferredTime, ')
          ..write('isNight: $isNight, ')
          ..write('archived: $archived, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    name,
    shortCode,
    color,
    startMinutes,
    endMinutes,
    stableMinutes,
    preferredTime,
    isNight,
    archived,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftTemplateRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.shortCode == this.shortCode &&
          other.color == this.color &&
          other.startMinutes == this.startMinutes &&
          other.endMinutes == this.endMinutes &&
          other.stableMinutes == this.stableMinutes &&
          other.preferredTime == this.preferredTime &&
          other.isNight == this.isNight &&
          other.archived == this.archived &&
          other.sortOrder == this.sortOrder);
}

class ShiftTemplatesCompanion extends UpdateCompanion<ShiftTemplateRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> shortCode;
  final Value<int> color;
  final Value<int?> startMinutes;
  final Value<int?> endMinutes;
  final Value<int> stableMinutes;
  final Value<String?> preferredTime;
  final Value<bool> isNight;
  final Value<bool> archived;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ShiftTemplatesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.shortCode = const Value.absent(),
    this.color = const Value.absent(),
    this.startMinutes = const Value.absent(),
    this.endMinutes = const Value.absent(),
    this.stableMinutes = const Value.absent(),
    this.preferredTime = const Value.absent(),
    this.isNight = const Value.absent(),
    this.archived = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftTemplatesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String name,
    required String shortCode,
    required int color,
    this.startMinutes = const Value.absent(),
    this.endMinutes = const Value.absent(),
    required int stableMinutes,
    this.preferredTime = const Value.absent(),
    this.isNight = const Value.absent(),
    this.archived = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       shortCode = Value(shortCode),
       color = Value(color),
       stableMinutes = Value(stableMinutes);
  static Insertable<ShiftTemplateRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? shortCode,
    Expression<int>? color,
    Expression<int>? startMinutes,
    Expression<int>? endMinutes,
    Expression<int>? stableMinutes,
    Expression<String>? preferredTime,
    Expression<bool>? isNight,
    Expression<bool>? archived,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shortCode != null) 'short_code': shortCode,
      if (color != null) 'color': color,
      if (startMinutes != null) 'start_minutes': startMinutes,
      if (endMinutes != null) 'end_minutes': endMinutes,
      if (stableMinutes != null) 'stable_minutes': stableMinutes,
      if (preferredTime != null) 'preferred_time': preferredTime,
      if (isNight != null) 'is_night': isNight,
      if (archived != null) 'archived': archived,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftTemplatesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? shortCode,
    Value<int>? color,
    Value<int?>? startMinutes,
    Value<int?>? endMinutes,
    Value<int>? stableMinutes,
    Value<String?>? preferredTime,
    Value<bool>? isNight,
    Value<bool>? archived,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ShiftTemplatesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      shortCode: shortCode ?? this.shortCode,
      color: color ?? this.color,
      startMinutes: startMinutes ?? this.startMinutes,
      endMinutes: endMinutes ?? this.endMinutes,
      stableMinutes: stableMinutes ?? this.stableMinutes,
      preferredTime: preferredTime ?? this.preferredTime,
      isNight: isNight ?? this.isNight,
      archived: archived ?? this.archived,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (shortCode.present) {
      map['short_code'] = Variable<String>(shortCode.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (startMinutes.present) {
      map['start_minutes'] = Variable<int>(startMinutes.value);
    }
    if (endMinutes.present) {
      map['end_minutes'] = Variable<int>(endMinutes.value);
    }
    if (stableMinutes.present) {
      map['stable_minutes'] = Variable<int>(stableMinutes.value);
    }
    if (preferredTime.present) {
      map['preferred_time'] = Variable<String>(preferredTime.value);
    }
    if (isNight.present) {
      map['is_night'] = Variable<bool>(isNight.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftTemplatesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortCode: $shortCode, ')
          ..write('color: $color, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes, ')
          ..write('stableMinutes: $stableMinutes, ')
          ..write('preferredTime: $preferredTime, ')
          ..write('isNight: $isNight, ')
          ..write('archived: $archived, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShiftPatternsTable extends ShiftPatterns
    with TableInfo<$ShiftPatternsTable, ShiftPatternRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftPatternsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<String> steps = GeneratedColumn<String>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> startDate =
      GeneratedColumn<String>(
        'start_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>($ShiftPatternsTable.$converterstartDate);
  static const VerificationMeta _weeksMeta = const VerificationMeta('weeks');
  @override
  late final GeneratedColumn<int> weeks = GeneratedColumn<int>(
    'weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    name,
    steps,
    startDate,
    weeks,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shift_patterns';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShiftPatternRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('weeks')) {
      context.handle(
        _weeksMeta,
        weeks.isAcceptableOrUnknown(data['weeks']!, _weeksMeta),
      );
    } else if (isInserting) {
      context.missing(_weeksMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShiftPatternRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftPatternRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}steps'],
      )!,
      startDate: $ShiftPatternsTable.$converterstartDate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}start_date'],
        )!,
      ),
      weeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weeks'],
      )!,
    );
  }

  @override
  $ShiftPatternsTable createAlias(String alias) {
    return $ShiftPatternsTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterstartDate =
      const LocalDateConverter();
}

class ShiftPatternRow extends DataClass implements Insertable<ShiftPatternRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String name;

  /// JSON-Liste von Vorlagen-IDs bzw. `null` (Tag ohne Schicht).
  final String steps;
  final LocalDate startDate;
  final int weeks;
  const ShiftPatternRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.steps,
    required this.startDate,
    required this.weeks,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['steps'] = Variable<String>(steps);
    {
      map['start_date'] = Variable<String>(
        $ShiftPatternsTable.$converterstartDate.toSql(startDate),
      );
    }
    map['weeks'] = Variable<int>(weeks);
    return map;
  }

  ShiftPatternsCompanion toCompanion(bool nullToAbsent) {
    return ShiftPatternsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      name: Value(name),
      steps: Value(steps),
      startDate: Value(startDate),
      weeks: Value(weeks),
    );
  }

  factory ShiftPatternRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftPatternRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      steps: serializer.fromJson<String>(json['steps']),
      startDate: serializer.fromJson<LocalDate>(json['startDate']),
      weeks: serializer.fromJson<int>(json['weeks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'steps': serializer.toJson<String>(steps),
      'startDate': serializer.toJson<LocalDate>(startDate),
      'weeks': serializer.toJson<int>(weeks),
    };
  }

  ShiftPatternRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? name,
    String? steps,
    LocalDate? startDate,
    int? weeks,
  }) => ShiftPatternRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    steps: steps ?? this.steps,
    startDate: startDate ?? this.startDate,
    weeks: weeks ?? this.weeks,
  );
  ShiftPatternRow copyWithCompanion(ShiftPatternsCompanion data) {
    return ShiftPatternRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      steps: data.steps.present ? data.steps.value : this.steps,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      weeks: data.weeks.present ? data.weeks.value : this.weeks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftPatternRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('steps: $steps, ')
          ..write('startDate: $startDate, ')
          ..write('weeks: $weeks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, name, steps, startDate, weeks);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftPatternRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.steps == this.steps &&
          other.startDate == this.startDate &&
          other.weeks == this.weeks);
}

class ShiftPatternsCompanion extends UpdateCompanion<ShiftPatternRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> steps;
  final Value<LocalDate> startDate;
  final Value<int> weeks;
  final Value<int> rowid;
  const ShiftPatternsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.steps = const Value.absent(),
    this.startDate = const Value.absent(),
    this.weeks = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftPatternsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String name,
    required String steps,
    required LocalDate startDate,
    required int weeks,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       steps = Value(steps),
       startDate = Value(startDate),
       weeks = Value(weeks);
  static Insertable<ShiftPatternRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? steps,
    Expression<String>? startDate,
    Expression<int>? weeks,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (steps != null) 'steps': steps,
      if (startDate != null) 'start_date': startDate,
      if (weeks != null) 'weeks': weeks,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftPatternsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? steps,
    Value<LocalDate>? startDate,
    Value<int>? weeks,
    Value<int>? rowid,
  }) {
    return ShiftPatternsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      steps: steps ?? this.steps,
      startDate: startDate ?? this.startDate,
      weeks: weeks ?? this.weeks,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (steps.present) {
      map['steps'] = Variable<String>(steps.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(
        $ShiftPatternsTable.$converterstartDate.toSql(startDate.value),
      );
    }
    if (weeks.present) {
      map['weeks'] = Variable<int>(weeks.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftPatternsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('steps: $steps, ')
          ..write('startDate: $startDate, ')
          ..write('weeks: $weeks, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShiftDaysTable extends ShiftDays
    with TableInfo<$ShiftDaysTable, ShiftDayRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> date =
      GeneratedColumn<String>(
        'date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>($ShiftDaysTable.$converterdate);
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shift_templates (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _overrideMinutesMeta = const VerificationMeta(
    'overrideMinutes',
  );
  @override
  late final GeneratedColumn<int> overrideMinutes = GeneratedColumn<int>(
    'override_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _otherPersonCoversMeta = const VerificationMeta(
    'otherPersonCovers',
  );
  @override
  late final GeneratedColumn<bool> otherPersonCovers = GeneratedColumn<bool>(
    'other_person_covers',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("other_person_covers" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _patternIdMeta = const VerificationMeta(
    'patternId',
  );
  @override
  late final GeneratedColumn<String> patternId = GeneratedColumn<String>(
    'pattern_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shift_patterns (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    date,
    templateId,
    overrideMinutes,
    otherPersonCovers,
    note,
    source,
    patternId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shift_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShiftDayRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('override_minutes')) {
      context.handle(
        _overrideMinutesMeta,
        overrideMinutes.isAcceptableOrUnknown(
          data['override_minutes']!,
          _overrideMinutesMeta,
        ),
      );
    }
    if (data.containsKey('other_person_covers')) {
      context.handle(
        _otherPersonCoversMeta,
        otherPersonCovers.isAcceptableOrUnknown(
          data['other_person_covers']!,
          _otherPersonCoversMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('pattern_id')) {
      context.handle(
        _patternIdMeta,
        patternId.isAcceptableOrUnknown(data['pattern_id']!, _patternIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  ShiftDayRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftDayRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      date: $ShiftDaysTable.$converterdate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}date'],
        )!,
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      overrideMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}override_minutes'],
      ),
      otherPersonCovers: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}other_person_covers'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      patternId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern_id'],
      ),
    );
  }

  @override
  $ShiftDaysTable createAlias(String alias) {
    return $ShiftDaysTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterdate =
      const LocalDateConverter();
}

class ShiftDayRow extends DataClass implements Insertable<ShiftDayRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Ein Eintrag pro Kalendertag.
  final LocalDate date;
  final String? templateId;
  final int? overrideMinutes;
  final bool otherPersonCovers;
  final String? note;

  /// Siehe `ShiftSource.key`.
  final String source;
  final String? patternId;
  const ShiftDayRow({
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    this.templateId,
    this.overrideMinutes,
    required this.otherPersonCovers,
    this.note,
    required this.source,
    this.patternId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    {
      map['date'] = Variable<String>(
        $ShiftDaysTable.$converterdate.toSql(date),
      );
    }
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    if (!nullToAbsent || overrideMinutes != null) {
      map['override_minutes'] = Variable<int>(overrideMinutes);
    }
    map['other_person_covers'] = Variable<bool>(otherPersonCovers);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || patternId != null) {
      map['pattern_id'] = Variable<String>(patternId);
    }
    return map;
  }

  ShiftDaysCompanion toCompanion(bool nullToAbsent) {
    return ShiftDaysCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      date: Value(date),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      overrideMinutes: overrideMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(overrideMinutes),
      otherPersonCovers: Value(otherPersonCovers),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      source: Value(source),
      patternId: patternId == null && nullToAbsent
          ? const Value.absent()
          : Value(patternId),
    );
  }

  factory ShiftDayRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftDayRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      date: serializer.fromJson<LocalDate>(json['date']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      overrideMinutes: serializer.fromJson<int?>(json['overrideMinutes']),
      otherPersonCovers: serializer.fromJson<bool>(json['otherPersonCovers']),
      note: serializer.fromJson<String?>(json['note']),
      source: serializer.fromJson<String>(json['source']),
      patternId: serializer.fromJson<String?>(json['patternId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'date': serializer.toJson<LocalDate>(date),
      'templateId': serializer.toJson<String?>(templateId),
      'overrideMinutes': serializer.toJson<int?>(overrideMinutes),
      'otherPersonCovers': serializer.toJson<bool>(otherPersonCovers),
      'note': serializer.toJson<String?>(note),
      'source': serializer.toJson<String>(source),
      'patternId': serializer.toJson<String?>(patternId),
    };
  }

  ShiftDayRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    LocalDate? date,
    Value<String?> templateId = const Value.absent(),
    Value<int?> overrideMinutes = const Value.absent(),
    bool? otherPersonCovers,
    Value<String?> note = const Value.absent(),
    String? source,
    Value<String?> patternId = const Value.absent(),
  }) => ShiftDayRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    date: date ?? this.date,
    templateId: templateId.present ? templateId.value : this.templateId,
    overrideMinutes: overrideMinutes.present
        ? overrideMinutes.value
        : this.overrideMinutes,
    otherPersonCovers: otherPersonCovers ?? this.otherPersonCovers,
    note: note.present ? note.value : this.note,
    source: source ?? this.source,
    patternId: patternId.present ? patternId.value : this.patternId,
  );
  ShiftDayRow copyWithCompanion(ShiftDaysCompanion data) {
    return ShiftDayRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      date: data.date.present ? data.date.value : this.date,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      overrideMinutes: data.overrideMinutes.present
          ? data.overrideMinutes.value
          : this.overrideMinutes,
      otherPersonCovers: data.otherPersonCovers.present
          ? data.otherPersonCovers.value
          : this.otherPersonCovers,
      note: data.note.present ? data.note.value : this.note,
      source: data.source.present ? data.source.value : this.source,
      patternId: data.patternId.present ? data.patternId.value : this.patternId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftDayRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date, ')
          ..write('templateId: $templateId, ')
          ..write('overrideMinutes: $overrideMinutes, ')
          ..write('otherPersonCovers: $otherPersonCovers, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('patternId: $patternId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    date,
    templateId,
    overrideMinutes,
    otherPersonCovers,
    note,
    source,
    patternId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftDayRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.date == this.date &&
          other.templateId == this.templateId &&
          other.overrideMinutes == this.overrideMinutes &&
          other.otherPersonCovers == this.otherPersonCovers &&
          other.note == this.note &&
          other.source == this.source &&
          other.patternId == this.patternId);
}

class ShiftDaysCompanion extends UpdateCompanion<ShiftDayRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<LocalDate> date;
  final Value<String?> templateId;
  final Value<int?> overrideMinutes;
  final Value<bool> otherPersonCovers;
  final Value<String?> note;
  final Value<String> source;
  final Value<String?> patternId;
  final Value<int> rowid;
  const ShiftDaysCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.date = const Value.absent(),
    this.templateId = const Value.absent(),
    this.overrideMinutes = const Value.absent(),
    this.otherPersonCovers = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.patternId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftDaysCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required LocalDate date,
    this.templateId = const Value.absent(),
    this.overrideMinutes = const Value.absent(),
    this.otherPersonCovers = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.patternId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<ShiftDayRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? date,
    Expression<String>? templateId,
    Expression<int>? overrideMinutes,
    Expression<bool>? otherPersonCovers,
    Expression<String>? note,
    Expression<String>? source,
    Expression<String>? patternId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (date != null) 'date': date,
      if (templateId != null) 'template_id': templateId,
      if (overrideMinutes != null) 'override_minutes': overrideMinutes,
      if (otherPersonCovers != null) 'other_person_covers': otherPersonCovers,
      if (note != null) 'note': note,
      if (source != null) 'source': source,
      if (patternId != null) 'pattern_id': patternId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftDaysCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<LocalDate>? date,
    Value<String?>? templateId,
    Value<int?>? overrideMinutes,
    Value<bool>? otherPersonCovers,
    Value<String?>? note,
    Value<String>? source,
    Value<String?>? patternId,
    Value<int>? rowid,
  }) {
    return ShiftDaysCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      date: date ?? this.date,
      templateId: templateId ?? this.templateId,
      overrideMinutes: overrideMinutes ?? this.overrideMinutes,
      otherPersonCovers: otherPersonCovers ?? this.otherPersonCovers,
      note: note ?? this.note,
      source: source ?? this.source,
      patternId: patternId ?? this.patternId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(
        $ShiftDaysTable.$converterdate.toSql(date.value),
      );
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (overrideMinutes.present) {
      map['override_minutes'] = Variable<int>(overrideMinutes.value);
    }
    if (otherPersonCovers.present) {
      map['other_person_covers'] = Variable<bool>(otherPersonCovers.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (patternId.present) {
      map['pattern_id'] = Variable<String>(patternId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftDaysCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('date: $date, ')
          ..write('templateId: $templateId, ')
          ..write('overrideMinutes: $overrideMinutes, ')
          ..write('otherPersonCovers: $otherPersonCovers, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('patternId: $patternId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $HorsesTable horses = $HorsesTable(this);
  late final $HorsePhotosTable horsePhotos = $HorsePhotosTable(this);
  late final $HorseWeightsTable horseWeights = $HorseWeightsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $HorseContactsTable horseContacts = $HorseContactsTable(this);
  late final $CareEventTypesTable careEventTypes = $CareEventTypesTable(this);
  late final $CareIntervalDefaultsTable careIntervalDefaults =
      $CareIntervalDefaultsTable(this);
  late final $CareEventsTable careEvents = $CareEventsTable(this);
  late final $CareRemindersTable careReminders = $CareRemindersTable(this);
  late final $ShiftTemplatesTable shiftTemplates = $ShiftTemplatesTable(this);
  late final $ShiftPatternsTable shiftPatterns = $ShiftPatternsTable(this);
  late final $ShiftDaysTable shiftDays = $ShiftDaysTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    settings,
    horses,
    horsePhotos,
    horseWeights,
    contacts,
    horseContacts,
    careEventTypes,
    careIntervalDefaults,
    careEvents,
    careReminders,
    shiftTemplates,
    shiftPatterns,
    shiftDays,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('horse_photos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('horse_weights', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('horse_contacts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'contacts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('horse_contacts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'care_event_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_interval_defaults', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'care_events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('care_reminders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'shift_templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('shift_days', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'shift_patterns',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('shift_days', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingRow,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            SettingRow,
            BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>,
          ),
          SettingRow,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, SettingRow>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingRow,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (SettingRow, BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>),
      SettingRow,
      PrefetchHooks Function()
    >;
typedef $$HorsesTableCreateCompanionBuilder = HorsesCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String id,
  required String name,
  Value<String?> callName,
  Value<LocalDate?> birthDate,
  Value<bool> birthdayReminder,
  Value<String?> sex,
  Value<String?> breed,
  Value<String?> colorMarkings,
  Value<int?> heightCm,
  Value<String?> ueln,
  Value<String?> chipNumber,
  Value<String?> passportNumber,
  Value<String?> sire,
  Value<String?> dam,
  Value<String?> stableLocation,
  Value<String?> keepingType,
  Value<String?> owner,
  Value<String?> insurance,
  Value<String?> intolerances,
  Value<String?> medicalHistory,
  Value<String?> notes,
  Value<String?> profilePhotoId,
  Value<DateTime?> archivedAt,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$HorsesTableUpdateCompanionBuilder = HorsesCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> id,
  Value<String> name,
  Value<String?> callName,
  Value<LocalDate?> birthDate,
  Value<bool> birthdayReminder,
  Value<String?> sex,
  Value<String?> breed,
  Value<String?> colorMarkings,
  Value<int?> heightCm,
  Value<String?> ueln,
  Value<String?> chipNumber,
  Value<String?> passportNumber,
  Value<String?> sire,
  Value<String?> dam,
  Value<String?> stableLocation,
  Value<String?> keepingType,
  Value<String?> owner,
  Value<String?> insurance,
  Value<String?> intolerances,
  Value<String?> medicalHistory,
  Value<String?> notes,
  Value<String?> profilePhotoId,
  Value<DateTime?> archivedAt,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$HorsesTableReferences
    extends BaseReferences<_$AppDatabase, $HorsesTable, HorseRow> {
  $$HorsesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HorsePhotosTable, List<HorsePhotoRow>>
  _horsePhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.horsePhotos,
    aliasName: 'horses__id__horse_photos__horse_id',
  );

  $$HorsePhotosTableProcessedTableManager get horsePhotosRefs {
    final manager = $$HorsePhotosTableTableManager(
      $_db,
      $_db.horsePhotos,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_horsePhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HorseWeightsTable, List<HorseWeightRow>>
  _horseWeightsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.horseWeights,
    aliasName: 'horses__id__horse_weights__horse_id',
  );

  $$HorseWeightsTableProcessedTableManager get horseWeightsRefs {
    final manager = $$HorseWeightsTableTableManager(
      $_db,
      $_db.horseWeights,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_horseWeightsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HorseContactsTable, List<HorseContactRow>>
  _horseContactsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.horseContacts,
    aliasName: 'horses__id__horse_contacts__horse_id',
  );

  $$HorseContactsTableProcessedTableManager get horseContactsRefs {
    final manager = $$HorseContactsTableTableManager(
      $_db,
      $_db.horseContacts,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_horseContactsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareEventsTable, List<CareEventRow>>
  _careEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careEvents,
    aliasName: 'horses__id__care_events__horse_id',
  );

  $$CareEventsTableProcessedTableManager get careEventsRefs {
    final manager = $$CareEventsTableTableManager(
      $_db,
      $_db.careEvents,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HorsesTableFilterComposer
    extends Composer<_$AppDatabase, $HorsesTable> {
  $$HorsesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get callName => $composableBuilder(
    column: $table.callName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate?, LocalDate, String> get birthDate =>
      $composableBuilder(
        column: $table.birthDate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get birthdayReminder => $composableBuilder(
    column: $table.birthdayReminder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorMarkings => $composableBuilder(
    column: $table.colorMarkings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ueln => $composableBuilder(
    column: $table.ueln,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chipNumber => $composableBuilder(
    column: $table.chipNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passportNumber => $composableBuilder(
    column: $table.passportNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sire => $composableBuilder(
    column: $table.sire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dam => $composableBuilder(
    column: $table.dam,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stableLocation => $composableBuilder(
    column: $table.stableLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keepingType => $composableBuilder(
    column: $table.keepingType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get insurance => $composableBuilder(
    column: $table.insurance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intolerances => $composableBuilder(
    column: $table.intolerances,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicalHistory => $composableBuilder(
    column: $table.medicalHistory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profilePhotoId => $composableBuilder(
    column: $table.profilePhotoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> horsePhotosRefs(
    Expression<bool> Function($$HorsePhotosTableFilterComposer f) f,
  ) {
    final $$HorsePhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horsePhotos,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsePhotosTableFilterComposer(
            $db: $db,
            $table: $db.horsePhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> horseWeightsRefs(
    Expression<bool> Function($$HorseWeightsTableFilterComposer f) f,
  ) {
    final $$HorseWeightsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horseWeights,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorseWeightsTableFilterComposer(
            $db: $db,
            $table: $db.horseWeights,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> horseContactsRefs(
    Expression<bool> Function($$HorseContactsTableFilterComposer f) f,
  ) {
    final $$HorseContactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horseContacts,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorseContactsTableFilterComposer(
            $db: $db,
            $table: $db.horseContacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careEventsRefs(
    Expression<bool> Function($$CareEventsTableFilterComposer f) f,
  ) {
    final $$CareEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careEvents,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventsTableFilterComposer(
            $db: $db,
            $table: $db.careEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HorsesTableOrderingComposer
    extends Composer<_$AppDatabase, $HorsesTable> {
  $$HorsesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get callName => $composableBuilder(
    column: $table.callName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get birthdayReminder => $composableBuilder(
    column: $table.birthdayReminder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorMarkings => $composableBuilder(
    column: $table.colorMarkings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ueln => $composableBuilder(
    column: $table.ueln,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chipNumber => $composableBuilder(
    column: $table.chipNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passportNumber => $composableBuilder(
    column: $table.passportNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sire => $composableBuilder(
    column: $table.sire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dam => $composableBuilder(
    column: $table.dam,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stableLocation => $composableBuilder(
    column: $table.stableLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keepingType => $composableBuilder(
    column: $table.keepingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get insurance => $composableBuilder(
    column: $table.insurance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intolerances => $composableBuilder(
    column: $table.intolerances,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicalHistory => $composableBuilder(
    column: $table.medicalHistory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profilePhotoId => $composableBuilder(
    column: $table.profilePhotoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HorsesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HorsesTable> {
  $$HorsesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get callName =>
      $composableBuilder(column: $table.callName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate?, String> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<bool> get birthdayReminder => $composableBuilder(
    column: $table.birthdayReminder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<String> get colorMarkings => $composableBuilder(
    column: $table.colorMarkings,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<String> get ueln =>
      $composableBuilder(column: $table.ueln, builder: (column) => column);

  GeneratedColumn<String> get chipNumber => $composableBuilder(
    column: $table.chipNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passportNumber => $composableBuilder(
    column: $table.passportNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sire =>
      $composableBuilder(column: $table.sire, builder: (column) => column);

  GeneratedColumn<String> get dam =>
      $composableBuilder(column: $table.dam, builder: (column) => column);

  GeneratedColumn<String> get stableLocation => $composableBuilder(
    column: $table.stableLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keepingType => $composableBuilder(
    column: $table.keepingType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get owner =>
      $composableBuilder(column: $table.owner, builder: (column) => column);

  GeneratedColumn<String> get insurance =>
      $composableBuilder(column: $table.insurance, builder: (column) => column);

  GeneratedColumn<String> get intolerances => $composableBuilder(
    column: $table.intolerances,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medicalHistory => $composableBuilder(
    column: $table.medicalHistory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get profilePhotoId => $composableBuilder(
    column: $table.profilePhotoId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> horsePhotosRefs<T extends Object>(
    Expression<T> Function($$HorsePhotosTableAnnotationComposer a) f,
  ) {
    final $$HorsePhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horsePhotos,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsePhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.horsePhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> horseWeightsRefs<T extends Object>(
    Expression<T> Function($$HorseWeightsTableAnnotationComposer a) f,
  ) {
    final $$HorseWeightsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horseWeights,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorseWeightsTableAnnotationComposer(
            $db: $db,
            $table: $db.horseWeights,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> horseContactsRefs<T extends Object>(
    Expression<T> Function($$HorseContactsTableAnnotationComposer a) f,
  ) {
    final $$HorseContactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horseContacts,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorseContactsTableAnnotationComposer(
            $db: $db,
            $table: $db.horseContacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careEventsRefs<T extends Object>(
    Expression<T> Function($$CareEventsTableAnnotationComposer a) f,
  ) {
    final $$CareEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careEvents,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.careEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HorsesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HorsesTable,
          HorseRow,
          $$HorsesTableFilterComposer,
          $$HorsesTableOrderingComposer,
          $$HorsesTableAnnotationComposer,
          $$HorsesTableCreateCompanionBuilder,
          $$HorsesTableUpdateCompanionBuilder,
          (HorseRow, $$HorsesTableReferences),
          HorseRow,
          PrefetchHooks Function({
            bool horsePhotosRefs,
            bool horseWeightsRefs,
            bool horseContactsRefs,
            bool careEventsRefs,
          })
        > {
  $$HorsesTableTableManager(_$AppDatabase db, $HorsesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HorsesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HorsesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HorsesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> callName = const Value.absent(),
                Value<LocalDate?> birthDate = const Value.absent(),
                Value<bool> birthdayReminder = const Value.absent(),
                Value<String?> sex = const Value.absent(),
                Value<String?> breed = const Value.absent(),
                Value<String?> colorMarkings = const Value.absent(),
                Value<int?> heightCm = const Value.absent(),
                Value<String?> ueln = const Value.absent(),
                Value<String?> chipNumber = const Value.absent(),
                Value<String?> passportNumber = const Value.absent(),
                Value<String?> sire = const Value.absent(),
                Value<String?> dam = const Value.absent(),
                Value<String?> stableLocation = const Value.absent(),
                Value<String?> keepingType = const Value.absent(),
                Value<String?> owner = const Value.absent(),
                Value<String?> insurance = const Value.absent(),
                Value<String?> intolerances = const Value.absent(),
                Value<String?> medicalHistory = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> profilePhotoId = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HorsesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                callName: callName,
                birthDate: birthDate,
                birthdayReminder: birthdayReminder,
                sex: sex,
                breed: breed,
                colorMarkings: colorMarkings,
                heightCm: heightCm,
                ueln: ueln,
                chipNumber: chipNumber,
                passportNumber: passportNumber,
                sire: sire,
                dam: dam,
                stableLocation: stableLocation,
                keepingType: keepingType,
                owner: owner,
                insurance: insurance,
                intolerances: intolerances,
                medicalHistory: medicalHistory,
                notes: notes,
                profilePhotoId: profilePhotoId,
                archivedAt: archivedAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String name,
                Value<String?> callName = const Value.absent(),
                Value<LocalDate?> birthDate = const Value.absent(),
                Value<bool> birthdayReminder = const Value.absent(),
                Value<String?> sex = const Value.absent(),
                Value<String?> breed = const Value.absent(),
                Value<String?> colorMarkings = const Value.absent(),
                Value<int?> heightCm = const Value.absent(),
                Value<String?> ueln = const Value.absent(),
                Value<String?> chipNumber = const Value.absent(),
                Value<String?> passportNumber = const Value.absent(),
                Value<String?> sire = const Value.absent(),
                Value<String?> dam = const Value.absent(),
                Value<String?> stableLocation = const Value.absent(),
                Value<String?> keepingType = const Value.absent(),
                Value<String?> owner = const Value.absent(),
                Value<String?> insurance = const Value.absent(),
                Value<String?> intolerances = const Value.absent(),
                Value<String?> medicalHistory = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> profilePhotoId = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HorsesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                callName: callName,
                birthDate: birthDate,
                birthdayReminder: birthdayReminder,
                sex: sex,
                breed: breed,
                colorMarkings: colorMarkings,
                heightCm: heightCm,
                ueln: ueln,
                chipNumber: chipNumber,
                passportNumber: passportNumber,
                sire: sire,
                dam: dam,
                stableLocation: stableLocation,
                keepingType: keepingType,
                owner: owner,
                insurance: insurance,
                intolerances: intolerances,
                medicalHistory: medicalHistory,
                notes: notes,
                profilePhotoId: profilePhotoId,
                archivedAt: archivedAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HorsesTable, HorseRow>(table),
                  $$HorsesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                horsePhotosRefs = false,
                horseWeightsRefs = false,
                horseContactsRefs = false,
                careEventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (horsePhotosRefs) db.horsePhotos,
                    if (horseWeightsRefs) db.horseWeights,
                    if (horseContactsRefs) db.horseContacts,
                    if (careEventsRefs) db.careEvents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (horsePhotosRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          HorsePhotoRow,
                          $HorsePhotosTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._horsePhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).horsePhotosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'horse_id',
                          typedResults: items,
                        ),
                      if (horseWeightsRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          HorseWeightRow,
                          $HorseWeightsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._horseWeightsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).horseWeightsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'horse_id',
                          typedResults: items,
                        ),
                      if (horseContactsRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          HorseContactRow,
                          $HorseContactsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._horseContactsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).horseContactsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'horse_id',
                          typedResults: items,
                        ),
                      if (careEventsRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          CareEventRow,
                          $CareEventsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._careEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).careEventsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'horse_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HorsesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HorsesTable,
      HorseRow,
      $$HorsesTableFilterComposer,
      $$HorsesTableOrderingComposer,
      $$HorsesTableAnnotationComposer,
      $$HorsesTableCreateCompanionBuilder,
      $$HorsesTableUpdateCompanionBuilder,
      (HorseRow, $$HorsesTableReferences),
      HorseRow,
      PrefetchHooks Function({
        bool horsePhotosRefs,
        bool horseWeightsRefs,
        bool horseContactsRefs,
        bool careEventsRefs,
      })
    >;
typedef $$HorsePhotosTableCreateCompanionBuilder =
    HorsePhotosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String horseId,
      required String relativePath,
      Value<int> rowid,
    });
typedef $$HorsePhotosTableUpdateCompanionBuilder =
    HorsePhotosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> horseId,
      Value<String> relativePath,
      Value<int> rowid,
    });

final class $$HorsePhotosTableReferences
    extends BaseReferences<_$AppDatabase, $HorsePhotosTable, HorsePhotoRow> {
  $$HorsePhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('horse_photos__horse_id__horses__id');

  $$HorsesTableProcessedTableManager get horseId {
    final $_column = $_itemColumn<String>('horse_id')!;

    final manager = $$HorsesTableTableManager(
      $_db,
      $_db.horses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_horseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HorsePhotosTableFilterComposer
    extends Composer<_$AppDatabase, $HorsePhotosTable> {
  $$HorsePhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  $$HorsesTableFilterComposer get horseId {
    final $$HorsesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableFilterComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorsePhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $HorsePhotosTable> {
  $$HorsePhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  $$HorsesTableOrderingComposer get horseId {
    final $$HorsesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableOrderingComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorsePhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $HorsePhotosTable> {
  $$HorsePhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  $$HorsesTableAnnotationComposer get horseId {
    final $$HorsesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableAnnotationComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorsePhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HorsePhotosTable,
          HorsePhotoRow,
          $$HorsePhotosTableFilterComposer,
          $$HorsePhotosTableOrderingComposer,
          $$HorsePhotosTableAnnotationComposer,
          $$HorsePhotosTableCreateCompanionBuilder,
          $$HorsePhotosTableUpdateCompanionBuilder,
          (HorsePhotoRow, $$HorsePhotosTableReferences),
          HorsePhotoRow,
          PrefetchHooks Function({bool horseId})
        > {
  $$HorsePhotosTableTableManager(_$AppDatabase db, $HorsePhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HorsePhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HorsePhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HorsePhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HorsePhotosCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                relativePath: relativePath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String horseId,
                required String relativePath,
                Value<int> rowid = const Value.absent(),
              }) => HorsePhotosCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                relativePath: relativePath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HorsePhotosTable, HorsePhotoRow>(table),
                  $$HorsePhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({horseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (horseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.horseId,
                        referencedTable: $$HorsePhotosTableReferences
                            ._horseIdTable(db),
                        referencedColumn: $$HorsePhotosTableReferences
                            ._horseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HorsePhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HorsePhotosTable,
      HorsePhotoRow,
      $$HorsePhotosTableFilterComposer,
      $$HorsePhotosTableOrderingComposer,
      $$HorsePhotosTableAnnotationComposer,
      $$HorsePhotosTableCreateCompanionBuilder,
      $$HorsePhotosTableUpdateCompanionBuilder,
      (HorsePhotoRow, $$HorsePhotosTableReferences),
      HorsePhotoRow,
      PrefetchHooks Function({bool horseId})
    >;
typedef $$HorseWeightsTableCreateCompanionBuilder =
    HorseWeightsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String horseId,
      required LocalDate date,
      required double weightKg,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$HorseWeightsTableUpdateCompanionBuilder =
    HorseWeightsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> horseId,
      Value<LocalDate> date,
      Value<double> weightKg,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$HorseWeightsTableReferences
    extends BaseReferences<_$AppDatabase, $HorseWeightsTable, HorseWeightRow> {
  $$HorseWeightsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('horse_weights__horse_id__horses__id');

  $$HorsesTableProcessedTableManager get horseId {
    final $_column = $_itemColumn<String>('horse_id')!;

    final manager = $$HorsesTableTableManager(
      $_db,
      $_db.horses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_horseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HorseWeightsTableFilterComposer
    extends Composer<_$AppDatabase, $HorseWeightsTable> {
  $$HorseWeightsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get date =>
      $composableBuilder(
        column: $table.date,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$HorsesTableFilterComposer get horseId {
    final $$HorsesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableFilterComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorseWeightsTableOrderingComposer
    extends Composer<_$AppDatabase, $HorseWeightsTable> {
  $$HorseWeightsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$HorsesTableOrderingComposer get horseId {
    final $$HorsesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableOrderingComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorseWeightsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HorseWeightsTable> {
  $$HorseWeightsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$HorsesTableAnnotationComposer get horseId {
    final $$HorsesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableAnnotationComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorseWeightsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HorseWeightsTable,
          HorseWeightRow,
          $$HorseWeightsTableFilterComposer,
          $$HorseWeightsTableOrderingComposer,
          $$HorseWeightsTableAnnotationComposer,
          $$HorseWeightsTableCreateCompanionBuilder,
          $$HorseWeightsTableUpdateCompanionBuilder,
          (HorseWeightRow, $$HorseWeightsTableReferences),
          HorseWeightRow,
          PrefetchHooks Function({bool horseId})
        > {
  $$HorseWeightsTableTableManager(_$AppDatabase db, $HorseWeightsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HorseWeightsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HorseWeightsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HorseWeightsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<LocalDate> date = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HorseWeightsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                date: date,
                weightKg: weightKg,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String horseId,
                required LocalDate date,
                required double weightKg,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HorseWeightsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                date: date,
                weightKg: weightKg,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HorseWeightsTable, HorseWeightRow>(table),
                  $$HorseWeightsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({horseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (horseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.horseId,
                        referencedTable: $$HorseWeightsTableReferences
                            ._horseIdTable(db),
                        referencedColumn: $$HorseWeightsTableReferences
                            ._horseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HorseWeightsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HorseWeightsTable,
      HorseWeightRow,
      $$HorseWeightsTableFilterComposer,
      $$HorseWeightsTableOrderingComposer,
      $$HorseWeightsTableAnnotationComposer,
      $$HorseWeightsTableCreateCompanionBuilder,
      $$HorseWeightsTableUpdateCompanionBuilder,
      (HorseWeightRow, $$HorseWeightsTableReferences),
      HorseWeightRow,
      PrefetchHooks Function({bool horseId})
    >;
typedef $$ContactsTableCreateCompanionBuilder = ContactsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String id,
  required String name,
  required String role,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$ContactsTableUpdateCompanionBuilder = ContactsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> id,
  Value<String> name,
  Value<String> role,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, ContactRow> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HorseContactsTable, List<HorseContactRow>>
  _horseContactsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.horseContacts,
    aliasName: 'contacts__id__horse_contacts__contact_id',
  );

  $$HorseContactsTableProcessedTableManager get horseContactsRefs {
    final manager = $$HorseContactsTableTableManager(
      $_db,
      $_db.horseContacts,
    ).filter((f) => f.contactId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_horseContactsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> horseContactsRefs(
    Expression<bool> Function($$HorseContactsTableFilterComposer f) f,
  ) {
    final $$HorseContactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horseContacts,
      getReferencedColumn: (t) => t.contactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorseContactsTableFilterComposer(
            $db: $db,
            $table: $db.horseContacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> horseContactsRefs<T extends Object>(
    Expression<T> Function($$HorseContactsTableAnnotationComposer a) f,
  ) {
    final $$HorseContactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horseContacts,
      getReferencedColumn: (t) => t.contactId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorseContactsTableAnnotationComposer(
            $db: $db,
            $table: $db.horseContacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          ContactRow,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (ContactRow, $$ContactsTableReferences),
          ContactRow,
          PrefetchHooks Function({bool horseContactsRefs})
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                role: role,
                phone: phone,
                email: email,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String name,
                required String role,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                role: role,
                phone: phone,
                email: email,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ContactsTable, ContactRow>(table),
                  $$ContactsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({horseContactsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (horseContactsRefs) db.horseContacts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (horseContactsRefs)
                    await $_getPrefetchedDataByColumns<
                      ContactRow,
                      $ContactsTable,
                      HorseContactRow,
                      $HorseContactsTable
                    >(
                      currentTable: table,
                      referencedTable: $$ContactsTableReferences
                          ._horseContactsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ContactsTableReferences(
                        db,
                        table,
                        p0,
                      ).horseContactsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'contact_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      ContactRow,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (ContactRow, $$ContactsTableReferences),
      ContactRow,
      PrefetchHooks Function({bool horseContactsRefs})
    >;
typedef $$HorseContactsTableCreateCompanionBuilder =
    HorseContactsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String horseId,
      required String contactId,
      Value<int> rowid,
    });
typedef $$HorseContactsTableUpdateCompanionBuilder =
    HorseContactsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> horseId,
      Value<String> contactId,
      Value<int> rowid,
    });

final class $$HorseContactsTableReferences
    extends
        BaseReferences<_$AppDatabase, $HorseContactsTable, HorseContactRow> {
  $$HorseContactsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('horse_contacts__horse_id__horses__id');

  $$HorsesTableProcessedTableManager get horseId {
    final $_column = $_itemColumn<String>('horse_id')!;

    final manager = $$HorsesTableTableManager(
      $_db,
      $_db.horses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_horseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias('horse_contacts__contact_id__contacts__id');

  $$ContactsTableProcessedTableManager get contactId {
    final $_column = $_itemColumn<String>('contact_id')!;

    final manager = $$ContactsTableTableManager(
      $_db,
      $_db.contacts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HorseContactsTableFilterComposer
    extends Composer<_$AppDatabase, $HorseContactsTable> {
  $$HorseContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HorsesTableFilterComposer get horseId {
    final $$HorsesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableFilterComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableFilterComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorseContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $HorseContactsTable> {
  $$HorseContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HorsesTableOrderingComposer get horseId {
    final $$HorsesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableOrderingComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableOrderingComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorseContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HorseContactsTable> {
  $$HorseContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$HorsesTableAnnotationComposer get horseId {
    final $$HorsesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableAnnotationComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contactId,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableAnnotationComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorseContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HorseContactsTable,
          HorseContactRow,
          $$HorseContactsTableFilterComposer,
          $$HorseContactsTableOrderingComposer,
          $$HorseContactsTableAnnotationComposer,
          $$HorseContactsTableCreateCompanionBuilder,
          $$HorseContactsTableUpdateCompanionBuilder,
          (HorseContactRow, $$HorseContactsTableReferences),
          HorseContactRow,
          PrefetchHooks Function({bool horseId, bool contactId})
        > {
  $$HorseContactsTableTableManager(_$AppDatabase db, $HorseContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HorseContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HorseContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HorseContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<String> contactId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HorseContactsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                horseId: horseId,
                contactId: contactId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String horseId,
                required String contactId,
                Value<int> rowid = const Value.absent(),
              }) => HorseContactsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                horseId: horseId,
                contactId: contactId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HorseContactsTable, HorseContactRow>(table),
                  $$HorseContactsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({horseId = false, contactId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (horseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.horseId,
                        referencedTable: $$HorseContactsTableReferences
                            ._horseIdTable(db),
                        referencedColumn: $$HorseContactsTableReferences
                            ._horseIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (contactId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.contactId,
                        referencedTable: $$HorseContactsTableReferences
                            ._contactIdTable(db),
                        referencedColumn: $$HorseContactsTableReferences
                            ._contactIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HorseContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HorseContactsTable,
      HorseContactRow,
      $$HorseContactsTableFilterComposer,
      $$HorseContactsTableOrderingComposer,
      $$HorseContactsTableAnnotationComposer,
      $$HorseContactsTableCreateCompanionBuilder,
      $$HorseContactsTableUpdateCompanionBuilder,
      (HorseContactRow, $$HorseContactsTableReferences),
      HorseContactRow,
      PrefetchHooks Function({bool horseId, bool contactId})
    >;
typedef $$CareEventTypesTableCreateCompanionBuilder =
    CareEventTypesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String name,
      required String kind,
      required int color,
      required String icon,
      Value<bool> builtin,
      Value<bool> archived,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$CareEventTypesTableUpdateCompanionBuilder =
    CareEventTypesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> name,
      Value<String> kind,
      Value<int> color,
      Value<String> icon,
      Value<bool> builtin,
      Value<bool> archived,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$CareEventTypesTableReferences
    extends BaseReferences<_$AppDatabase, $CareEventTypesTable, CareTypeRow> {
  $$CareEventTypesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $CareIntervalDefaultsTable,
    List<CareIntervalDefaultRow>
  >
  _careIntervalDefaultsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.careIntervalDefaults,
        aliasName: 'care_event_types__id__care_interval_defaults__type_id',
      );

  $$CareIntervalDefaultsTableProcessedTableManager
  get careIntervalDefaultsRefs {
    final manager = $$CareIntervalDefaultsTableTableManager(
      $_db,
      $_db.careIntervalDefaults,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _careIntervalDefaultsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareEventsTable, List<CareEventRow>>
  _careEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careEvents,
    aliasName: 'care_event_types__id__care_events__type_id',
  );

  $$CareEventsTableProcessedTableManager get careEventsRefs {
    final manager = $$CareEventsTableTableManager(
      $_db,
      $_db.careEvents,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CareEventTypesTableFilterComposer
    extends Composer<_$AppDatabase, $CareEventTypesTable> {
  $$CareEventTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get builtin => $composableBuilder(
    column: $table.builtin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> careIntervalDefaultsRefs(
    Expression<bool> Function($$CareIntervalDefaultsTableFilterComposer f) f,
  ) {
    final $$CareIntervalDefaultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careIntervalDefaults,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareIntervalDefaultsTableFilterComposer(
            $db: $db,
            $table: $db.careIntervalDefaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careEventsRefs(
    Expression<bool> Function($$CareEventsTableFilterComposer f) f,
  ) {
    final $$CareEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careEvents,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventsTableFilterComposer(
            $db: $db,
            $table: $db.careEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CareEventTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $CareEventTypesTable> {
  $$CareEventTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get builtin => $composableBuilder(
    column: $table.builtin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CareEventTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareEventTypesTable> {
  $$CareEventTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<bool> get builtin =>
      $composableBuilder(column: $table.builtin, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> careIntervalDefaultsRefs<T extends Object>(
    Expression<T> Function($$CareIntervalDefaultsTableAnnotationComposer a) f,
  ) {
    final $$CareIntervalDefaultsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.careIntervalDefaults,
          getReferencedColumn: (t) => t.typeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CareIntervalDefaultsTableAnnotationComposer(
                $db: $db,
                $table: $db.careIntervalDefaults,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> careEventsRefs<T extends Object>(
    Expression<T> Function($$CareEventsTableAnnotationComposer a) f,
  ) {
    final $$CareEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careEvents,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.careEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CareEventTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareEventTypesTable,
          CareTypeRow,
          $$CareEventTypesTableFilterComposer,
          $$CareEventTypesTableOrderingComposer,
          $$CareEventTypesTableAnnotationComposer,
          $$CareEventTypesTableCreateCompanionBuilder,
          $$CareEventTypesTableUpdateCompanionBuilder,
          (CareTypeRow, $$CareEventTypesTableReferences),
          CareTypeRow,
          PrefetchHooks Function({
            bool careIntervalDefaultsRefs,
            bool careEventsRefs,
          })
        > {
  $$CareEventTypesTableTableManager(
    _$AppDatabase db,
    $CareEventTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareEventTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareEventTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareEventTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<bool> builtin = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareEventTypesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                kind: kind,
                color: color,
                icon: icon,
                builtin: builtin,
                archived: archived,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String name,
                required String kind,
                required int color,
                required String icon,
                Value<bool> builtin = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareEventTypesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                kind: kind,
                color: color,
                icon: icon,
                builtin: builtin,
                archived: archived,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CareEventTypesTable, CareTypeRow>(table),
                  $$CareEventTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({careIntervalDefaultsRefs = false, careEventsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (careIntervalDefaultsRefs) db.careIntervalDefaults,
                    if (careEventsRefs) db.careEvents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (careIntervalDefaultsRefs)
                        await $_getPrefetchedDataByColumns<
                          CareTypeRow,
                          $CareEventTypesTable,
                          CareIntervalDefaultRow,
                          $CareIntervalDefaultsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CareEventTypesTableReferences
                              ._careIntervalDefaultsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CareEventTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).careIntervalDefaultsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'type_id',
                          typedResults: items,
                        ),
                      if (careEventsRefs)
                        await $_getPrefetchedDataByColumns<
                          CareTypeRow,
                          $CareEventTypesTable,
                          CareEventRow,
                          $CareEventsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CareEventTypesTableReferences
                              ._careEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CareEventTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).careEventsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'type_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CareEventTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareEventTypesTable,
      CareTypeRow,
      $$CareEventTypesTableFilterComposer,
      $$CareEventTypesTableOrderingComposer,
      $$CareEventTypesTableAnnotationComposer,
      $$CareEventTypesTableCreateCompanionBuilder,
      $$CareEventTypesTableUpdateCompanionBuilder,
      (CareTypeRow, $$CareEventTypesTableReferences),
      CareTypeRow,
      PrefetchHooks Function({
        bool careIntervalDefaultsRefs,
        bool careEventsRefs,
      })
    >;
typedef $$CareIntervalDefaultsTableCreateCompanionBuilder =
    CareIntervalDefaultsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String typeId,
      Value<String> variantKey,
      required int value,
      required String unit,
      Value<int> rowid,
    });
typedef $$CareIntervalDefaultsTableUpdateCompanionBuilder =
    CareIntervalDefaultsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> typeId,
      Value<String> variantKey,
      Value<int> value,
      Value<String> unit,
      Value<int> rowid,
    });

final class $$CareIntervalDefaultsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CareIntervalDefaultsTable,
          CareIntervalDefaultRow
        > {
  $$CareIntervalDefaultsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CareEventTypesTable _typeIdTable(_$AppDatabase db) => db
      .careEventTypes
      .createAlias('care_interval_defaults__type_id__care_event_types__id');

  $$CareEventTypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<String>('type_id')!;

    final manager = $$CareEventTypesTableTableManager(
      $_db,
      $_db.careEventTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CareIntervalDefaultsTableFilterComposer
    extends Composer<_$AppDatabase, $CareIntervalDefaultsTable> {
  $$CareIntervalDefaultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantKey => $composableBuilder(
    column: $table.variantKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  $$CareEventTypesTableFilterComposer get typeId {
    final $$CareEventTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.careEventTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventTypesTableFilterComposer(
            $db: $db,
            $table: $db.careEventTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareIntervalDefaultsTableOrderingComposer
    extends Composer<_$AppDatabase, $CareIntervalDefaultsTable> {
  $$CareIntervalDefaultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantKey => $composableBuilder(
    column: $table.variantKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  $$CareEventTypesTableOrderingComposer get typeId {
    final $$CareEventTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.careEventTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventTypesTableOrderingComposer(
            $db: $db,
            $table: $db.careEventTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareIntervalDefaultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareIntervalDefaultsTable> {
  $$CareIntervalDefaultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get variantKey => $composableBuilder(
    column: $table.variantKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  $$CareEventTypesTableAnnotationComposer get typeId {
    final $$CareEventTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.careEventTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.careEventTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareIntervalDefaultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareIntervalDefaultsTable,
          CareIntervalDefaultRow,
          $$CareIntervalDefaultsTableFilterComposer,
          $$CareIntervalDefaultsTableOrderingComposer,
          $$CareIntervalDefaultsTableAnnotationComposer,
          $$CareIntervalDefaultsTableCreateCompanionBuilder,
          $$CareIntervalDefaultsTableUpdateCompanionBuilder,
          (CareIntervalDefaultRow, $$CareIntervalDefaultsTableReferences),
          CareIntervalDefaultRow,
          PrefetchHooks Function({bool typeId})
        > {
  $$CareIntervalDefaultsTableTableManager(
    _$AppDatabase db,
    $CareIntervalDefaultsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareIntervalDefaultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareIntervalDefaultsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CareIntervalDefaultsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> typeId = const Value.absent(),
                Value<String> variantKey = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareIntervalDefaultsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                typeId: typeId,
                variantKey: variantKey,
                value: value,
                unit: unit,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String typeId,
                Value<String> variantKey = const Value.absent(),
                required int value,
                required String unit,
                Value<int> rowid = const Value.absent(),
              }) => CareIntervalDefaultsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                typeId: typeId,
                variantKey: variantKey,
                value: value,
                unit: unit,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $CareIntervalDefaultsTable,
                    CareIntervalDefaultRow
                  >(table),
                  $$CareIntervalDefaultsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (typeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.typeId,
                        referencedTable: $$CareIntervalDefaultsTableReferences
                            ._typeIdTable(db),
                        referencedColumn: $$CareIntervalDefaultsTableReferences
                            ._typeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CareIntervalDefaultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareIntervalDefaultsTable,
      CareIntervalDefaultRow,
      $$CareIntervalDefaultsTableFilterComposer,
      $$CareIntervalDefaultsTableOrderingComposer,
      $$CareIntervalDefaultsTableAnnotationComposer,
      $$CareIntervalDefaultsTableCreateCompanionBuilder,
      $$CareIntervalDefaultsTableUpdateCompanionBuilder,
      (CareIntervalDefaultRow, $$CareIntervalDefaultsTableReferences),
      CareIntervalDefaultRow,
      PrefetchHooks Function({bool typeId})
    >;
typedef $$CareEventsTableCreateCompanionBuilder = CareEventsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String id,
  required String horseId,
  required String typeId,
  required LocalDate date,
  Value<int?> timeMinutes,
  Value<bool> done,
  Value<String?> variantKey,
  Value<String?> title,
  Value<String?> person,
  Value<int?> costCents,
  Value<String?> notes,
  Value<String> fields,
  Value<int?> repeatValue,
  Value<String?> repeatUnit,
  Value<String?> parentEventId,
  Value<String?> seriesId,
  Value<int> rowid,
});
typedef $$CareEventsTableUpdateCompanionBuilder = CareEventsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> id,
  Value<String> horseId,
  Value<String> typeId,
  Value<LocalDate> date,
  Value<int?> timeMinutes,
  Value<bool> done,
  Value<String?> variantKey,
  Value<String?> title,
  Value<String?> person,
  Value<int?> costCents,
  Value<String?> notes,
  Value<String> fields,
  Value<int?> repeatValue,
  Value<String?> repeatUnit,
  Value<String?> parentEventId,
  Value<String?> seriesId,
  Value<int> rowid,
});

final class $$CareEventsTableReferences
    extends BaseReferences<_$AppDatabase, $CareEventsTable, CareEventRow> {
  $$CareEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('care_events__horse_id__horses__id');

  $$HorsesTableProcessedTableManager get horseId {
    final $_column = $_itemColumn<String>('horse_id')!;

    final manager = $$HorsesTableTableManager(
      $_db,
      $_db.horses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_horseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CareEventTypesTable _typeIdTable(_$AppDatabase db) => db
      .careEventTypes
      .createAlias('care_events__type_id__care_event_types__id');

  $$CareEventTypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<String>('type_id')!;

    final manager = $$CareEventTypesTableTableManager(
      $_db,
      $_db.careEventTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CareRemindersTable, List<CareReminderRow>>
  _careRemindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careReminders,
    aliasName: 'care_events__id__care_reminders__event_id',
  );

  $$CareRemindersTableProcessedTableManager get careRemindersRefs {
    final manager = $$CareRemindersTableTableManager(
      $_db,
      $_db.careReminders,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careRemindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CareEventsTableFilterComposer
    extends Composer<_$AppDatabase, $CareEventsTable> {
  $$CareEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get date =>
      $composableBuilder(
        column: $table.date,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantKey => $composableBuilder(
    column: $table.variantKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get person => $composableBuilder(
    column: $table.person,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costCents => $composableBuilder(
    column: $table.costCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fields => $composableBuilder(
    column: $table.fields,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatValue => $composableBuilder(
    column: $table.repeatValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repeatUnit => $composableBuilder(
    column: $table.repeatUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentEventId => $composableBuilder(
    column: $table.parentEventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seriesId => $composableBuilder(
    column: $table.seriesId,
    builder: (column) => ColumnFilters(column),
  );

  $$HorsesTableFilterComposer get horseId {
    final $$HorsesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableFilterComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CareEventTypesTableFilterComposer get typeId {
    final $$CareEventTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.careEventTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventTypesTableFilterComposer(
            $db: $db,
            $table: $db.careEventTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> careRemindersRefs(
    Expression<bool> Function($$CareRemindersTableFilterComposer f) f,
  ) {
    final $$CareRemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careReminders,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRemindersTableFilterComposer(
            $db: $db,
            $table: $db.careReminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CareEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $CareEventsTable> {
  $$CareEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantKey => $composableBuilder(
    column: $table.variantKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get person => $composableBuilder(
    column: $table.person,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costCents => $composableBuilder(
    column: $table.costCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fields => $composableBuilder(
    column: $table.fields,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatValue => $composableBuilder(
    column: $table.repeatValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeatUnit => $composableBuilder(
    column: $table.repeatUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentEventId => $composableBuilder(
    column: $table.parentEventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seriesId => $composableBuilder(
    column: $table.seriesId,
    builder: (column) => ColumnOrderings(column),
  );

  $$HorsesTableOrderingComposer get horseId {
    final $$HorsesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableOrderingComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CareEventTypesTableOrderingComposer get typeId {
    final $$CareEventTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.careEventTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventTypesTableOrderingComposer(
            $db: $db,
            $table: $db.careEventTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareEventsTable> {
  $$CareEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);

  GeneratedColumn<String> get variantKey => $composableBuilder(
    column: $table.variantKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get person =>
      $composableBuilder(column: $table.person, builder: (column) => column);

  GeneratedColumn<int> get costCents =>
      $composableBuilder(column: $table.costCents, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get fields =>
      $composableBuilder(column: $table.fields, builder: (column) => column);

  GeneratedColumn<int> get repeatValue => $composableBuilder(
    column: $table.repeatValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get repeatUnit => $composableBuilder(
    column: $table.repeatUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentEventId => $composableBuilder(
    column: $table.parentEventId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seriesId =>
      $composableBuilder(column: $table.seriesId, builder: (column) => column);

  $$HorsesTableAnnotationComposer get horseId {
    final $$HorsesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.horseId,
      referencedTable: $db.horses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorsesTableAnnotationComposer(
            $db: $db,
            $table: $db.horses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CareEventTypesTableAnnotationComposer get typeId {
    final $$CareEventTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.careEventTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.careEventTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> careRemindersRefs<T extends Object>(
    Expression<T> Function($$CareRemindersTableAnnotationComposer a) f,
  ) {
    final $$CareRemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careReminders,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.careReminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CareEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareEventsTable,
          CareEventRow,
          $$CareEventsTableFilterComposer,
          $$CareEventsTableOrderingComposer,
          $$CareEventsTableAnnotationComposer,
          $$CareEventsTableCreateCompanionBuilder,
          $$CareEventsTableUpdateCompanionBuilder,
          (CareEventRow, $$CareEventsTableReferences),
          CareEventRow,
          PrefetchHooks Function({
            bool horseId,
            bool typeId,
            bool careRemindersRefs,
          })
        > {
  $$CareEventsTableTableManager(_$AppDatabase db, $CareEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<String> typeId = const Value.absent(),
                Value<LocalDate> date = const Value.absent(),
                Value<int?> timeMinutes = const Value.absent(),
                Value<bool> done = const Value.absent(),
                Value<String?> variantKey = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> person = const Value.absent(),
                Value<int?> costCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> fields = const Value.absent(),
                Value<int?> repeatValue = const Value.absent(),
                Value<String?> repeatUnit = const Value.absent(),
                Value<String?> parentEventId = const Value.absent(),
                Value<String?> seriesId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareEventsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                typeId: typeId,
                date: date,
                timeMinutes: timeMinutes,
                done: done,
                variantKey: variantKey,
                title: title,
                person: person,
                costCents: costCents,
                notes: notes,
                fields: fields,
                repeatValue: repeatValue,
                repeatUnit: repeatUnit,
                parentEventId: parentEventId,
                seriesId: seriesId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String horseId,
                required String typeId,
                required LocalDate date,
                Value<int?> timeMinutes = const Value.absent(),
                Value<bool> done = const Value.absent(),
                Value<String?> variantKey = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> person = const Value.absent(),
                Value<int?> costCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> fields = const Value.absent(),
                Value<int?> repeatValue = const Value.absent(),
                Value<String?> repeatUnit = const Value.absent(),
                Value<String?> parentEventId = const Value.absent(),
                Value<String?> seriesId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareEventsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                typeId: typeId,
                date: date,
                timeMinutes: timeMinutes,
                done: done,
                variantKey: variantKey,
                title: title,
                person: person,
                costCents: costCents,
                notes: notes,
                fields: fields,
                repeatValue: repeatValue,
                repeatUnit: repeatUnit,
                parentEventId: parentEventId,
                seriesId: seriesId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CareEventsTable, CareEventRow>(table),
                  $$CareEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({horseId = false, typeId = false, careRemindersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (careRemindersRefs) db.careReminders,
                  ],
                  addJoins:
                      <
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
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (horseId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.horseId,
                            referencedTable: $$CareEventsTableReferences
                                ._horseIdTable(db),
                            referencedColumn: $$CareEventsTableReferences
                                ._horseIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (typeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.typeId,
                            referencedTable: $$CareEventsTableReferences
                                ._typeIdTable(db),
                            referencedColumn: $$CareEventsTableReferences
                                ._typeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (careRemindersRefs)
                        await $_getPrefetchedDataByColumns<
                          CareEventRow,
                          $CareEventsTable,
                          CareReminderRow,
                          $CareRemindersTable
                        >(
                          currentTable: table,
                          referencedTable: $$CareEventsTableReferences
                              ._careRemindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CareEventsTableReferences(
                                db,
                                table,
                                p0,
                              ).careRemindersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'event_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CareEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareEventsTable,
      CareEventRow,
      $$CareEventsTableFilterComposer,
      $$CareEventsTableOrderingComposer,
      $$CareEventsTableAnnotationComposer,
      $$CareEventsTableCreateCompanionBuilder,
      $$CareEventsTableUpdateCompanionBuilder,
      (CareEventRow, $$CareEventsTableReferences),
      CareEventRow,
      PrefetchHooks Function({
        bool horseId,
        bool typeId,
        bool careRemindersRefs,
      })
    >;
typedef $$CareRemindersTableCreateCompanionBuilder =
    CareRemindersCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String eventId,
      required int offsetDays,
      Value<int> rowid,
    });
typedef $$CareRemindersTableUpdateCompanionBuilder =
    CareRemindersCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> eventId,
      Value<int> offsetDays,
      Value<int> rowid,
    });

final class $$CareRemindersTableReferences
    extends
        BaseReferences<_$AppDatabase, $CareRemindersTable, CareReminderRow> {
  $$CareRemindersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CareEventsTable _eventIdTable(_$AppDatabase db) =>
      db.careEvents.createAlias('care_reminders__event_id__care_events__id');

  $$CareEventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$CareEventsTableTableManager(
      $_db,
      $_db.careEvents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CareRemindersTableFilterComposer
    extends Composer<_$AppDatabase, $CareRemindersTable> {
  $$CareRemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get offsetDays => $composableBuilder(
    column: $table.offsetDays,
    builder: (column) => ColumnFilters(column),
  );

  $$CareEventsTableFilterComposer get eventId {
    final $$CareEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.careEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventsTableFilterComposer(
            $db: $db,
            $table: $db.careEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $CareRemindersTable> {
  $$CareRemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get offsetDays => $composableBuilder(
    column: $table.offsetDays,
    builder: (column) => ColumnOrderings(column),
  );

  $$CareEventsTableOrderingComposer get eventId {
    final $$CareEventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.careEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventsTableOrderingComposer(
            $db: $db,
            $table: $db.careEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareRemindersTable> {
  $$CareRemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get offsetDays => $composableBuilder(
    column: $table.offsetDays,
    builder: (column) => column,
  );

  $$CareEventsTableAnnotationComposer get eventId {
    final $$CareEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.careEvents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.careEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareRemindersTable,
          CareReminderRow,
          $$CareRemindersTableFilterComposer,
          $$CareRemindersTableOrderingComposer,
          $$CareRemindersTableAnnotationComposer,
          $$CareRemindersTableCreateCompanionBuilder,
          $$CareRemindersTableUpdateCompanionBuilder,
          (CareReminderRow, $$CareRemindersTableReferences),
          CareReminderRow,
          PrefetchHooks Function({bool eventId})
        > {
  $$CareRemindersTableTableManager(_$AppDatabase db, $CareRemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareRemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareRemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareRemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<int> offsetDays = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareRemindersCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                eventId: eventId,
                offsetDays: offsetDays,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String eventId,
                required int offsetDays,
                Value<int> rowid = const Value.absent(),
              }) => CareRemindersCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                eventId: eventId,
                offsetDays: offsetDays,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CareRemindersTable, CareReminderRow>(table),
                  $$CareRemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eventId,
                        referencedTable: $$CareRemindersTableReferences
                            ._eventIdTable(db),
                        referencedColumn: $$CareRemindersTableReferences
                            ._eventIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CareRemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareRemindersTable,
      CareReminderRow,
      $$CareRemindersTableFilterComposer,
      $$CareRemindersTableOrderingComposer,
      $$CareRemindersTableAnnotationComposer,
      $$CareRemindersTableCreateCompanionBuilder,
      $$CareRemindersTableUpdateCompanionBuilder,
      (CareReminderRow, $$CareRemindersTableReferences),
      CareReminderRow,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$ShiftTemplatesTableCreateCompanionBuilder =
    ShiftTemplatesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String name,
      required String shortCode,
      required int color,
      Value<int?> startMinutes,
      Value<int?> endMinutes,
      required int stableMinutes,
      Value<String?> preferredTime,
      Value<bool> isNight,
      Value<bool> archived,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$ShiftTemplatesTableUpdateCompanionBuilder =
    ShiftTemplatesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> name,
      Value<String> shortCode,
      Value<int> color,
      Value<int?> startMinutes,
      Value<int?> endMinutes,
      Value<int> stableMinutes,
      Value<String?> preferredTime,
      Value<bool> isNight,
      Value<bool> archived,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$ShiftTemplatesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ShiftTemplatesTable, ShiftTemplateRow> {
  $$ShiftTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ShiftDaysTable, List<ShiftDayRow>>
  _shiftDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shiftDays,
    aliasName: 'shift_templates__id__shift_days__template_id',
  );

  $$ShiftDaysTableProcessedTableManager get shiftDaysRefs {
    final manager = $$ShiftDaysTableTableManager(
      $_db,
      $_db.shiftDays,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_shiftDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShiftTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortCode => $composableBuilder(
    column: $table.shortCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stableMinutes => $composableBuilder(
    column: $table.stableMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredTime => $composableBuilder(
    column: $table.preferredTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNight => $composableBuilder(
    column: $table.isNight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> shiftDaysRefs(
    Expression<bool> Function($$ShiftDaysTableFilterComposer f) f,
  ) {
    final $$ShiftDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shiftDays,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftDaysTableFilterComposer(
            $db: $db,
            $table: $db.shiftDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShiftTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortCode => $composableBuilder(
    column: $table.shortCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stableMinutes => $composableBuilder(
    column: $table.stableMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredTime => $composableBuilder(
    column: $table.preferredTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNight => $composableBuilder(
    column: $table.isNight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShiftTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get shortCode =>
      $composableBuilder(column: $table.shortCode, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stableMinutes => $composableBuilder(
    column: $table.stableMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredTime => $composableBuilder(
    column: $table.preferredTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isNight =>
      $composableBuilder(column: $table.isNight, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> shiftDaysRefs<T extends Object>(
    Expression<T> Function($$ShiftDaysTableAnnotationComposer a) f,
  ) {
    final $$ShiftDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shiftDays,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.shiftDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShiftTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftTemplatesTable,
          ShiftTemplateRow,
          $$ShiftTemplatesTableFilterComposer,
          $$ShiftTemplatesTableOrderingComposer,
          $$ShiftTemplatesTableAnnotationComposer,
          $$ShiftTemplatesTableCreateCompanionBuilder,
          $$ShiftTemplatesTableUpdateCompanionBuilder,
          (ShiftTemplateRow, $$ShiftTemplatesTableReferences),
          ShiftTemplateRow,
          PrefetchHooks Function({bool shiftDaysRefs})
        > {
  $$ShiftTemplatesTableTableManager(
    _$AppDatabase db,
    $ShiftTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> shortCode = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int?> startMinutes = const Value.absent(),
                Value<int?> endMinutes = const Value.absent(),
                Value<int> stableMinutes = const Value.absent(),
                Value<String?> preferredTime = const Value.absent(),
                Value<bool> isNight = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftTemplatesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                shortCode: shortCode,
                color: color,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
                stableMinutes: stableMinutes,
                preferredTime: preferredTime,
                isNight: isNight,
                archived: archived,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String name,
                required String shortCode,
                required int color,
                Value<int?> startMinutes = const Value.absent(),
                Value<int?> endMinutes = const Value.absent(),
                required int stableMinutes,
                Value<String?> preferredTime = const Value.absent(),
                Value<bool> isNight = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftTemplatesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                shortCode: shortCode,
                color: color,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
                stableMinutes: stableMinutes,
                preferredTime: preferredTime,
                isNight: isNight,
                archived: archived,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShiftTemplatesTable, ShiftTemplateRow>(table),
                  $$ShiftTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shiftDaysRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (shiftDaysRefs) db.shiftDays],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (shiftDaysRefs)
                    await $_getPrefetchedDataByColumns<
                      ShiftTemplateRow,
                      $ShiftTemplatesTable,
                      ShiftDayRow,
                      $ShiftDaysTable
                    >(
                      currentTable: table,
                      referencedTable: $$ShiftTemplatesTableReferences
                          ._shiftDaysRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ShiftTemplatesTableReferences(
                            db,
                            table,
                            p0,
                          ).shiftDaysRefs,
                      currentColumn: 'id',
                      referencedColumn: 'template_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ShiftTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftTemplatesTable,
      ShiftTemplateRow,
      $$ShiftTemplatesTableFilterComposer,
      $$ShiftTemplatesTableOrderingComposer,
      $$ShiftTemplatesTableAnnotationComposer,
      $$ShiftTemplatesTableCreateCompanionBuilder,
      $$ShiftTemplatesTableUpdateCompanionBuilder,
      (ShiftTemplateRow, $$ShiftTemplatesTableReferences),
      ShiftTemplateRow,
      PrefetchHooks Function({bool shiftDaysRefs})
    >;
typedef $$ShiftPatternsTableCreateCompanionBuilder =
    ShiftPatternsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String name,
      required String steps,
      required LocalDate startDate,
      required int weeks,
      Value<int> rowid,
    });
typedef $$ShiftPatternsTableUpdateCompanionBuilder =
    ShiftPatternsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> name,
      Value<String> steps,
      Value<LocalDate> startDate,
      Value<int> weeks,
      Value<int> rowid,
    });

final class $$ShiftPatternsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ShiftPatternsTable, ShiftPatternRow> {
  $$ShiftPatternsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ShiftDaysTable, List<ShiftDayRow>>
  _shiftDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shiftDays,
    aliasName: 'shift_patterns__id__shift_days__pattern_id',
  );

  $$ShiftDaysTableProcessedTableManager get shiftDaysRefs {
    final manager = $$ShiftDaysTableTableManager(
      $_db,
      $_db.shiftDays,
    ).filter((f) => f.patternId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_shiftDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShiftPatternsTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftPatternsTable> {
  $$ShiftPatternsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get startDate =>
      $composableBuilder(
        column: $table.startDate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> shiftDaysRefs(
    Expression<bool> Function($$ShiftDaysTableFilterComposer f) f,
  ) {
    final $$ShiftDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shiftDays,
      getReferencedColumn: (t) => t.patternId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftDaysTableFilterComposer(
            $db: $db,
            $table: $db.shiftDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShiftPatternsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftPatternsTable> {
  $$ShiftPatternsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShiftPatternsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftPatternsTable> {
  $$ShiftPatternsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get weeks =>
      $composableBuilder(column: $table.weeks, builder: (column) => column);

  Expression<T> shiftDaysRefs<T extends Object>(
    Expression<T> Function($$ShiftDaysTableAnnotationComposer a) f,
  ) {
    final $$ShiftDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shiftDays,
      getReferencedColumn: (t) => t.patternId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.shiftDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShiftPatternsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftPatternsTable,
          ShiftPatternRow,
          $$ShiftPatternsTableFilterComposer,
          $$ShiftPatternsTableOrderingComposer,
          $$ShiftPatternsTableAnnotationComposer,
          $$ShiftPatternsTableCreateCompanionBuilder,
          $$ShiftPatternsTableUpdateCompanionBuilder,
          (ShiftPatternRow, $$ShiftPatternsTableReferences),
          ShiftPatternRow,
          PrefetchHooks Function({bool shiftDaysRefs})
        > {
  $$ShiftPatternsTableTableManager(_$AppDatabase db, $ShiftPatternsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftPatternsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftPatternsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftPatternsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> steps = const Value.absent(),
                Value<LocalDate> startDate = const Value.absent(),
                Value<int> weeks = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftPatternsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                steps: steps,
                startDate: startDate,
                weeks: weeks,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String name,
                required String steps,
                required LocalDate startDate,
                required int weeks,
                Value<int> rowid = const Value.absent(),
              }) => ShiftPatternsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                steps: steps,
                startDate: startDate,
                weeks: weeks,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShiftPatternsTable, ShiftPatternRow>(table),
                  $$ShiftPatternsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shiftDaysRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (shiftDaysRefs) db.shiftDays],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (shiftDaysRefs)
                    await $_getPrefetchedDataByColumns<
                      ShiftPatternRow,
                      $ShiftPatternsTable,
                      ShiftDayRow,
                      $ShiftDaysTable
                    >(
                      currentTable: table,
                      referencedTable: $$ShiftPatternsTableReferences
                          ._shiftDaysRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ShiftPatternsTableReferences(
                            db,
                            table,
                            p0,
                          ).shiftDaysRefs,
                      currentColumn: 'id',
                      referencedColumn: 'pattern_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ShiftPatternsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftPatternsTable,
      ShiftPatternRow,
      $$ShiftPatternsTableFilterComposer,
      $$ShiftPatternsTableOrderingComposer,
      $$ShiftPatternsTableAnnotationComposer,
      $$ShiftPatternsTableCreateCompanionBuilder,
      $$ShiftPatternsTableUpdateCompanionBuilder,
      (ShiftPatternRow, $$ShiftPatternsTableReferences),
      ShiftPatternRow,
      PrefetchHooks Function({bool shiftDaysRefs})
    >;
typedef $$ShiftDaysTableCreateCompanionBuilder = ShiftDaysCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required LocalDate date,
  Value<String?> templateId,
  Value<int?> overrideMinutes,
  Value<bool> otherPersonCovers,
  Value<String?> note,
  Value<String> source,
  Value<String?> patternId,
  Value<int> rowid,
});
typedef $$ShiftDaysTableUpdateCompanionBuilder = ShiftDaysCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<LocalDate> date,
  Value<String?> templateId,
  Value<int?> overrideMinutes,
  Value<bool> otherPersonCovers,
  Value<String?> note,
  Value<String> source,
  Value<String?> patternId,
  Value<int> rowid,
});

final class $$ShiftDaysTableReferences
    extends BaseReferences<_$AppDatabase, $ShiftDaysTable, ShiftDayRow> {
  $$ShiftDaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShiftTemplatesTable _templateIdTable(_$AppDatabase db) => db
      .shiftTemplates
      .createAlias('shift_days__template_id__shift_templates__id');

  $$ShiftTemplatesTableProcessedTableManager? get templateId {
    final $_column = $_itemColumn<String>('template_id');
    if ($_column == null) return null;
    final manager = $$ShiftTemplatesTableTableManager(
      $_db,
      $_db.shiftTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ShiftPatternsTable _patternIdTable(_$AppDatabase db) => db
      .shiftPatterns
      .createAlias('shift_days__pattern_id__shift_patterns__id');

  $$ShiftPatternsTableProcessedTableManager? get patternId {
    final $_column = $_itemColumn<String>('pattern_id');
    if ($_column == null) return null;
    final manager = $$ShiftPatternsTableTableManager(
      $_db,
      $_db.shiftPatterns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patternIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShiftDaysTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftDaysTable> {
  $$ShiftDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get date =>
      $composableBuilder(
        column: $table.date,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get overrideMinutes => $composableBuilder(
    column: $table.overrideMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get otherPersonCovers => $composableBuilder(
    column: $table.otherPersonCovers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$ShiftTemplatesTableFilterComposer get templateId {
    final $$ShiftTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShiftPatternsTableFilterComposer get patternId {
    final $$ShiftPatternsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.shiftPatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftPatternsTableFilterComposer(
            $db: $db,
            $table: $db.shiftPatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShiftDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftDaysTable> {
  $$ShiftDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get overrideMinutes => $composableBuilder(
    column: $table.overrideMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get otherPersonCovers => $composableBuilder(
    column: $table.otherPersonCovers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShiftTemplatesTableOrderingComposer get templateId {
    final $$ShiftTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShiftPatternsTableOrderingComposer get patternId {
    final $$ShiftPatternsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.shiftPatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftPatternsTableOrderingComposer(
            $db: $db,
            $table: $db.shiftPatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShiftDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftDaysTable> {
  $$ShiftDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get overrideMinutes => $composableBuilder(
    column: $table.overrideMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get otherPersonCovers => $composableBuilder(
    column: $table.otherPersonCovers,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$ShiftTemplatesTableAnnotationComposer get templateId {
    final $$ShiftTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.shiftTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.shiftTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShiftPatternsTableAnnotationComposer get patternId {
    final $$ShiftPatternsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.shiftPatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShiftPatternsTableAnnotationComposer(
            $db: $db,
            $table: $db.shiftPatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShiftDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftDaysTable,
          ShiftDayRow,
          $$ShiftDaysTableFilterComposer,
          $$ShiftDaysTableOrderingComposer,
          $$ShiftDaysTableAnnotationComposer,
          $$ShiftDaysTableCreateCompanionBuilder,
          $$ShiftDaysTableUpdateCompanionBuilder,
          (ShiftDayRow, $$ShiftDaysTableReferences),
          ShiftDayRow,
          PrefetchHooks Function({bool templateId, bool patternId})
        > {
  $$ShiftDaysTableTableManager(_$AppDatabase db, $ShiftDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<LocalDate> date = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<int?> overrideMinutes = const Value.absent(),
                Value<bool> otherPersonCovers = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> patternId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftDaysCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
                templateId: templateId,
                overrideMinutes: overrideMinutes,
                otherPersonCovers: otherPersonCovers,
                note: note,
                source: source,
                patternId: patternId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required LocalDate date,
                Value<String?> templateId = const Value.absent(),
                Value<int?> overrideMinutes = const Value.absent(),
                Value<bool> otherPersonCovers = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> patternId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftDaysCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                date: date,
                templateId: templateId,
                overrideMinutes: overrideMinutes,
                otherPersonCovers: otherPersonCovers,
                note: note,
                source: source,
                patternId: patternId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShiftDaysTable, ShiftDayRow>(table),
                  $$ShiftDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({templateId = false, patternId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (templateId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.templateId,
                        referencedTable: $$ShiftDaysTableReferences
                            ._templateIdTable(db),
                        referencedColumn: $$ShiftDaysTableReferences
                            ._templateIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (patternId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.patternId,
                        referencedTable: $$ShiftDaysTableReferences
                            ._patternIdTable(db),
                        referencedColumn: $$ShiftDaysTableReferences
                            ._patternIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShiftDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftDaysTable,
      ShiftDayRow,
      $$ShiftDaysTableFilterComposer,
      $$ShiftDaysTableOrderingComposer,
      $$ShiftDaysTableAnnotationComposer,
      $$ShiftDaysTableCreateCompanionBuilder,
      $$ShiftDaysTableUpdateCompanionBuilder,
      (ShiftDayRow, $$ShiftDaysTableReferences),
      ShiftDayRow,
      PrefetchHooks Function({bool templateId, bool patternId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$HorsesTableTableManager get horses =>
      $$HorsesTableTableManager(_db, _db.horses);
  $$HorsePhotosTableTableManager get horsePhotos =>
      $$HorsePhotosTableTableManager(_db, _db.horsePhotos);
  $$HorseWeightsTableTableManager get horseWeights =>
      $$HorseWeightsTableTableManager(_db, _db.horseWeights);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$HorseContactsTableTableManager get horseContacts =>
      $$HorseContactsTableTableManager(_db, _db.horseContacts);
  $$CareEventTypesTableTableManager get careEventTypes =>
      $$CareEventTypesTableTableManager(_db, _db.careEventTypes);
  $$CareIntervalDefaultsTableTableManager get careIntervalDefaults =>
      $$CareIntervalDefaultsTableTableManager(_db, _db.careIntervalDefaults);
  $$CareEventsTableTableManager get careEvents =>
      $$CareEventsTableTableManager(_db, _db.careEvents);
  $$CareRemindersTableTableManager get careReminders =>
      $$CareRemindersTableTableManager(_db, _db.careReminders);
  $$ShiftTemplatesTableTableManager get shiftTemplates =>
      $$ShiftTemplatesTableTableManager(_db, _db.shiftTemplates);
  $$ShiftPatternsTableTableManager get shiftPatterns =>
      $$ShiftPatternsTableTableManager(_db, _db.shiftPatterns);
  $$ShiftDaysTableTableManager get shiftDays =>
      $$ShiftDaysTableTableManager(_db, _db.shiftDays);
}
