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

class $TrainingPlansTable extends TrainingPlans
    with TableInfo<$TrainingPlansTable, TrainingPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paramsMeta = const VerificationMeta('params');
  @override
  late final GeneratedColumn<String> params = GeneratedColumn<String>(
    'params',
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
      ).withConverter<LocalDate>($TrainingPlansTable.$converterstartDate);
  static const VerificationMeta _weeksMeta = const VerificationMeta('weeks');
  @override
  late final GeneratedColumn<int> weeks = GeneratedColumn<int>(
    'weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _distributedAtMeta = const VerificationMeta(
    'distributedAt',
  );
  @override
  late final GeneratedColumn<DateTime> distributedAt =
      GeneratedColumn<DateTime>(
        'distributed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    horseId,
    goal,
    params,
    startDate,
    weeks,
    status,
    distributedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrainingPlanRow> instance, {
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
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('params')) {
      context.handle(
        _paramsMeta,
        params.isAcceptableOrUnknown(data['params']!, _paramsMeta),
      );
    } else if (isInserting) {
      context.missing(_paramsMeta);
    }
    if (data.containsKey('weeks')) {
      context.handle(
        _weeksMeta,
        weeks.isAcceptableOrUnknown(data['weeks']!, _weeksMeta),
      );
    } else if (isInserting) {
      context.missing(_weeksMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('distributed_at')) {
      context.handle(
        _distributedAtMeta,
        distributedAt.isAcceptableOrUnknown(
          data['distributed_at']!,
          _distributedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingPlanRow(
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
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      )!,
      params: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}params'],
      )!,
      startDate: $TrainingPlansTable.$converterstartDate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}start_date'],
        )!,
      ),
      weeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weeks'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      distributedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}distributed_at'],
      ),
    );
  }

  @override
  $TrainingPlansTable createAlias(String alias) {
    return $TrainingPlansTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterstartDate =
      const LocalDateConverter();
}

class TrainingPlanRow extends DataClass implements Insertable<TrainingPlanRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String horseId;

  /// Siehe `TrainingGoal.key` (zusätzlich in `params`, für Abfragen).
  final String goal;

  /// `TrainingParams.toJson()`.
  final String params;
  final LocalDate startDate;
  final int weeks;

  /// `active` | `archived`
  final String status;
  final DateTime? distributedAt;
  const TrainingPlanRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.horseId,
    required this.goal,
    required this.params,
    required this.startDate,
    required this.weeks,
    required this.status,
    this.distributedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['horse_id'] = Variable<String>(horseId);
    map['goal'] = Variable<String>(goal);
    map['params'] = Variable<String>(params);
    {
      map['start_date'] = Variable<String>(
        $TrainingPlansTable.$converterstartDate.toSql(startDate),
      );
    }
    map['weeks'] = Variable<int>(weeks);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || distributedAt != null) {
      map['distributed_at'] = Variable<DateTime>(distributedAt);
    }
    return map;
  }

  TrainingPlansCompanion toCompanion(bool nullToAbsent) {
    return TrainingPlansCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      horseId: Value(horseId),
      goal: Value(goal),
      params: Value(params),
      startDate: Value(startDate),
      weeks: Value(weeks),
      status: Value(status),
      distributedAt: distributedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(distributedAt),
    );
  }

  factory TrainingPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingPlanRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      horseId: serializer.fromJson<String>(json['horseId']),
      goal: serializer.fromJson<String>(json['goal']),
      params: serializer.fromJson<String>(json['params']),
      startDate: serializer.fromJson<LocalDate>(json['startDate']),
      weeks: serializer.fromJson<int>(json['weeks']),
      status: serializer.fromJson<String>(json['status']),
      distributedAt: serializer.fromJson<DateTime?>(json['distributedAt']),
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
      'goal': serializer.toJson<String>(goal),
      'params': serializer.toJson<String>(params),
      'startDate': serializer.toJson<LocalDate>(startDate),
      'weeks': serializer.toJson<int>(weeks),
      'status': serializer.toJson<String>(status),
      'distributedAt': serializer.toJson<DateTime?>(distributedAt),
    };
  }

  TrainingPlanRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? horseId,
    String? goal,
    String? params,
    LocalDate? startDate,
    int? weeks,
    String? status,
    Value<DateTime?> distributedAt = const Value.absent(),
  }) => TrainingPlanRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    horseId: horseId ?? this.horseId,
    goal: goal ?? this.goal,
    params: params ?? this.params,
    startDate: startDate ?? this.startDate,
    weeks: weeks ?? this.weeks,
    status: status ?? this.status,
    distributedAt: distributedAt.present
        ? distributedAt.value
        : this.distributedAt,
  );
  TrainingPlanRow copyWithCompanion(TrainingPlansCompanion data) {
    return TrainingPlanRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      goal: data.goal.present ? data.goal.value : this.goal,
      params: data.params.present ? data.params.value : this.params,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      weeks: data.weeks.present ? data.weeks.value : this.weeks,
      status: data.status.present ? data.status.value : this.status,
      distributedAt: data.distributedAt.present
          ? data.distributedAt.value
          : this.distributedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingPlanRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('goal: $goal, ')
          ..write('params: $params, ')
          ..write('startDate: $startDate, ')
          ..write('weeks: $weeks, ')
          ..write('status: $status, ')
          ..write('distributedAt: $distributedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    horseId,
    goal,
    params,
    startDate,
    weeks,
    status,
    distributedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingPlanRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.horseId == this.horseId &&
          other.goal == this.goal &&
          other.params == this.params &&
          other.startDate == this.startDate &&
          other.weeks == this.weeks &&
          other.status == this.status &&
          other.distributedAt == this.distributedAt);
}

class TrainingPlansCompanion extends UpdateCompanion<TrainingPlanRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> horseId;
  final Value<String> goal;
  final Value<String> params;
  final Value<LocalDate> startDate;
  final Value<int> weeks;
  final Value<String> status;
  final Value<DateTime?> distributedAt;
  final Value<int> rowid;
  const TrainingPlansCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.horseId = const Value.absent(),
    this.goal = const Value.absent(),
    this.params = const Value.absent(),
    this.startDate = const Value.absent(),
    this.weeks = const Value.absent(),
    this.status = const Value.absent(),
    this.distributedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingPlansCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String horseId,
    required String goal,
    required String params,
    required LocalDate startDate,
    required int weeks,
    this.status = const Value.absent(),
    this.distributedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       horseId = Value(horseId),
       goal = Value(goal),
       params = Value(params),
       startDate = Value(startDate),
       weeks = Value(weeks);
  static Insertable<TrainingPlanRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? horseId,
    Expression<String>? goal,
    Expression<String>? params,
    Expression<String>? startDate,
    Expression<int>? weeks,
    Expression<String>? status,
    Expression<DateTime>? distributedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (horseId != null) 'horse_id': horseId,
      if (goal != null) 'goal': goal,
      if (params != null) 'params': params,
      if (startDate != null) 'start_date': startDate,
      if (weeks != null) 'weeks': weeks,
      if (status != null) 'status': status,
      if (distributedAt != null) 'distributed_at': distributedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingPlansCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? horseId,
    Value<String>? goal,
    Value<String>? params,
    Value<LocalDate>? startDate,
    Value<int>? weeks,
    Value<String>? status,
    Value<DateTime?>? distributedAt,
    Value<int>? rowid,
  }) {
    return TrainingPlansCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      horseId: horseId ?? this.horseId,
      goal: goal ?? this.goal,
      params: params ?? this.params,
      startDate: startDate ?? this.startDate,
      weeks: weeks ?? this.weeks,
      status: status ?? this.status,
      distributedAt: distributedAt ?? this.distributedAt,
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
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (params.present) {
      map['params'] = Variable<String>(params.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(
        $TrainingPlansTable.$converterstartDate.toSql(startDate.value),
      );
    }
    if (weeks.present) {
      map['weeks'] = Variable<int>(weeks.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (distributedAt.present) {
      map['distributed_at'] = Variable<DateTime>(distributedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingPlansCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('goal: $goal, ')
          ..write('params: $params, ')
          ..write('startDate: $startDate, ')
          ..write('weeks: $weeks, ')
          ..write('status: $status, ')
          ..write('distributedAt: $distributedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrainingSessionsTable extends TrainingSessions
    with TableInfo<$TrainingSessionsTable, TrainingSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingSessionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES training_plans (id) ON DELETE SET NULL',
    ),
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
      ).withConverter<LocalDate>($TrainingSessionsTable.$converterdate);
  static const VerificationMeta _templateKeyMeta = const VerificationMeta(
    'templateKey',
  );
  @override
  late final GeneratedColumn<String> templateKey = GeneratedColumn<String>(
    'template_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
    'form',
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('planned'),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
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
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
    'pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
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
    planId,
    horseId,
    date,
    templateKey,
    form,
    title,
    level,
    durationMinutes,
    content,
    status,
    rating,
    notes,
    pinned,
    reason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrainingSessionRow> instance, {
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
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
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
    if (data.containsKey('template_key')) {
      context.handle(
        _templateKeyMeta,
        templateKey.isAcceptableOrUnknown(
          data['template_key']!,
          _templateKeyMeta,
        ),
      );
    }
    if (data.containsKey('form')) {
      context.handle(
        _formMeta,
        form.isAcceptableOrUnknown(data['form']!, _formMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('pinned')) {
      context.handle(
        _pinnedMeta,
        pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingSessionRow(
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
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      ),
      horseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}horse_id'],
      )!,
      date: $TrainingSessionsTable.$converterdate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}date'],
        )!,
      ),
      templateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_key'],
      ),
      form: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      pinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pinned'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
    );
  }

  @override
  $TrainingSessionsTable createAlias(String alias) {
    return $TrainingSessionsTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterdate =
      const LocalDateConverter();
}

class TrainingSessionRow extends DataClass
    implements Insertable<TrainingSessionRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String? planId;
  final String horseId;
  final LocalDate date;

  /// Vorlage (`units[].key`), optional.
  final String? templateKey;

  /// Trainingsform (`forms[].key`), optional.
  final String? form;
  final String title;
  final int level;
  final int durationMinutes;

  /// `SessionContent.toJson()`.
  final String content;

  /// Siehe `SessionStatus.key`.
  final String status;
  final int? rating;
  final String? notes;
  final bool pinned;

  /// `SessionReason.toJson()`, optional.
  final String? reason;
  const TrainingSessionRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.planId,
    required this.horseId,
    required this.date,
    this.templateKey,
    this.form,
    required this.title,
    required this.level,
    required this.durationMinutes,
    required this.content,
    required this.status,
    this.rating,
    this.notes,
    required this.pinned,
    this.reason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || planId != null) {
      map['plan_id'] = Variable<String>(planId);
    }
    map['horse_id'] = Variable<String>(horseId);
    {
      map['date'] = Variable<String>(
        $TrainingSessionsTable.$converterdate.toSql(date),
      );
    }
    if (!nullToAbsent || templateKey != null) {
      map['template_key'] = Variable<String>(templateKey);
    }
    if (!nullToAbsent || form != null) {
      map['form'] = Variable<String>(form);
    }
    map['title'] = Variable<String>(title);
    map['level'] = Variable<int>(level);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['content'] = Variable<String>(content);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['pinned'] = Variable<bool>(pinned);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    return map;
  }

  TrainingSessionsCompanion toCompanion(bool nullToAbsent) {
    return TrainingSessionsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      planId: planId == null && nullToAbsent
          ? const Value.absent()
          : Value(planId),
      horseId: Value(horseId),
      date: Value(date),
      templateKey: templateKey == null && nullToAbsent
          ? const Value.absent()
          : Value(templateKey),
      form: form == null && nullToAbsent ? const Value.absent() : Value(form),
      title: Value(title),
      level: Value(level),
      durationMinutes: Value(durationMinutes),
      content: Value(content),
      status: Value(status),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      pinned: Value(pinned),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
    );
  }

  factory TrainingSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingSessionRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String?>(json['planId']),
      horseId: serializer.fromJson<String>(json['horseId']),
      date: serializer.fromJson<LocalDate>(json['date']),
      templateKey: serializer.fromJson<String?>(json['templateKey']),
      form: serializer.fromJson<String?>(json['form']),
      title: serializer.fromJson<String>(json['title']),
      level: serializer.fromJson<int>(json['level']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      content: serializer.fromJson<String>(json['content']),
      status: serializer.fromJson<String>(json['status']),
      rating: serializer.fromJson<int?>(json['rating']),
      notes: serializer.fromJson<String?>(json['notes']),
      pinned: serializer.fromJson<bool>(json['pinned']),
      reason: serializer.fromJson<String?>(json['reason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String?>(planId),
      'horseId': serializer.toJson<String>(horseId),
      'date': serializer.toJson<LocalDate>(date),
      'templateKey': serializer.toJson<String?>(templateKey),
      'form': serializer.toJson<String?>(form),
      'title': serializer.toJson<String>(title),
      'level': serializer.toJson<int>(level),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'content': serializer.toJson<String>(content),
      'status': serializer.toJson<String>(status),
      'rating': serializer.toJson<int?>(rating),
      'notes': serializer.toJson<String?>(notes),
      'pinned': serializer.toJson<bool>(pinned),
      'reason': serializer.toJson<String?>(reason),
    };
  }

  TrainingSessionRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    Value<String?> planId = const Value.absent(),
    String? horseId,
    LocalDate? date,
    Value<String?> templateKey = const Value.absent(),
    Value<String?> form = const Value.absent(),
    String? title,
    int? level,
    int? durationMinutes,
    String? content,
    String? status,
    Value<int?> rating = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? pinned,
    Value<String?> reason = const Value.absent(),
  }) => TrainingSessionRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    planId: planId.present ? planId.value : this.planId,
    horseId: horseId ?? this.horseId,
    date: date ?? this.date,
    templateKey: templateKey.present ? templateKey.value : this.templateKey,
    form: form.present ? form.value : this.form,
    title: title ?? this.title,
    level: level ?? this.level,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    content: content ?? this.content,
    status: status ?? this.status,
    rating: rating.present ? rating.value : this.rating,
    notes: notes.present ? notes.value : this.notes,
    pinned: pinned ?? this.pinned,
    reason: reason.present ? reason.value : this.reason,
  );
  TrainingSessionRow copyWithCompanion(TrainingSessionsCompanion data) {
    return TrainingSessionRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      date: data.date.present ? data.date.value : this.date,
      templateKey: data.templateKey.present
          ? data.templateKey.value
          : this.templateKey,
      form: data.form.present ? data.form.value : this.form,
      title: data.title.present ? data.title.value : this.title,
      level: data.level.present ? data.level.value : this.level,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      content: data.content.present ? data.content.value : this.content,
      status: data.status.present ? data.status.value : this.status,
      rating: data.rating.present ? data.rating.value : this.rating,
      notes: data.notes.present ? data.notes.value : this.notes,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
      reason: data.reason.present ? data.reason.value : this.reason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingSessionRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('horseId: $horseId, ')
          ..write('date: $date, ')
          ..write('templateKey: $templateKey, ')
          ..write('form: $form, ')
          ..write('title: $title, ')
          ..write('level: $level, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('content: $content, ')
          ..write('status: $status, ')
          ..write('rating: $rating, ')
          ..write('notes: $notes, ')
          ..write('pinned: $pinned, ')
          ..write('reason: $reason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    planId,
    horseId,
    date,
    templateKey,
    form,
    title,
    level,
    durationMinutes,
    content,
    status,
    rating,
    notes,
    pinned,
    reason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingSessionRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.horseId == this.horseId &&
          other.date == this.date &&
          other.templateKey == this.templateKey &&
          other.form == this.form &&
          other.title == this.title &&
          other.level == this.level &&
          other.durationMinutes == this.durationMinutes &&
          other.content == this.content &&
          other.status == this.status &&
          other.rating == this.rating &&
          other.notes == this.notes &&
          other.pinned == this.pinned &&
          other.reason == this.reason);
}

class TrainingSessionsCompanion extends UpdateCompanion<TrainingSessionRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String?> planId;
  final Value<String> horseId;
  final Value<LocalDate> date;
  final Value<String?> templateKey;
  final Value<String?> form;
  final Value<String> title;
  final Value<int> level;
  final Value<int> durationMinutes;
  final Value<String> content;
  final Value<String> status;
  final Value<int?> rating;
  final Value<String?> notes;
  final Value<bool> pinned;
  final Value<String?> reason;
  final Value<int> rowid;
  const TrainingSessionsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.horseId = const Value.absent(),
    this.date = const Value.absent(),
    this.templateKey = const Value.absent(),
    this.form = const Value.absent(),
    this.title = const Value.absent(),
    this.level = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.content = const Value.absent(),
    this.status = const Value.absent(),
    this.rating = const Value.absent(),
    this.notes = const Value.absent(),
    this.pinned = const Value.absent(),
    this.reason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingSessionsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    this.planId = const Value.absent(),
    required String horseId,
    required LocalDate date,
    this.templateKey = const Value.absent(),
    this.form = const Value.absent(),
    required String title,
    required int level,
    required int durationMinutes,
    this.content = const Value.absent(),
    this.status = const Value.absent(),
    this.rating = const Value.absent(),
    this.notes = const Value.absent(),
    this.pinned = const Value.absent(),
    this.reason = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       horseId = Value(horseId),
       date = Value(date),
       title = Value(title),
       level = Value(level),
       durationMinutes = Value(durationMinutes);
  static Insertable<TrainingSessionRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? horseId,
    Expression<String>? date,
    Expression<String>? templateKey,
    Expression<String>? form,
    Expression<String>? title,
    Expression<int>? level,
    Expression<int>? durationMinutes,
    Expression<String>? content,
    Expression<String>? status,
    Expression<int>? rating,
    Expression<String>? notes,
    Expression<bool>? pinned,
    Expression<String>? reason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (horseId != null) 'horse_id': horseId,
      if (date != null) 'date': date,
      if (templateKey != null) 'template_key': templateKey,
      if (form != null) 'form': form,
      if (title != null) 'title': title,
      if (level != null) 'level': level,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (content != null) 'content': content,
      if (status != null) 'status': status,
      if (rating != null) 'rating': rating,
      if (notes != null) 'notes': notes,
      if (pinned != null) 'pinned': pinned,
      if (reason != null) 'reason': reason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingSessionsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String?>? planId,
    Value<String>? horseId,
    Value<LocalDate>? date,
    Value<String?>? templateKey,
    Value<String?>? form,
    Value<String>? title,
    Value<int>? level,
    Value<int>? durationMinutes,
    Value<String>? content,
    Value<String>? status,
    Value<int?>? rating,
    Value<String?>? notes,
    Value<bool>? pinned,
    Value<String?>? reason,
    Value<int>? rowid,
  }) {
    return TrainingSessionsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      planId: planId ?? this.planId,
      horseId: horseId ?? this.horseId,
      date: date ?? this.date,
      templateKey: templateKey ?? this.templateKey,
      form: form ?? this.form,
      title: title ?? this.title,
      level: level ?? this.level,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      content: content ?? this.content,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      notes: notes ?? this.notes,
      pinned: pinned ?? this.pinned,
      reason: reason ?? this.reason,
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
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (horseId.present) {
      map['horse_id'] = Variable<String>(horseId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(
        $TrainingSessionsTable.$converterdate.toSql(date.value),
      );
    }
    if (templateKey.present) {
      map['template_key'] = Variable<String>(templateKey.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingSessionsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('horseId: $horseId, ')
          ..write('date: $date, ')
          ..write('templateKey: $templateKey, ')
          ..write('form: $form, ')
          ..write('title: $title, ')
          ..write('level: $level, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('content: $content, ')
          ..write('status: $status, ')
          ..write('rating: $rating, ')
          ..write('notes: $notes, ')
          ..write('pinned: $pinned, ')
          ..write('reason: $reason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeedItemsTable extends FeedItems
    with TableInfo<$FeedItemsTable, FeedItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<double> stock = GeneratedColumn<double>(
    'stock',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lowStockThresholdMeta = const VerificationMeta(
    'lowStockThreshold',
  );
  @override
  late final GeneratedColumn<double> lowStockThreshold =
      GeneratedColumn<double>(
        'low_stock_threshold',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    id,
    name,
    category,
    unit,
    notes,
    stock,
    lowStockThreshold,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedItemRow> instance, {
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
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('stock')) {
      context.handle(
        _stockMeta,
        stock.isAcceptableOrUnknown(data['stock']!, _stockMeta),
      );
    }
    if (data.containsKey('low_stock_threshold')) {
      context.handle(
        _lowStockThresholdMeta,
        lowStockThreshold.isAcceptableOrUnknown(
          data['low_stock_threshold']!,
          _lowStockThresholdMeta,
        ),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedItemRow(
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
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      stock: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock'],
      ),
      lowStockThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}low_stock_threshold'],
      ),
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $FeedItemsTable createAlias(String alias) {
    return $FeedItemsTable(attachedDatabase, alias);
  }
}

class FeedItemRow extends DataClass implements Insertable<FeedItemRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String name;

  /// Siehe `FeedCategory.key`.
  final String category;

  /// Siehe `FeedUnit.key`.
  final String unit;
  final String? notes;
  final double? stock;
  final double? lowStockThreshold;
  final bool archived;
  const FeedItemRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    this.notes,
    this.stock,
    this.lowStockThreshold,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || stock != null) {
      map['stock'] = Variable<double>(stock);
    }
    if (!nullToAbsent || lowStockThreshold != null) {
      map['low_stock_threshold'] = Variable<double>(lowStockThreshold);
    }
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  FeedItemsCompanion toCompanion(bool nullToAbsent) {
    return FeedItemsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      name: Value(name),
      category: Value(category),
      unit: Value(unit),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      stock: stock == null && nullToAbsent
          ? const Value.absent()
          : Value(stock),
      lowStockThreshold: lowStockThreshold == null && nullToAbsent
          ? const Value.absent()
          : Value(lowStockThreshold),
      archived: Value(archived),
    );
  }

  factory FeedItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedItemRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      unit: serializer.fromJson<String>(json['unit']),
      notes: serializer.fromJson<String?>(json['notes']),
      stock: serializer.fromJson<double?>(json['stock']),
      lowStockThreshold: serializer.fromJson<double?>(
        json['lowStockThreshold'],
      ),
      archived: serializer.fromJson<bool>(json['archived']),
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
      'category': serializer.toJson<String>(category),
      'unit': serializer.toJson<String>(unit),
      'notes': serializer.toJson<String?>(notes),
      'stock': serializer.toJson<double?>(stock),
      'lowStockThreshold': serializer.toJson<double?>(lowStockThreshold),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  FeedItemRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? name,
    String? category,
    String? unit,
    Value<String?> notes = const Value.absent(),
    Value<double?> stock = const Value.absent(),
    Value<double?> lowStockThreshold = const Value.absent(),
    bool? archived,
  }) => FeedItemRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    unit: unit ?? this.unit,
    notes: notes.present ? notes.value : this.notes,
    stock: stock.present ? stock.value : this.stock,
    lowStockThreshold: lowStockThreshold.present
        ? lowStockThreshold.value
        : this.lowStockThreshold,
    archived: archived ?? this.archived,
  );
  FeedItemRow copyWithCompanion(FeedItemsCompanion data) {
    return FeedItemRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      unit: data.unit.present ? data.unit.value : this.unit,
      notes: data.notes.present ? data.notes.value : this.notes,
      stock: data.stock.present ? data.stock.value : this.stock,
      lowStockThreshold: data.lowStockThreshold.present
          ? data.lowStockThreshold.value
          : this.lowStockThreshold,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedItemRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('notes: $notes, ')
          ..write('stock: $stock, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    name,
    category,
    unit,
    notes,
    stock,
    lowStockThreshold,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedItemRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.unit == this.unit &&
          other.notes == this.notes &&
          other.stock == this.stock &&
          other.lowStockThreshold == this.lowStockThreshold &&
          other.archived == this.archived);
}

class FeedItemsCompanion extends UpdateCompanion<FeedItemRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> unit;
  final Value<String?> notes;
  final Value<double?> stock;
  final Value<double?> lowStockThreshold;
  final Value<bool> archived;
  final Value<int> rowid;
  const FeedItemsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.notes = const Value.absent(),
    this.stock = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedItemsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String name,
    required String category,
    required String unit,
    this.notes = const Value.absent(),
    this.stock = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       unit = Value(unit);
  static Insertable<FeedItemRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? unit,
    Expression<String>? notes,
    Expression<double>? stock,
    Expression<double>? lowStockThreshold,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (unit != null) 'unit': unit,
      if (notes != null) 'notes': notes,
      if (stock != null) 'stock': stock,
      if (lowStockThreshold != null) 'low_stock_threshold': lowStockThreshold,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedItemsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String>? unit,
    Value<String?>? notes,
    Value<double?>? stock,
    Value<double?>? lowStockThreshold,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return FeedItemsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
      stock: stock ?? this.stock,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      archived: archived ?? this.archived,
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
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (stock.present) {
      map['stock'] = Variable<double>(stock.value);
    }
    if (lowStockThreshold.present) {
      map['low_stock_threshold'] = Variable<double>(lowStockThreshold.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedItemsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('notes: $notes, ')
          ..write('stock: $stock, ')
          ..write('lowStockThreshold: $lowStockThreshold, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeedPlansTable extends FeedPlans
    with TableInfo<$FeedPlansTable, FeedPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> validFrom =
      GeneratedColumn<String>(
        'valid_from',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>($FeedPlansTable.$convertervalidFrom);
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
    horseId,
    name,
    validFrom,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedPlanRow> instance, {
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  FeedPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedPlanRow(
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
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      validFrom: $FeedPlansTable.$convertervalidFrom.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}valid_from'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $FeedPlansTable createAlias(String alias) {
    return $FeedPlansTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $convertervalidFrom =
      const LocalDateConverter();
}

class FeedPlanRow extends DataClass implements Insertable<FeedPlanRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String horseId;
  final String name;
  final LocalDate validFrom;
  final String? notes;
  const FeedPlanRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.horseId,
    required this.name,
    required this.validFrom,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['horse_id'] = Variable<String>(horseId);
    map['name'] = Variable<String>(name);
    {
      map['valid_from'] = Variable<String>(
        $FeedPlansTable.$convertervalidFrom.toSql(validFrom),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FeedPlansCompanion toCompanion(bool nullToAbsent) {
    return FeedPlansCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      horseId: Value(horseId),
      name: Value(name),
      validFrom: Value(validFrom),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory FeedPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedPlanRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      horseId: serializer.fromJson<String>(json['horseId']),
      name: serializer.fromJson<String>(json['name']),
      validFrom: serializer.fromJson<LocalDate>(json['validFrom']),
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
      'horseId': serializer.toJson<String>(horseId),
      'name': serializer.toJson<String>(name),
      'validFrom': serializer.toJson<LocalDate>(validFrom),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FeedPlanRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? horseId,
    String? name,
    LocalDate? validFrom,
    Value<String?> notes = const Value.absent(),
  }) => FeedPlanRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    horseId: horseId ?? this.horseId,
    name: name ?? this.name,
    validFrom: validFrom ?? this.validFrom,
    notes: notes.present ? notes.value : this.notes,
  );
  FeedPlanRow copyWithCompanion(FeedPlansCompanion data) {
    return FeedPlanRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      name: data.name.present ? data.name.value : this.name,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedPlanRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('name: $name, ')
          ..write('validFrom: $validFrom, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, horseId, name, validFrom, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedPlanRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.horseId == this.horseId &&
          other.name == this.name &&
          other.validFrom == this.validFrom &&
          other.notes == this.notes);
}

class FeedPlansCompanion extends UpdateCompanion<FeedPlanRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> horseId;
  final Value<String> name;
  final Value<LocalDate> validFrom;
  final Value<String?> notes;
  final Value<int> rowid;
  const FeedPlansCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.horseId = const Value.absent(),
    this.name = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedPlansCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String horseId,
    required String name,
    required LocalDate validFrom,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       horseId = Value(horseId),
       name = Value(name),
       validFrom = Value(validFrom);
  static Insertable<FeedPlanRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? horseId,
    Expression<String>? name,
    Expression<String>? validFrom,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (horseId != null) 'horse_id': horseId,
      if (name != null) 'name': name,
      if (validFrom != null) 'valid_from': validFrom,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedPlansCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? horseId,
    Value<String>? name,
    Value<LocalDate>? validFrom,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return FeedPlansCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      horseId: horseId ?? this.horseId,
      name: name ?? this.name,
      validFrom: validFrom ?? this.validFrom,
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
    if (horseId.present) {
      map['horse_id'] = Variable<String>(horseId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<String>(
        $FeedPlansTable.$convertervalidFrom.toSql(validFrom.value),
      );
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
    return (StringBuffer('FeedPlansCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('name: $name, ')
          ..write('validFrom: $validFrom, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeedMealsTable extends FeedMeals
    with TableInfo<$FeedMealsTable, FeedMealRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedMealsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES feed_plans (id) ON DELETE CASCADE',
    ),
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
    planId,
    name,
    timeMinutes,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedMealRow> instance, {
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
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  FeedMealRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedMealRow(
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
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      timeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_minutes'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $FeedMealsTable createAlias(String alias) {
    return $FeedMealsTable(attachedDatabase, alias);
  }
}

class FeedMealRow extends DataClass implements Insertable<FeedMealRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String planId;
  final String name;
  final int? timeMinutes;
  final int sortOrder;
  const FeedMealRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.planId,
    required this.name,
    this.timeMinutes,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || timeMinutes != null) {
      map['time_minutes'] = Variable<int>(timeMinutes);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  FeedMealsCompanion toCompanion(bool nullToAbsent) {
    return FeedMealsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      planId: Value(planId),
      name: Value(name),
      timeMinutes: timeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(timeMinutes),
      sortOrder: Value(sortOrder),
    );
  }

  factory FeedMealRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedMealRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      name: serializer.fromJson<String>(json['name']),
      timeMinutes: serializer.fromJson<int?>(json['timeMinutes']),
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
      'planId': serializer.toJson<String>(planId),
      'name': serializer.toJson<String>(name),
      'timeMinutes': serializer.toJson<int?>(timeMinutes),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  FeedMealRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? planId,
    String? name,
    Value<int?> timeMinutes = const Value.absent(),
    int? sortOrder,
  }) => FeedMealRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    planId: planId ?? this.planId,
    name: name ?? this.name,
    timeMinutes: timeMinutes.present ? timeMinutes.value : this.timeMinutes,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  FeedMealRow copyWithCompanion(FeedMealsCompanion data) {
    return FeedMealRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      name: data.name.present ? data.name.value : this.name,
      timeMinutes: data.timeMinutes.present
          ? data.timeMinutes.value
          : this.timeMinutes,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedMealRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('name: $name, ')
          ..write('timeMinutes: $timeMinutes, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    planId,
    name,
    timeMinutes,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedMealRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.name == this.name &&
          other.timeMinutes == this.timeMinutes &&
          other.sortOrder == this.sortOrder);
}

class FeedMealsCompanion extends UpdateCompanion<FeedMealRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> planId;
  final Value<String> name;
  final Value<int?> timeMinutes;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const FeedMealsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.name = const Value.absent(),
    this.timeMinutes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedMealsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String planId,
    required String name,
    this.timeMinutes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       planId = Value(planId),
       name = Value(name);
  static Insertable<FeedMealRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? name,
    Expression<int>? timeMinutes,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (name != null) 'name': name,
      if (timeMinutes != null) 'time_minutes': timeMinutes,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedMealsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? planId,
    Value<String>? name,
    Value<int?>? timeMinutes,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return FeedMealsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      planId: planId ?? this.planId,
      name: name ?? this.name,
      timeMinutes: timeMinutes ?? this.timeMinutes,
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
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (timeMinutes.present) {
      map['time_minutes'] = Variable<int>(timeMinutes.value);
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
    return (StringBuffer('FeedMealsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('name: $name, ')
          ..write('timeMinutes: $timeMinutes, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeedMealItemsTable extends FeedMealItems
    with TableInfo<$FeedMealItemsTable, FeedMealItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedMealItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<String> mealId = GeneratedColumn<String>(
    'meal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES feed_meals (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES feed_items (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantMeta = const VerificationMeta(
    'variant',
  );
  @override
  late final GeneratedColumn<String> variant = GeneratedColumn<String>(
    'variant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('always'),
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
    mealId,
    itemId,
    amount,
    variant,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_meal_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedMealItemRow> instance, {
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
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('variant')) {
      context.handle(
        _variantMeta,
        variant.isAcceptableOrUnknown(data['variant']!, _variantMeta),
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
  FeedMealItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedMealItemRow(
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
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      variant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $FeedMealItemsTable createAlias(String alias) {
    return $FeedMealItemsTable(attachedDatabase, alias);
  }
}

class FeedMealItemRow extends DataClass implements Insertable<FeedMealItemRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String mealId;
  final String itemId;
  final double amount;

  /// Siehe `FeedVariant.key` (always/training/rest).
  final String variant;
  final int sortOrder;
  const FeedMealItemRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.mealId,
    required this.itemId,
    required this.amount,
    required this.variant,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['meal_id'] = Variable<String>(mealId);
    map['item_id'] = Variable<String>(itemId);
    map['amount'] = Variable<double>(amount);
    map['variant'] = Variable<String>(variant);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  FeedMealItemsCompanion toCompanion(bool nullToAbsent) {
    return FeedMealItemsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      mealId: Value(mealId),
      itemId: Value(itemId),
      amount: Value(amount),
      variant: Value(variant),
      sortOrder: Value(sortOrder),
    );
  }

  factory FeedMealItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedMealItemRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      mealId: serializer.fromJson<String>(json['mealId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      amount: serializer.fromJson<double>(json['amount']),
      variant: serializer.fromJson<String>(json['variant']),
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
      'mealId': serializer.toJson<String>(mealId),
      'itemId': serializer.toJson<String>(itemId),
      'amount': serializer.toJson<double>(amount),
      'variant': serializer.toJson<String>(variant),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  FeedMealItemRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? mealId,
    String? itemId,
    double? amount,
    String? variant,
    int? sortOrder,
  }) => FeedMealItemRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    mealId: mealId ?? this.mealId,
    itemId: itemId ?? this.itemId,
    amount: amount ?? this.amount,
    variant: variant ?? this.variant,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  FeedMealItemRow copyWithCompanion(FeedMealItemsCompanion data) {
    return FeedMealItemRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      mealId: data.mealId.present ? data.mealId.value : this.mealId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      amount: data.amount.present ? data.amount.value : this.amount,
      variant: data.variant.present ? data.variant.value : this.variant,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedMealItemRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('itemId: $itemId, ')
          ..write('amount: $amount, ')
          ..write('variant: $variant, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    mealId,
    itemId,
    amount,
    variant,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedMealItemRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.mealId == this.mealId &&
          other.itemId == this.itemId &&
          other.amount == this.amount &&
          other.variant == this.variant &&
          other.sortOrder == this.sortOrder);
}

class FeedMealItemsCompanion extends UpdateCompanion<FeedMealItemRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> mealId;
  final Value<String> itemId;
  final Value<double> amount;
  final Value<String> variant;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const FeedMealItemsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.mealId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.amount = const Value.absent(),
    this.variant = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedMealItemsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String mealId,
    required String itemId,
    required double amount,
    this.variant = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mealId = Value(mealId),
       itemId = Value(itemId),
       amount = Value(amount);
  static Insertable<FeedMealItemRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? mealId,
    Expression<String>? itemId,
    Expression<double>? amount,
    Expression<String>? variant,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (mealId != null) 'meal_id': mealId,
      if (itemId != null) 'item_id': itemId,
      if (amount != null) 'amount': amount,
      if (variant != null) 'variant': variant,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedMealItemsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? mealId,
    Value<String>? itemId,
    Value<double>? amount,
    Value<String>? variant,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return FeedMealItemsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      mealId: mealId ?? this.mealId,
      itemId: itemId ?? this.itemId,
      amount: amount ?? this.amount,
      variant: variant ?? this.variant,
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
    if (mealId.present) {
      map['meal_id'] = Variable<String>(mealId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (variant.present) {
      map['variant'] = Variable<String>(variant.value);
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
    return (StringBuffer('FeedMealItemsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('itemId: $itemId, ')
          ..write('amount: $amount, ')
          ..write('variant: $variant, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeedSupplementsTemporaryTable extends FeedSupplementsTemporary
    with TableInfo<$FeedSupplementsTemporaryTable, FeedSupplementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedSupplementsTemporaryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES feed_items (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mealNameMeta = const VerificationMeta(
    'mealName',
  );
  @override
  late final GeneratedColumn<String> mealName = GeneratedColumn<String>(
    'meal_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> startDate =
      GeneratedColumn<String>(
        'start_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>(
        $FeedSupplementsTemporaryTable.$converterstartDate,
      );
  @override
  late final GeneratedColumnWithTypeConverter<LocalDate, String> endDate =
      GeneratedColumn<String>(
        'end_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocalDate>(
        $FeedSupplementsTemporaryTable.$converterendDate,
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
  static const VerificationMeta _bloodTestIdMeta = const VerificationMeta(
    'bloodTestId',
  );
  @override
  late final GeneratedColumn<String> bloodTestId = GeneratedColumn<String>(
    'blood_test_id',
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
    itemId,
    amount,
    mealName,
    startDate,
    endDate,
    note,
    source,
    bloodTestId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_supplements_temporary';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedSupplementRow> instance, {
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
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('meal_name')) {
      context.handle(
        _mealNameMeta,
        mealName.isAcceptableOrUnknown(data['meal_name']!, _mealNameMeta),
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
    if (data.containsKey('blood_test_id')) {
      context.handle(
        _bloodTestIdMeta,
        bloodTestId.isAcceptableOrUnknown(
          data['blood_test_id']!,
          _bloodTestIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedSupplementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedSupplementRow(
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
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      mealName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_name'],
      ),
      startDate: $FeedSupplementsTemporaryTable.$converterstartDate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}start_date'],
        )!,
      ),
      endDate: $FeedSupplementsTemporaryTable.$converterendDate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}end_date'],
        )!,
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      bloodTestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_test_id'],
      ),
    );
  }

  @override
  $FeedSupplementsTemporaryTable createAlias(String alias) {
    return $FeedSupplementsTemporaryTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterstartDate =
      const LocalDateConverter();
  static TypeConverter<LocalDate, String> $converterendDate =
      const LocalDateConverter();
}

class FeedSupplementRow extends DataClass
    implements Insertable<FeedSupplementRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String horseId;
  final String itemId;

  /// `null` = laut Packungsangabe.
  final double? amount;

  /// Name der Mahlzeit (Pläne haben Versionen – daher kein Fremdschlüssel).
  final String? mealName;
  final LocalDate startDate;
  final LocalDate endDate;
  final String? note;

  /// Siehe `SupplementSource.key` (manual/blood).
  final String source;

  /// Bezug zum Blutbild (ab Schema v7), ohne Fremdschlüssel.
  final String? bloodTestId;
  const FeedSupplementRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.horseId,
    required this.itemId,
    this.amount,
    this.mealName,
    required this.startDate,
    required this.endDate,
    this.note,
    required this.source,
    this.bloodTestId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['id'] = Variable<String>(id);
    map['horse_id'] = Variable<String>(horseId);
    map['item_id'] = Variable<String>(itemId);
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || mealName != null) {
      map['meal_name'] = Variable<String>(mealName);
    }
    {
      map['start_date'] = Variable<String>(
        $FeedSupplementsTemporaryTable.$converterstartDate.toSql(startDate),
      );
    }
    {
      map['end_date'] = Variable<String>(
        $FeedSupplementsTemporaryTable.$converterendDate.toSql(endDate),
      );
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || bloodTestId != null) {
      map['blood_test_id'] = Variable<String>(bloodTestId);
    }
    return map;
  }

  FeedSupplementsTemporaryCompanion toCompanion(bool nullToAbsent) {
    return FeedSupplementsTemporaryCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      horseId: Value(horseId),
      itemId: Value(itemId),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      mealName: mealName == null && nullToAbsent
          ? const Value.absent()
          : Value(mealName),
      startDate: Value(startDate),
      endDate: Value(endDate),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      source: Value(source),
      bloodTestId: bloodTestId == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodTestId),
    );
  }

  factory FeedSupplementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedSupplementRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      horseId: serializer.fromJson<String>(json['horseId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      amount: serializer.fromJson<double?>(json['amount']),
      mealName: serializer.fromJson<String?>(json['mealName']),
      startDate: serializer.fromJson<LocalDate>(json['startDate']),
      endDate: serializer.fromJson<LocalDate>(json['endDate']),
      note: serializer.fromJson<String?>(json['note']),
      source: serializer.fromJson<String>(json['source']),
      bloodTestId: serializer.fromJson<String?>(json['bloodTestId']),
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
      'itemId': serializer.toJson<String>(itemId),
      'amount': serializer.toJson<double?>(amount),
      'mealName': serializer.toJson<String?>(mealName),
      'startDate': serializer.toJson<LocalDate>(startDate),
      'endDate': serializer.toJson<LocalDate>(endDate),
      'note': serializer.toJson<String?>(note),
      'source': serializer.toJson<String>(source),
      'bloodTestId': serializer.toJson<String?>(bloodTestId),
    };
  }

  FeedSupplementRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? horseId,
    String? itemId,
    Value<double?> amount = const Value.absent(),
    Value<String?> mealName = const Value.absent(),
    LocalDate? startDate,
    LocalDate? endDate,
    Value<String?> note = const Value.absent(),
    String? source,
    Value<String?> bloodTestId = const Value.absent(),
  }) => FeedSupplementRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    horseId: horseId ?? this.horseId,
    itemId: itemId ?? this.itemId,
    amount: amount.present ? amount.value : this.amount,
    mealName: mealName.present ? mealName.value : this.mealName,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    note: note.present ? note.value : this.note,
    source: source ?? this.source,
    bloodTestId: bloodTestId.present ? bloodTestId.value : this.bloodTestId,
  );
  FeedSupplementRow copyWithCompanion(FeedSupplementsTemporaryCompanion data) {
    return FeedSupplementRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      amount: data.amount.present ? data.amount.value : this.amount,
      mealName: data.mealName.present ? data.mealName.value : this.mealName,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      note: data.note.present ? data.note.value : this.note,
      source: data.source.present ? data.source.value : this.source,
      bloodTestId: data.bloodTestId.present
          ? data.bloodTestId.value
          : this.bloodTestId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedSupplementRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('itemId: $itemId, ')
          ..write('amount: $amount, ')
          ..write('mealName: $mealName, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('bloodTestId: $bloodTestId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    id,
    horseId,
    itemId,
    amount,
    mealName,
    startDate,
    endDate,
    note,
    source,
    bloodTestId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedSupplementRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.horseId == this.horseId &&
          other.itemId == this.itemId &&
          other.amount == this.amount &&
          other.mealName == this.mealName &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.note == this.note &&
          other.source == this.source &&
          other.bloodTestId == this.bloodTestId);
}

class FeedSupplementsTemporaryCompanion
    extends UpdateCompanion<FeedSupplementRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> horseId;
  final Value<String> itemId;
  final Value<double?> amount;
  final Value<String?> mealName;
  final Value<LocalDate> startDate;
  final Value<LocalDate> endDate;
  final Value<String?> note;
  final Value<String> source;
  final Value<String?> bloodTestId;
  final Value<int> rowid;
  const FeedSupplementsTemporaryCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.horseId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.amount = const Value.absent(),
    this.mealName = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.bloodTestId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedSupplementsTemporaryCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String horseId,
    required String itemId,
    this.amount = const Value.absent(),
    this.mealName = const Value.absent(),
    required LocalDate startDate,
    required LocalDate endDate,
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.bloodTestId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       horseId = Value(horseId),
       itemId = Value(itemId),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<FeedSupplementRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? horseId,
    Expression<String>? itemId,
    Expression<double>? amount,
    Expression<String>? mealName,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? note,
    Expression<String>? source,
    Expression<String>? bloodTestId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (horseId != null) 'horse_id': horseId,
      if (itemId != null) 'item_id': itemId,
      if (amount != null) 'amount': amount,
      if (mealName != null) 'meal_name': mealName,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (note != null) 'note': note,
      if (source != null) 'source': source,
      if (bloodTestId != null) 'blood_test_id': bloodTestId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedSupplementsTemporaryCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? horseId,
    Value<String>? itemId,
    Value<double?>? amount,
    Value<String?>? mealName,
    Value<LocalDate>? startDate,
    Value<LocalDate>? endDate,
    Value<String?>? note,
    Value<String>? source,
    Value<String?>? bloodTestId,
    Value<int>? rowid,
  }) {
    return FeedSupplementsTemporaryCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      horseId: horseId ?? this.horseId,
      itemId: itemId ?? this.itemId,
      amount: amount ?? this.amount,
      mealName: mealName ?? this.mealName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      note: note ?? this.note,
      source: source ?? this.source,
      bloodTestId: bloodTestId ?? this.bloodTestId,
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
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (mealName.present) {
      map['meal_name'] = Variable<String>(mealName.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(
        $FeedSupplementsTemporaryTable.$converterstartDate.toSql(
          startDate.value,
        ),
      );
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(
        $FeedSupplementsTemporaryTable.$converterendDate.toSql(endDate.value),
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (bloodTestId.present) {
      map['blood_test_id'] = Variable<String>(bloodTestId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedSupplementsTemporaryCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('itemId: $itemId, ')
          ..write('amount: $amount, ')
          ..write('mealName: $mealName, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('bloodTestId: $bloodTestId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BloodTestsTable extends BloodTests
    with TableInfo<$BloodTestsTable, BloodTestRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodTestsTable(this.attachedDatabase, [this._alias]);
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
      ).withConverter<LocalDate>($BloodTestsTable.$converterdate);
  static const VerificationMeta _labMeta = const VerificationMeta('lab');
  @override
  late final GeneratedColumn<String> lab = GeneratedColumn<String>(
    'lab',
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
    horseId,
    date,
    lab,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_tests';
  @override
  VerificationContext validateIntegrity(
    Insertable<BloodTestRow> instance, {
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
    if (data.containsKey('lab')) {
      context.handle(
        _labMeta,
        lab.isAcceptableOrUnknown(data['lab']!, _labMeta),
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
  BloodTestRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodTestRow(
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
      date: $BloodTestsTable.$converterdate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}date'],
        )!,
      ),
      lab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lab'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $BloodTestsTable createAlias(String alias) {
    return $BloodTestsTable(attachedDatabase, alias);
  }

  static TypeConverter<LocalDate, String> $converterdate =
      const LocalDateConverter();
}

class BloodTestRow extends DataClass implements Insertable<BloodTestRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;
  final String horseId;
  final LocalDate date;
  final String? lab;
  final String? notes;
  const BloodTestRow({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.horseId,
    required this.date,
    this.lab,
    this.notes,
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
        $BloodTestsTable.$converterdate.toSql(date),
      );
    }
    if (!nullToAbsent || lab != null) {
      map['lab'] = Variable<String>(lab);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  BloodTestsCompanion toCompanion(bool nullToAbsent) {
    return BloodTestsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      id: Value(id),
      horseId: Value(horseId),
      date: Value(date),
      lab: lab == null && nullToAbsent ? const Value.absent() : Value(lab),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory BloodTestRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodTestRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      horseId: serializer.fromJson<String>(json['horseId']),
      date: serializer.fromJson<LocalDate>(json['date']),
      lab: serializer.fromJson<String?>(json['lab']),
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
      'horseId': serializer.toJson<String>(horseId),
      'date': serializer.toJson<LocalDate>(date),
      'lab': serializer.toJson<String?>(lab),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  BloodTestRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? horseId,
    LocalDate? date,
    Value<String?> lab = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => BloodTestRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id ?? this.id,
    horseId: horseId ?? this.horseId,
    date: date ?? this.date,
    lab: lab.present ? lab.value : this.lab,
    notes: notes.present ? notes.value : this.notes,
  );
  BloodTestRow copyWithCompanion(BloodTestsCompanion data) {
    return BloodTestRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      horseId: data.horseId.present ? data.horseId.value : this.horseId,
      date: data.date.present ? data.date.value : this.date,
      lab: data.lab.present ? data.lab.value : this.lab,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BloodTestRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('date: $date, ')
          ..write('lab: $lab, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, id, horseId, date, lab, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodTestRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.horseId == this.horseId &&
          other.date == this.date &&
          other.lab == this.lab &&
          other.notes == this.notes);
}

class BloodTestsCompanion extends UpdateCompanion<BloodTestRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> id;
  final Value<String> horseId;
  final Value<LocalDate> date;
  final Value<String?> lab;
  final Value<String?> notes;
  final Value<int> rowid;
  const BloodTestsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.horseId = const Value.absent(),
    this.date = const Value.absent(),
    this.lab = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BloodTestsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String id,
    required String horseId,
    required LocalDate date,
    this.lab = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       horseId = Value(horseId),
       date = Value(date);
  static Insertable<BloodTestRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? horseId,
    Expression<String>? date,
    Expression<String>? lab,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (horseId != null) 'horse_id': horseId,
      if (date != null) 'date': date,
      if (lab != null) 'lab': lab,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BloodTestsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? id,
    Value<String>? horseId,
    Value<LocalDate>? date,
    Value<String?>? lab,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return BloodTestsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      horseId: horseId ?? this.horseId,
      date: date ?? this.date,
      lab: lab ?? this.lab,
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
    if (horseId.present) {
      map['horse_id'] = Variable<String>(horseId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(
        $BloodTestsTable.$converterdate.toSql(date.value),
      );
    }
    if (lab.present) {
      map['lab'] = Variable<String>(lab.value);
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
    return (StringBuffer('BloodTestsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('horseId: $horseId, ')
          ..write('date: $date, ')
          ..write('lab: $lab, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BloodValuesTable extends BloodValues
    with TableInfo<$BloodValuesTable, BloodValueRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodValuesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<String> testId = GeneratedColumn<String>(
    'test_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES blood_tests (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _paramKeyMeta = const VerificationMeta(
    'paramKey',
  );
  @override
  late final GeneratedColumn<String> paramKey = GeneratedColumn<String>(
    'param_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refLowMeta = const VerificationMeta('refLow');
  @override
  late final GeneratedColumn<double> refLow = GeneratedColumn<double>(
    'ref_low',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refHighMeta = const VerificationMeta(
    'refHigh',
  );
  @override
  late final GeneratedColumn<double> refHigh = GeneratedColumn<double>(
    'ref_high',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    testId,
    paramKey,
    value,
    refLow,
    refHigh,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<BloodValueRow> instance, {
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
    if (data.containsKey('test_id')) {
      context.handle(
        _testIdMeta,
        testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta),
      );
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('param_key')) {
      context.handle(
        _paramKeyMeta,
        paramKey.isAcceptableOrUnknown(data['param_key']!, _paramKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_paramKeyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('ref_low')) {
      context.handle(
        _refLowMeta,
        refLow.isAcceptableOrUnknown(data['ref_low']!, _refLowMeta),
      );
    }
    if (data.containsKey('ref_high')) {
      context.handle(
        _refHighMeta,
        refHigh.isAcceptableOrUnknown(data['ref_high']!, _refHighMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {testId, paramKey};
  @override
  BloodValueRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodValueRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      testId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_id'],
      )!,
      paramKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}param_key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      refLow: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ref_low'],
      ),
      refHigh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ref_high'],
      ),
    );
  }

  @override
  $BloodValuesTable createAlias(String alias) {
    return $BloodValuesTable(attachedDatabase, alias);
  }
}

class BloodValueRow extends DataClass implements Insertable<BloodValueRow> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String testId;

  /// Schlüssel aus `assets/blood_reference.json` (`parameters[].key`).
  final String paramKey;
  final double value;

  /// Eigener Referenzbereich vom Befund (optional).
  final double? refLow;
  final double? refHigh;
  const BloodValueRow({
    required this.createdAt,
    required this.updatedAt,
    required this.testId,
    required this.paramKey,
    required this.value,
    this.refLow,
    this.refHigh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['test_id'] = Variable<String>(testId);
    map['param_key'] = Variable<String>(paramKey);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || refLow != null) {
      map['ref_low'] = Variable<double>(refLow);
    }
    if (!nullToAbsent || refHigh != null) {
      map['ref_high'] = Variable<double>(refHigh);
    }
    return map;
  }

  BloodValuesCompanion toCompanion(bool nullToAbsent) {
    return BloodValuesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      testId: Value(testId),
      paramKey: Value(paramKey),
      value: Value(value),
      refLow: refLow == null && nullToAbsent
          ? const Value.absent()
          : Value(refLow),
      refHigh: refHigh == null && nullToAbsent
          ? const Value.absent()
          : Value(refHigh),
    );
  }

  factory BloodValueRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodValueRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      testId: serializer.fromJson<String>(json['testId']),
      paramKey: serializer.fromJson<String>(json['paramKey']),
      value: serializer.fromJson<double>(json['value']),
      refLow: serializer.fromJson<double?>(json['refLow']),
      refHigh: serializer.fromJson<double?>(json['refHigh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'testId': serializer.toJson<String>(testId),
      'paramKey': serializer.toJson<String>(paramKey),
      'value': serializer.toJson<double>(value),
      'refLow': serializer.toJson<double?>(refLow),
      'refHigh': serializer.toJson<double?>(refHigh),
    };
  }

  BloodValueRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? testId,
    String? paramKey,
    double? value,
    Value<double?> refLow = const Value.absent(),
    Value<double?> refHigh = const Value.absent(),
  }) => BloodValueRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    testId: testId ?? this.testId,
    paramKey: paramKey ?? this.paramKey,
    value: value ?? this.value,
    refLow: refLow.present ? refLow.value : this.refLow,
    refHigh: refHigh.present ? refHigh.value : this.refHigh,
  );
  BloodValueRow copyWithCompanion(BloodValuesCompanion data) {
    return BloodValueRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      testId: data.testId.present ? data.testId.value : this.testId,
      paramKey: data.paramKey.present ? data.paramKey.value : this.paramKey,
      value: data.value.present ? data.value.value : this.value,
      refLow: data.refLow.present ? data.refLow.value : this.refLow,
      refHigh: data.refHigh.present ? data.refHigh.value : this.refHigh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BloodValueRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('testId: $testId, ')
          ..write('paramKey: $paramKey, ')
          ..write('value: $value, ')
          ..write('refLow: $refLow, ')
          ..write('refHigh: $refHigh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    testId,
    paramKey,
    value,
    refLow,
    refHigh,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodValueRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.testId == this.testId &&
          other.paramKey == this.paramKey &&
          other.value == this.value &&
          other.refLow == this.refLow &&
          other.refHigh == this.refHigh);
}

class BloodValuesCompanion extends UpdateCompanion<BloodValueRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> testId;
  final Value<String> paramKey;
  final Value<double> value;
  final Value<double?> refLow;
  final Value<double?> refHigh;
  final Value<int> rowid;
  const BloodValuesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.testId = const Value.absent(),
    this.paramKey = const Value.absent(),
    this.value = const Value.absent(),
    this.refLow = const Value.absent(),
    this.refHigh = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BloodValuesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String testId,
    required String paramKey,
    required double value,
    this.refLow = const Value.absent(),
    this.refHigh = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : testId = Value(testId),
       paramKey = Value(paramKey),
       value = Value(value);
  static Insertable<BloodValueRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? testId,
    Expression<String>? paramKey,
    Expression<double>? value,
    Expression<double>? refLow,
    Expression<double>? refHigh,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (testId != null) 'test_id': testId,
      if (paramKey != null) 'param_key': paramKey,
      if (value != null) 'value': value,
      if (refLow != null) 'ref_low': refLow,
      if (refHigh != null) 'ref_high': refHigh,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BloodValuesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? testId,
    Value<String>? paramKey,
    Value<double>? value,
    Value<double?>? refLow,
    Value<double?>? refHigh,
    Value<int>? rowid,
  }) {
    return BloodValuesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      testId: testId ?? this.testId,
      paramKey: paramKey ?? this.paramKey,
      value: value ?? this.value,
      refLow: refLow ?? this.refLow,
      refHigh: refHigh ?? this.refHigh,
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
    if (testId.present) {
      map['test_id'] = Variable<String>(testId.value);
    }
    if (paramKey.present) {
      map['param_key'] = Variable<String>(paramKey.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (refLow.present) {
      map['ref_low'] = Variable<double>(refLow.value);
    }
    if (refHigh.present) {
      map['ref_high'] = Variable<double>(refHigh.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BloodValuesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('testId: $testId, ')
          ..write('paramKey: $paramKey, ')
          ..write('value: $value, ')
          ..write('refLow: $refLow, ')
          ..write('refHigh: $refHigh, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotoBlobsTable extends PhotoBlobs
    with TableInfo<$PhotoBlobsTable, PhotoBlobRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoBlobsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<Uint8List> data = GeneratedColumn<Uint8List>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [createdAt, updatedAt, path, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_blobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoBlobRow> instance, {
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
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  PhotoBlobRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoBlobRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}data'],
      )!,
    );
  }

  @override
  $PhotoBlobsTable createAlias(String alias) {
    return $PhotoBlobsTable(attachedDatabase, alias);
  }
}

class PhotoBlobRow extends DataClass implements Insertable<PhotoBlobRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Wie `horse_photos.relative_path`, z. B. `photos/<uuid>.jpg`.
  final String path;
  final Uint8List data;
  const PhotoBlobRow({
    required this.createdAt,
    required this.updatedAt,
    required this.path,
    required this.data,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['path'] = Variable<String>(path);
    map['data'] = Variable<Uint8List>(data);
    return map;
  }

  PhotoBlobsCompanion toCompanion(bool nullToAbsent) {
    return PhotoBlobsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      path: Value(path),
      data: Value(data),
    );
  }

  factory PhotoBlobRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoBlobRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      path: serializer.fromJson<String>(json['path']),
      data: serializer.fromJson<Uint8List>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'path': serializer.toJson<String>(path),
      'data': serializer.toJson<Uint8List>(data),
    };
  }

  PhotoBlobRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? path,
    Uint8List? data,
  }) => PhotoBlobRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    path: path ?? this.path,
    data: data ?? this.data,
  );
  PhotoBlobRow copyWithCompanion(PhotoBlobsCompanion data) {
    return PhotoBlobRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      path: data.path.present ? data.path.value : this.path,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoBlobRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('path: $path, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, path, $driftBlobEquality.hash(data));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoBlobRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.path == this.path &&
          $driftBlobEquality.equals(other.data, this.data));
}

class PhotoBlobsCompanion extends UpdateCompanion<PhotoBlobRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> path;
  final Value<Uint8List> data;
  final Value<int> rowid;
  const PhotoBlobsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.path = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoBlobsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String path,
    required Uint8List data,
    this.rowid = const Value.absent(),
  }) : path = Value(path),
       data = Value(data);
  static Insertable<PhotoBlobRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? path,
    Expression<Uint8List>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (path != null) 'path': path,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoBlobsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? path,
    Value<Uint8List>? data,
    Value<int>? rowid,
  }) {
    return PhotoBlobsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      path: path ?? this.path,
      data: data ?? this.data,
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
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (data.present) {
      map['data'] = Variable<Uint8List>(data.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoBlobsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('path: $path, ')
          ..write('data: $data, ')
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
  late final $TrainingPlansTable trainingPlans = $TrainingPlansTable(this);
  late final $TrainingSessionsTable trainingSessions = $TrainingSessionsTable(
    this,
  );
  late final $FeedItemsTable feedItems = $FeedItemsTable(this);
  late final $FeedPlansTable feedPlans = $FeedPlansTable(this);
  late final $FeedMealsTable feedMeals = $FeedMealsTable(this);
  late final $FeedMealItemsTable feedMealItems = $FeedMealItemsTable(this);
  late final $FeedSupplementsTemporaryTable feedSupplementsTemporary =
      $FeedSupplementsTemporaryTable(this);
  late final $BloodTestsTable bloodTests = $BloodTestsTable(this);
  late final $BloodValuesTable bloodValues = $BloodValuesTable(this);
  late final $PhotoBlobsTable photoBlobs = $PhotoBlobsTable(this);
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
    trainingPlans,
    trainingSessions,
    feedItems,
    feedPlans,
    feedMeals,
    feedMealItems,
    feedSupplementsTemporary,
    bloodTests,
    bloodValues,
    photoBlobs,
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('training_plans', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'training_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('training_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('training_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('feed_plans', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'feed_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('feed_meals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'feed_meals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('feed_meal_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('feed_supplements_temporary', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'horses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('blood_tests', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'blood_tests',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('blood_values', kind: UpdateKind.delete)],
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

  static MultiTypedResultKey<$TrainingPlansTable, List<TrainingPlanRow>>
  _trainingPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trainingPlans,
    aliasName: 'horses__id__training_plans__horse_id',
  );

  $$TrainingPlansTableProcessedTableManager get trainingPlansRefs {
    final manager = $$TrainingPlansTableTableManager(
      $_db,
      $_db.trainingPlans,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_trainingPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TrainingSessionsTable, List<TrainingSessionRow>>
  _trainingSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trainingSessions,
    aliasName: 'horses__id__training_sessions__horse_id',
  );

  $$TrainingSessionsTableProcessedTableManager get trainingSessionsRefs {
    final manager = $$TrainingSessionsTableTableManager(
      $_db,
      $_db.trainingSessions,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _trainingSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FeedPlansTable, List<FeedPlanRow>>
  _feedPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feedPlans,
    aliasName: 'horses__id__feed_plans__horse_id',
  );

  $$FeedPlansTableProcessedTableManager get feedPlansRefs {
    final manager = $$FeedPlansTableTableManager(
      $_db,
      $_db.feedPlans,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_feedPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $FeedSupplementsTemporaryTable,
    List<FeedSupplementRow>
  >
  _feedSupplementsTemporaryRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.feedSupplementsTemporary,
        aliasName: 'horses__id__feed_supplements_temporary__horse_id',
      );

  $$FeedSupplementsTemporaryTableProcessedTableManager
  get feedSupplementsTemporaryRefs {
    final manager = $$FeedSupplementsTemporaryTableTableManager(
      $_db,
      $_db.feedSupplementsTemporary,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _feedSupplementsTemporaryRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BloodTestsTable, List<BloodTestRow>>
  _bloodTestsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bloodTests,
    aliasName: 'horses__id__blood_tests__horse_id',
  );

  $$BloodTestsTableProcessedTableManager get bloodTestsRefs {
    final manager = $$BloodTestsTableTableManager(
      $_db,
      $_db.bloodTests,
    ).filter((f) => f.horseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bloodTestsRefsTable($_db));
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

  Expression<bool> trainingPlansRefs(
    Expression<bool> Function($$TrainingPlansTableFilterComposer f) f,
  ) {
    final $$TrainingPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingPlans,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingPlansTableFilterComposer(
            $db: $db,
            $table: $db.trainingPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trainingSessionsRefs(
    Expression<bool> Function($$TrainingSessionsTableFilterComposer f) f,
  ) {
    final $$TrainingSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableFilterComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> feedPlansRefs(
    Expression<bool> Function($$FeedPlansTableFilterComposer f) f,
  ) {
    final $$FeedPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedPlans,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedPlansTableFilterComposer(
            $db: $db,
            $table: $db.feedPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> feedSupplementsTemporaryRefs(
    Expression<bool> Function($$FeedSupplementsTemporaryTableFilterComposer f)
    f,
  ) {
    final $$FeedSupplementsTemporaryTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.feedSupplementsTemporary,
          getReferencedColumn: (t) => t.horseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FeedSupplementsTemporaryTableFilterComposer(
                $db: $db,
                $table: $db.feedSupplementsTemporary,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> bloodTestsRefs(
    Expression<bool> Function($$BloodTestsTableFilterComposer f) f,
  ) {
    final $$BloodTestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bloodTests,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BloodTestsTableFilterComposer(
            $db: $db,
            $table: $db.bloodTests,
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

  Expression<T> trainingPlansRefs<T extends Object>(
    Expression<T> Function($$TrainingPlansTableAnnotationComposer a) f,
  ) {
    final $$TrainingPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingPlans,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.trainingPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trainingSessionsRefs<T extends Object>(
    Expression<T> Function($$TrainingSessionsTableAnnotationComposer a) f,
  ) {
    final $$TrainingSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> feedPlansRefs<T extends Object>(
    Expression<T> Function($$FeedPlansTableAnnotationComposer a) f,
  ) {
    final $$FeedPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedPlans,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.feedPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> feedSupplementsTemporaryRefs<T extends Object>(
    Expression<T> Function($$FeedSupplementsTemporaryTableAnnotationComposer a)
    f,
  ) {
    final $$FeedSupplementsTemporaryTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.feedSupplementsTemporary,
          getReferencedColumn: (t) => t.horseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FeedSupplementsTemporaryTableAnnotationComposer(
                $db: $db,
                $table: $db.feedSupplementsTemporary,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> bloodTestsRefs<T extends Object>(
    Expression<T> Function($$BloodTestsTableAnnotationComposer a) f,
  ) {
    final $$BloodTestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bloodTests,
      getReferencedColumn: (t) => t.horseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BloodTestsTableAnnotationComposer(
            $db: $db,
            $table: $db.bloodTests,
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
            bool trainingPlansRefs,
            bool trainingSessionsRefs,
            bool feedPlansRefs,
            bool feedSupplementsTemporaryRefs,
            bool bloodTestsRefs,
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
                trainingPlansRefs = false,
                trainingSessionsRefs = false,
                feedPlansRefs = false,
                feedSupplementsTemporaryRefs = false,
                bloodTestsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (horsePhotosRefs) db.horsePhotos,
                    if (horseWeightsRefs) db.horseWeights,
                    if (horseContactsRefs) db.horseContacts,
                    if (careEventsRefs) db.careEvents,
                    if (trainingPlansRefs) db.trainingPlans,
                    if (trainingSessionsRefs) db.trainingSessions,
                    if (feedPlansRefs) db.feedPlans,
                    if (feedSupplementsTemporaryRefs)
                      db.feedSupplementsTemporary,
                    if (bloodTestsRefs) db.bloodTests,
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
                      if (trainingPlansRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          TrainingPlanRow,
                          $TrainingPlansTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._trainingPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).trainingPlansRefs,
                          currentColumn: 'id',
                          referencedColumn: 'horse_id',
                          typedResults: items,
                        ),
                      if (trainingSessionsRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          TrainingSessionRow,
                          $TrainingSessionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._trainingSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).trainingSessionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'horse_id',
                          typedResults: items,
                        ),
                      if (feedPlansRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          FeedPlanRow,
                          $FeedPlansTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._feedPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).feedPlansRefs,
                          currentColumn: 'id',
                          referencedColumn: 'horse_id',
                          typedResults: items,
                        ),
                      if (feedSupplementsTemporaryRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          FeedSupplementRow,
                          $FeedSupplementsTemporaryTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._feedSupplementsTemporaryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).feedSupplementsTemporaryRefs,
                          currentColumn: 'id',
                          referencedColumn: 'horse_id',
                          typedResults: items,
                        ),
                      if (bloodTestsRefs)
                        await $_getPrefetchedDataByColumns<
                          HorseRow,
                          $HorsesTable,
                          BloodTestRow,
                          $BloodTestsTable
                        >(
                          currentTable: table,
                          referencedTable: $$HorsesTableReferences
                              ._bloodTestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HorsesTableReferences(
                                db,
                                table,
                                p0,
                              ).bloodTestsRefs,
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
        bool trainingPlansRefs,
        bool trainingSessionsRefs,
        bool feedPlansRefs,
        bool feedSupplementsTemporaryRefs,
        bool bloodTestsRefs,
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
typedef $$TrainingPlansTableCreateCompanionBuilder =
    TrainingPlansCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String horseId,
      required String goal,
      required String params,
      required LocalDate startDate,
      required int weeks,
      Value<String> status,
      Value<DateTime?> distributedAt,
      Value<int> rowid,
    });
typedef $$TrainingPlansTableUpdateCompanionBuilder =
    TrainingPlansCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> horseId,
      Value<String> goal,
      Value<String> params,
      Value<LocalDate> startDate,
      Value<int> weeks,
      Value<String> status,
      Value<DateTime?> distributedAt,
      Value<int> rowid,
    });

final class $$TrainingPlansTableReferences
    extends
        BaseReferences<_$AppDatabase, $TrainingPlansTable, TrainingPlanRow> {
  $$TrainingPlansTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('training_plans__horse_id__horses__id');

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

  static MultiTypedResultKey<$TrainingSessionsTable, List<TrainingSessionRow>>
  _trainingSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trainingSessions,
    aliasName: 'training_plans__id__training_sessions__plan_id',
  );

  $$TrainingSessionsTableProcessedTableManager get trainingSessionsRefs {
    final manager = $$TrainingSessionsTableTableManager(
      $_db,
      $_db.trainingSessions,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _trainingSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrainingPlansTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingPlansTable> {
  $$TrainingPlansTableFilterComposer({
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

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get params => $composableBuilder(
    column: $table.params,
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

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get distributedAt => $composableBuilder(
    column: $table.distributedAt,
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

  Expression<bool> trainingSessionsRefs(
    Expression<bool> Function($$TrainingSessionsTableFilterComposer f) f,
  ) {
    final $$TrainingSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableFilterComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrainingPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingPlansTable> {
  $$TrainingPlansTableOrderingComposer({
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

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get params => $composableBuilder(
    column: $table.params,
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

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get distributedAt => $composableBuilder(
    column: $table.distributedAt,
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

class $$TrainingPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingPlansTable> {
  $$TrainingPlansTableAnnotationComposer({
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

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get params =>
      $composableBuilder(column: $table.params, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get weeks =>
      $composableBuilder(column: $table.weeks, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get distributedAt => $composableBuilder(
    column: $table.distributedAt,
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

  Expression<T> trainingSessionsRefs<T extends Object>(
    Expression<T> Function($$TrainingSessionsTableAnnotationComposer a) f,
  ) {
    final $$TrainingSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrainingPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainingPlansTable,
          TrainingPlanRow,
          $$TrainingPlansTableFilterComposer,
          $$TrainingPlansTableOrderingComposer,
          $$TrainingPlansTableAnnotationComposer,
          $$TrainingPlansTableCreateCompanionBuilder,
          $$TrainingPlansTableUpdateCompanionBuilder,
          (TrainingPlanRow, $$TrainingPlansTableReferences),
          TrainingPlanRow,
          PrefetchHooks Function({bool horseId, bool trainingSessionsRefs})
        > {
  $$TrainingPlansTableTableManager(_$AppDatabase db, $TrainingPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainingPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainingPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<String> goal = const Value.absent(),
                Value<String> params = const Value.absent(),
                Value<LocalDate> startDate = const Value.absent(),
                Value<int> weeks = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> distributedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingPlansCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                goal: goal,
                params: params,
                startDate: startDate,
                weeks: weeks,
                status: status,
                distributedAt: distributedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String horseId,
                required String goal,
                required String params,
                required LocalDate startDate,
                required int weeks,
                Value<String> status = const Value.absent(),
                Value<DateTime?> distributedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingPlansCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                goal: goal,
                params: params,
                startDate: startDate,
                weeks: weeks,
                status: status,
                distributedAt: distributedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrainingPlansTable, TrainingPlanRow>(table),
                  $$TrainingPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({horseId = false, trainingSessionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (trainingSessionsRefs) db.trainingSessions,
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
                            referencedTable: $$TrainingPlansTableReferences
                                ._horseIdTable(db),
                            referencedColumn: $$TrainingPlansTableReferences
                                ._horseIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (trainingSessionsRefs)
                        await $_getPrefetchedDataByColumns<
                          TrainingPlanRow,
                          $TrainingPlansTable,
                          TrainingSessionRow,
                          $TrainingSessionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$TrainingPlansTableReferences
                              ._trainingSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TrainingPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).trainingSessionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'plan_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TrainingPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainingPlansTable,
      TrainingPlanRow,
      $$TrainingPlansTableFilterComposer,
      $$TrainingPlansTableOrderingComposer,
      $$TrainingPlansTableAnnotationComposer,
      $$TrainingPlansTableCreateCompanionBuilder,
      $$TrainingPlansTableUpdateCompanionBuilder,
      (TrainingPlanRow, $$TrainingPlansTableReferences),
      TrainingPlanRow,
      PrefetchHooks Function({bool horseId, bool trainingSessionsRefs})
    >;
typedef $$TrainingSessionsTableCreateCompanionBuilder =
    TrainingSessionsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      Value<String?> planId,
      required String horseId,
      required LocalDate date,
      Value<String?> templateKey,
      Value<String?> form,
      required String title,
      required int level,
      required int durationMinutes,
      Value<String> content,
      Value<String> status,
      Value<int?> rating,
      Value<String?> notes,
      Value<bool> pinned,
      Value<String?> reason,
      Value<int> rowid,
    });
typedef $$TrainingSessionsTableUpdateCompanionBuilder =
    TrainingSessionsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String?> planId,
      Value<String> horseId,
      Value<LocalDate> date,
      Value<String?> templateKey,
      Value<String?> form,
      Value<String> title,
      Value<int> level,
      Value<int> durationMinutes,
      Value<String> content,
      Value<String> status,
      Value<int?> rating,
      Value<String?> notes,
      Value<bool> pinned,
      Value<String?> reason,
      Value<int> rowid,
    });

final class $$TrainingSessionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TrainingSessionsTable,
          TrainingSessionRow
        > {
  $$TrainingSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrainingPlansTable _planIdTable(_$AppDatabase db) => db.trainingPlans
      .createAlias('training_sessions__plan_id__training_plans__id');

  $$TrainingPlansTableProcessedTableManager? get planId {
    final $_column = $_itemColumn<String>('plan_id');
    if ($_column == null) return null;
    final manager = $$TrainingPlansTableTableManager(
      $_db,
      $_db.trainingPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('training_sessions__horse_id__horses__id');

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

class $$TrainingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTable> {
  $$TrainingSessionsTableFilterComposer({
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

  ColumnFilters<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pinned => $composableBuilder(
    column: $table.pinned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  $$TrainingPlansTableFilterComposer get planId {
    final $$TrainingPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.trainingPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingPlansTableFilterComposer(
            $db: $db,
            $table: $db.trainingPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$TrainingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTable> {
  $$TrainingSessionsTableOrderingComposer({
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

  ColumnOrderings<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get form => $composableBuilder(
    column: $table.form,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pinned => $composableBuilder(
    column: $table.pinned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrainingPlansTableOrderingComposer get planId {
    final $$TrainingPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.trainingPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingPlansTableOrderingComposer(
            $db: $db,
            $table: $db.trainingPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$TrainingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTable> {
  $$TrainingSessionsTableAnnotationComposer({
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

  GeneratedColumn<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  $$TrainingPlansTableAnnotationComposer get planId {
    final $$TrainingPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.trainingPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.trainingPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$TrainingSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainingSessionsTable,
          TrainingSessionRow,
          $$TrainingSessionsTableFilterComposer,
          $$TrainingSessionsTableOrderingComposer,
          $$TrainingSessionsTableAnnotationComposer,
          $$TrainingSessionsTableCreateCompanionBuilder,
          $$TrainingSessionsTableUpdateCompanionBuilder,
          (TrainingSessionRow, $$TrainingSessionsTableReferences),
          TrainingSessionRow,
          PrefetchHooks Function({bool planId, bool horseId})
        > {
  $$TrainingSessionsTableTableManager(
    _$AppDatabase db,
    $TrainingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> planId = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<LocalDate> date = const Value.absent(),
                Value<String?> templateKey = const Value.absent(),
                Value<String?> form = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> pinned = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingSessionsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                planId: planId,
                horseId: horseId,
                date: date,
                templateKey: templateKey,
                form: form,
                title: title,
                level: level,
                durationMinutes: durationMinutes,
                content: content,
                status: status,
                rating: rating,
                notes: notes,
                pinned: pinned,
                reason: reason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                Value<String?> planId = const Value.absent(),
                required String horseId,
                required LocalDate date,
                Value<String?> templateKey = const Value.absent(),
                Value<String?> form = const Value.absent(),
                required String title,
                required int level,
                required int durationMinutes,
                Value<String> content = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> pinned = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingSessionsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                planId: planId,
                horseId: horseId,
                date: date,
                templateKey: templateKey,
                form: form,
                title: title,
                level: level,
                durationMinutes: durationMinutes,
                content: content,
                status: status,
                rating: rating,
                notes: notes,
                pinned: pinned,
                reason: reason,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrainingSessionsTable, TrainingSessionRow>(
                    table,
                  ),
                  $$TrainingSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false, horseId = false}) {
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
                    if (planId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.planId,
                        referencedTable: $$TrainingSessionsTableReferences
                            ._planIdTable(db),
                        referencedColumn: $$TrainingSessionsTableReferences
                            ._planIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (horseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.horseId,
                        referencedTable: $$TrainingSessionsTableReferences
                            ._horseIdTable(db),
                        referencedColumn: $$TrainingSessionsTableReferences
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

typedef $$TrainingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainingSessionsTable,
      TrainingSessionRow,
      $$TrainingSessionsTableFilterComposer,
      $$TrainingSessionsTableOrderingComposer,
      $$TrainingSessionsTableAnnotationComposer,
      $$TrainingSessionsTableCreateCompanionBuilder,
      $$TrainingSessionsTableUpdateCompanionBuilder,
      (TrainingSessionRow, $$TrainingSessionsTableReferences),
      TrainingSessionRow,
      PrefetchHooks Function({bool planId, bool horseId})
    >;
typedef $$FeedItemsTableCreateCompanionBuilder = FeedItemsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String id,
  required String name,
  required String category,
  required String unit,
  Value<String?> notes,
  Value<double?> stock,
  Value<double?> lowStockThreshold,
  Value<bool> archived,
  Value<int> rowid,
});
typedef $$FeedItemsTableUpdateCompanionBuilder = FeedItemsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<String> unit,
  Value<String?> notes,
  Value<double?> stock,
  Value<double?> lowStockThreshold,
  Value<bool> archived,
  Value<int> rowid,
});

final class $$FeedItemsTableReferences
    extends BaseReferences<_$AppDatabase, $FeedItemsTable, FeedItemRow> {
  $$FeedItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FeedMealItemsTable, List<FeedMealItemRow>>
  _feedMealItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feedMealItems,
    aliasName: 'feed_items__id__feed_meal_items__item_id',
  );

  $$FeedMealItemsTableProcessedTableManager get feedMealItemsRefs {
    final manager = $$FeedMealItemsTableTableManager(
      $_db,
      $_db.feedMealItems,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_feedMealItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $FeedSupplementsTemporaryTable,
    List<FeedSupplementRow>
  >
  _feedSupplementsTemporaryRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.feedSupplementsTemporary,
        aliasName: 'feed_items__id__feed_supplements_temporary__item_id',
      );

  $$FeedSupplementsTemporaryTableProcessedTableManager
  get feedSupplementsTemporaryRefs {
    final manager = $$FeedSupplementsTemporaryTableTableManager(
      $_db,
      $_db.feedSupplementsTemporary,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _feedSupplementsTemporaryRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FeedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableFilterComposer({
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> feedMealItemsRefs(
    Expression<bool> Function($$FeedMealItemsTableFilterComposer f) f,
  ) {
    final $$FeedMealItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedMealItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealItemsTableFilterComposer(
            $db: $db,
            $table: $db.feedMealItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> feedSupplementsTemporaryRefs(
    Expression<bool> Function($$FeedSupplementsTemporaryTableFilterComposer f)
    f,
  ) {
    final $$FeedSupplementsTemporaryTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.feedSupplementsTemporary,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FeedSupplementsTemporaryTableFilterComposer(
                $db: $db,
                $table: $db.feedSupplementsTemporary,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FeedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableOrderingComposer({
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableAnnotationComposer({
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

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<double> get lowStockThreshold => $composableBuilder(
    column: $table.lowStockThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  Expression<T> feedMealItemsRefs<T extends Object>(
    Expression<T> Function($$FeedMealItemsTableAnnotationComposer a) f,
  ) {
    final $$FeedMealItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedMealItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedMealItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> feedSupplementsTemporaryRefs<T extends Object>(
    Expression<T> Function($$FeedSupplementsTemporaryTableAnnotationComposer a)
    f,
  ) {
    final $$FeedSupplementsTemporaryTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.feedSupplementsTemporary,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FeedSupplementsTemporaryTableAnnotationComposer(
                $db: $db,
                $table: $db.feedSupplementsTemporary,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FeedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedItemsTable,
          FeedItemRow,
          $$FeedItemsTableFilterComposer,
          $$FeedItemsTableOrderingComposer,
          $$FeedItemsTableAnnotationComposer,
          $$FeedItemsTableCreateCompanionBuilder,
          $$FeedItemsTableUpdateCompanionBuilder,
          (FeedItemRow, $$FeedItemsTableReferences),
          FeedItemRow,
          PrefetchHooks Function({
            bool feedMealItemsRefs,
            bool feedSupplementsTemporaryRefs,
          })
        > {
  $$FeedItemsTableTableManager(_$AppDatabase db, $FeedItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> stock = const Value.absent(),
                Value<double?> lowStockThreshold = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedItemsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                category: category,
                unit: unit,
                notes: notes,
                stock: stock,
                lowStockThreshold: lowStockThreshold,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String name,
                required String category,
                required String unit,
                Value<String?> notes = const Value.absent(),
                Value<double?> stock = const Value.absent(),
                Value<double?> lowStockThreshold = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedItemsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                name: name,
                category: category,
                unit: unit,
                notes: notes,
                stock: stock,
                lowStockThreshold: lowStockThreshold,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedItemsTable, FeedItemRow>(table),
                  $$FeedItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                feedMealItemsRefs = false,
                feedSupplementsTemporaryRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (feedMealItemsRefs) db.feedMealItems,
                    if (feedSupplementsTemporaryRefs)
                      db.feedSupplementsTemporary,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (feedMealItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          FeedItemRow,
                          $FeedItemsTable,
                          FeedMealItemRow,
                          $FeedMealItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$FeedItemsTableReferences
                              ._feedMealItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeedItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).feedMealItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'item_id',
                          typedResults: items,
                        ),
                      if (feedSupplementsTemporaryRefs)
                        await $_getPrefetchedDataByColumns<
                          FeedItemRow,
                          $FeedItemsTable,
                          FeedSupplementRow,
                          $FeedSupplementsTemporaryTable
                        >(
                          currentTable: table,
                          referencedTable: $$FeedItemsTableReferences
                              ._feedSupplementsTemporaryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FeedItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).feedSupplementsTemporaryRefs,
                          currentColumn: 'id',
                          referencedColumn: 'item_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FeedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedItemsTable,
      FeedItemRow,
      $$FeedItemsTableFilterComposer,
      $$FeedItemsTableOrderingComposer,
      $$FeedItemsTableAnnotationComposer,
      $$FeedItemsTableCreateCompanionBuilder,
      $$FeedItemsTableUpdateCompanionBuilder,
      (FeedItemRow, $$FeedItemsTableReferences),
      FeedItemRow,
      PrefetchHooks Function({
        bool feedMealItemsRefs,
        bool feedSupplementsTemporaryRefs,
      })
    >;
typedef $$FeedPlansTableCreateCompanionBuilder = FeedPlansCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String id,
  required String horseId,
  required String name,
  required LocalDate validFrom,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$FeedPlansTableUpdateCompanionBuilder = FeedPlansCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> id,
  Value<String> horseId,
  Value<String> name,
  Value<LocalDate> validFrom,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$FeedPlansTableReferences
    extends BaseReferences<_$AppDatabase, $FeedPlansTable, FeedPlanRow> {
  $$FeedPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('feed_plans__horse_id__horses__id');

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

  static MultiTypedResultKey<$FeedMealsTable, List<FeedMealRow>>
  _feedMealsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feedMeals,
    aliasName: 'feed_plans__id__feed_meals__plan_id',
  );

  $$FeedMealsTableProcessedTableManager get feedMealsRefs {
    final manager = $$FeedMealsTableTableManager(
      $_db,
      $_db.feedMeals,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_feedMealsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FeedPlansTableFilterComposer
    extends Composer<_$AppDatabase, $FeedPlansTable> {
  $$FeedPlansTableFilterComposer({
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

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get validFrom =>
      $composableBuilder(
        column: $table.validFrom,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

  Expression<bool> feedMealsRefs(
    Expression<bool> Function($$FeedMealsTableFilterComposer f) f,
  ) {
    final $$FeedMealsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedMeals,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealsTableFilterComposer(
            $db: $db,
            $table: $db.feedMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeedPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedPlansTable> {
  $$FeedPlansTableOrderingComposer({
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

  ColumnOrderings<String> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$FeedPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedPlansTable> {
  $$FeedPlansTableAnnotationComposer({
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

  GeneratedColumnWithTypeConverter<LocalDate, String> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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

  Expression<T> feedMealsRefs<T extends Object>(
    Expression<T> Function($$FeedMealsTableAnnotationComposer a) f,
  ) {
    final $$FeedMealsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedMeals,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeedPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedPlansTable,
          FeedPlanRow,
          $$FeedPlansTableFilterComposer,
          $$FeedPlansTableOrderingComposer,
          $$FeedPlansTableAnnotationComposer,
          $$FeedPlansTableCreateCompanionBuilder,
          $$FeedPlansTableUpdateCompanionBuilder,
          (FeedPlanRow, $$FeedPlansTableReferences),
          FeedPlanRow,
          PrefetchHooks Function({bool horseId, bool feedMealsRefs})
        > {
  $$FeedPlansTableTableManager(_$AppDatabase db, $FeedPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<LocalDate> validFrom = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedPlansCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                name: name,
                validFrom: validFrom,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String horseId,
                required String name,
                required LocalDate validFrom,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedPlansCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                name: name,
                validFrom: validFrom,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedPlansTable, FeedPlanRow>(table),
                  $$FeedPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({horseId = false, feedMealsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (feedMealsRefs) db.feedMeals],
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
                        referencedTable: $$FeedPlansTableReferences
                            ._horseIdTable(db),
                        referencedColumn: $$FeedPlansTableReferences
                            ._horseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feedMealsRefs)
                    await $_getPrefetchedDataByColumns<
                      FeedPlanRow,
                      $FeedPlansTable,
                      FeedMealRow,
                      $FeedMealsTable
                    >(
                      currentTable: table,
                      referencedTable: $$FeedPlansTableReferences
                          ._feedMealsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FeedPlansTableReferences(
                            db,
                            table,
                            p0,
                          ).feedMealsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'plan_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FeedPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedPlansTable,
      FeedPlanRow,
      $$FeedPlansTableFilterComposer,
      $$FeedPlansTableOrderingComposer,
      $$FeedPlansTableAnnotationComposer,
      $$FeedPlansTableCreateCompanionBuilder,
      $$FeedPlansTableUpdateCompanionBuilder,
      (FeedPlanRow, $$FeedPlansTableReferences),
      FeedPlanRow,
      PrefetchHooks Function({bool horseId, bool feedMealsRefs})
    >;
typedef $$FeedMealsTableCreateCompanionBuilder = FeedMealsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String id,
  required String planId,
  required String name,
  Value<int?> timeMinutes,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$FeedMealsTableUpdateCompanionBuilder = FeedMealsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> id,
  Value<String> planId,
  Value<String> name,
  Value<int?> timeMinutes,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$FeedMealsTableReferences
    extends BaseReferences<_$AppDatabase, $FeedMealsTable, FeedMealRow> {
  $$FeedMealsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FeedPlansTable _planIdTable(_$AppDatabase db) =>
      db.feedPlans.createAlias('feed_meals__plan_id__feed_plans__id');

  $$FeedPlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$FeedPlansTableTableManager(
      $_db,
      $_db.feedPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FeedMealItemsTable, List<FeedMealItemRow>>
  _feedMealItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feedMealItems,
    aliasName: 'feed_meals__id__feed_meal_items__meal_id',
  );

  $$FeedMealItemsTableProcessedTableManager get feedMealItemsRefs {
    final manager = $$FeedMealItemsTableTableManager(
      $_db,
      $_db.feedMealItems,
    ).filter((f) => f.mealId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_feedMealItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FeedMealsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedMealsTable> {
  $$FeedMealsTableFilterComposer({
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

  ColumnFilters<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$FeedPlansTableFilterComposer get planId {
    final $$FeedPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.feedPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedPlansTableFilterComposer(
            $db: $db,
            $table: $db.feedPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> feedMealItemsRefs(
    Expression<bool> Function($$FeedMealItemsTableFilterComposer f) f,
  ) {
    final $$FeedMealItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedMealItems,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealItemsTableFilterComposer(
            $db: $db,
            $table: $db.feedMealItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeedMealsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedMealsTable> {
  $$FeedMealsTableOrderingComposer({
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

  ColumnOrderings<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$FeedPlansTableOrderingComposer get planId {
    final $$FeedPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.feedPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedPlansTableOrderingComposer(
            $db: $db,
            $table: $db.feedPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedMealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedMealsTable> {
  $$FeedMealsTableAnnotationComposer({
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

  GeneratedColumn<int> get timeMinutes => $composableBuilder(
    column: $table.timeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$FeedPlansTableAnnotationComposer get planId {
    final $$FeedPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.feedPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.feedPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> feedMealItemsRefs<T extends Object>(
    Expression<T> Function($$FeedMealItemsTableAnnotationComposer a) f,
  ) {
    final $$FeedMealItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedMealItems,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedMealItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeedMealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedMealsTable,
          FeedMealRow,
          $$FeedMealsTableFilterComposer,
          $$FeedMealsTableOrderingComposer,
          $$FeedMealsTableAnnotationComposer,
          $$FeedMealsTableCreateCompanionBuilder,
          $$FeedMealsTableUpdateCompanionBuilder,
          (FeedMealRow, $$FeedMealsTableReferences),
          FeedMealRow,
          PrefetchHooks Function({bool planId, bool feedMealItemsRefs})
        > {
  $$FeedMealsTableTableManager(_$AppDatabase db, $FeedMealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedMealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedMealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedMealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> timeMinutes = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedMealsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                planId: planId,
                name: name,
                timeMinutes: timeMinutes,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String planId,
                required String name,
                Value<int?> timeMinutes = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedMealsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                planId: planId,
                name: name,
                timeMinutes: timeMinutes,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedMealsTable, FeedMealRow>(table),
                  $$FeedMealsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false, feedMealItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (feedMealItemsRefs) db.feedMealItems,
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
                    if (planId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.planId,
                        referencedTable: $$FeedMealsTableReferences
                            ._planIdTable(db),
                        referencedColumn: $$FeedMealsTableReferences
                            ._planIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feedMealItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      FeedMealRow,
                      $FeedMealsTable,
                      FeedMealItemRow,
                      $FeedMealItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$FeedMealsTableReferences
                          ._feedMealItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FeedMealsTableReferences(
                            db,
                            table,
                            p0,
                          ).feedMealItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'meal_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FeedMealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedMealsTable,
      FeedMealRow,
      $$FeedMealsTableFilterComposer,
      $$FeedMealsTableOrderingComposer,
      $$FeedMealsTableAnnotationComposer,
      $$FeedMealsTableCreateCompanionBuilder,
      $$FeedMealsTableUpdateCompanionBuilder,
      (FeedMealRow, $$FeedMealsTableReferences),
      FeedMealRow,
      PrefetchHooks Function({bool planId, bool feedMealItemsRefs})
    >;
typedef $$FeedMealItemsTableCreateCompanionBuilder =
    FeedMealItemsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String mealId,
      required String itemId,
      required double amount,
      Value<String> variant,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$FeedMealItemsTableUpdateCompanionBuilder =
    FeedMealItemsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> mealId,
      Value<String> itemId,
      Value<double> amount,
      Value<String> variant,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$FeedMealItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FeedMealItemsTable, FeedMealItemRow> {
  $$FeedMealItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FeedMealsTable _mealIdTable(_$AppDatabase db) =>
      db.feedMeals.createAlias('feed_meal_items__meal_id__feed_meals__id');

  $$FeedMealsTableProcessedTableManager get mealId {
    final $_column = $_itemColumn<String>('meal_id')!;

    final manager = $$FeedMealsTableTableManager(
      $_db,
      $_db.feedMeals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FeedItemsTable _itemIdTable(_$AppDatabase db) =>
      db.feedItems.createAlias('feed_meal_items__item_id__feed_items__id');

  $$FeedItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$FeedItemsTableTableManager(
      $_db,
      $_db.feedItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FeedMealItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedMealItemsTable> {
  $$FeedMealItemsTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variant => $composableBuilder(
    column: $table.variant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$FeedMealsTableFilterComposer get mealId {
    final $$FeedMealsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.feedMeals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealsTableFilterComposer(
            $db: $db,
            $table: $db.feedMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FeedItemsTableFilterComposer get itemId {
    final $$FeedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.feedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedItemsTableFilterComposer(
            $db: $db,
            $table: $db.feedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedMealItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedMealItemsTable> {
  $$FeedMealItemsTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variant => $composableBuilder(
    column: $table.variant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$FeedMealsTableOrderingComposer get mealId {
    final $$FeedMealsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.feedMeals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealsTableOrderingComposer(
            $db: $db,
            $table: $db.feedMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FeedItemsTableOrderingComposer get itemId {
    final $$FeedItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.feedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedItemsTableOrderingComposer(
            $db: $db,
            $table: $db.feedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedMealItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedMealItemsTable> {
  $$FeedMealItemsTableAnnotationComposer({
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

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get variant =>
      $composableBuilder(column: $table.variant, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$FeedMealsTableAnnotationComposer get mealId {
    final $$FeedMealsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.feedMeals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedMealsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FeedItemsTableAnnotationComposer get itemId {
    final $$FeedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.feedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedMealItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedMealItemsTable,
          FeedMealItemRow,
          $$FeedMealItemsTableFilterComposer,
          $$FeedMealItemsTableOrderingComposer,
          $$FeedMealItemsTableAnnotationComposer,
          $$FeedMealItemsTableCreateCompanionBuilder,
          $$FeedMealItemsTableUpdateCompanionBuilder,
          (FeedMealItemRow, $$FeedMealItemsTableReferences),
          FeedMealItemRow,
          PrefetchHooks Function({bool mealId, bool itemId})
        > {
  $$FeedMealItemsTableTableManager(_$AppDatabase db, $FeedMealItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedMealItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedMealItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedMealItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> mealId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> variant = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedMealItemsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                mealId: mealId,
                itemId: itemId,
                amount: amount,
                variant: variant,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String mealId,
                required String itemId,
                required double amount,
                Value<String> variant = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedMealItemsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                mealId: mealId,
                itemId: itemId,
                amount: amount,
                variant: variant,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedMealItemsTable, FeedMealItemRow>(table),
                  $$FeedMealItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealId = false, itemId = false}) {
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
                    if (mealId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mealId,
                        referencedTable: $$FeedMealItemsTableReferences
                            ._mealIdTable(db),
                        referencedColumn: $$FeedMealItemsTableReferences
                            ._mealIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$FeedMealItemsTableReferences
                            ._itemIdTable(db),
                        referencedColumn: $$FeedMealItemsTableReferences
                            ._itemIdTable(db)
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

typedef $$FeedMealItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedMealItemsTable,
      FeedMealItemRow,
      $$FeedMealItemsTableFilterComposer,
      $$FeedMealItemsTableOrderingComposer,
      $$FeedMealItemsTableAnnotationComposer,
      $$FeedMealItemsTableCreateCompanionBuilder,
      $$FeedMealItemsTableUpdateCompanionBuilder,
      (FeedMealItemRow, $$FeedMealItemsTableReferences),
      FeedMealItemRow,
      PrefetchHooks Function({bool mealId, bool itemId})
    >;
typedef $$FeedSupplementsTemporaryTableCreateCompanionBuilder =
    FeedSupplementsTemporaryCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String id,
      required String horseId,
      required String itemId,
      Value<double?> amount,
      Value<String?> mealName,
      required LocalDate startDate,
      required LocalDate endDate,
      Value<String?> note,
      Value<String> source,
      Value<String?> bloodTestId,
      Value<int> rowid,
    });
typedef $$FeedSupplementsTemporaryTableUpdateCompanionBuilder =
    FeedSupplementsTemporaryCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> id,
      Value<String> horseId,
      Value<String> itemId,
      Value<double?> amount,
      Value<String?> mealName,
      Value<LocalDate> startDate,
      Value<LocalDate> endDate,
      Value<String?> note,
      Value<String> source,
      Value<String?> bloodTestId,
      Value<int> rowid,
    });

final class $$FeedSupplementsTemporaryTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FeedSupplementsTemporaryTable,
          FeedSupplementRow
        > {
  $$FeedSupplementsTemporaryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('feed_supplements_temporary__horse_id__horses__id');

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

  static $FeedItemsTable _itemIdTable(_$AppDatabase db) => db.feedItems
      .createAlias('feed_supplements_temporary__item_id__feed_items__id');

  $$FeedItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$FeedItemsTableTableManager(
      $_db,
      $_db.feedItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FeedSupplementsTemporaryTableFilterComposer
    extends Composer<_$AppDatabase, $FeedSupplementsTemporaryTable> {
  $$FeedSupplementsTemporaryTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get startDate =>
      $composableBuilder(
        column: $table.startDate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<LocalDate, LocalDate, String> get endDate =>
      $composableBuilder(
        column: $table.endDate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodTestId => $composableBuilder(
    column: $table.bloodTestId,
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

  $$FeedItemsTableFilterComposer get itemId {
    final $$FeedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.feedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedItemsTableFilterComposer(
            $db: $db,
            $table: $db.feedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedSupplementsTemporaryTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedSupplementsTemporaryTable> {
  $$FeedSupplementsTemporaryTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
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

  ColumnOrderings<String> get bloodTestId => $composableBuilder(
    column: $table.bloodTestId,
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

  $$FeedItemsTableOrderingComposer get itemId {
    final $$FeedItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.feedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedItemsTableOrderingComposer(
            $db: $db,
            $table: $db.feedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedSupplementsTemporaryTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedSupplementsTemporaryTable> {
  $$FeedSupplementsTemporaryTableAnnotationComposer({
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

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get mealName =>
      $composableBuilder(column: $table.mealName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalDate, String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get bloodTestId => $composableBuilder(
    column: $table.bloodTestId,
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

  $$FeedItemsTableAnnotationComposer get itemId {
    final $$FeedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.feedItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedSupplementsTemporaryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedSupplementsTemporaryTable,
          FeedSupplementRow,
          $$FeedSupplementsTemporaryTableFilterComposer,
          $$FeedSupplementsTemporaryTableOrderingComposer,
          $$FeedSupplementsTemporaryTableAnnotationComposer,
          $$FeedSupplementsTemporaryTableCreateCompanionBuilder,
          $$FeedSupplementsTemporaryTableUpdateCompanionBuilder,
          (FeedSupplementRow, $$FeedSupplementsTemporaryTableReferences),
          FeedSupplementRow,
          PrefetchHooks Function({bool horseId, bool itemId})
        > {
  $$FeedSupplementsTemporaryTableTableManager(
    _$AppDatabase db,
    $FeedSupplementsTemporaryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedSupplementsTemporaryTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$FeedSupplementsTemporaryTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FeedSupplementsTemporaryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String?> mealName = const Value.absent(),
                Value<LocalDate> startDate = const Value.absent(),
                Value<LocalDate> endDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> bloodTestId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedSupplementsTemporaryCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                itemId: itemId,
                amount: amount,
                mealName: mealName,
                startDate: startDate,
                endDate: endDate,
                note: note,
                source: source,
                bloodTestId: bloodTestId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String horseId,
                required String itemId,
                Value<double?> amount = const Value.absent(),
                Value<String?> mealName = const Value.absent(),
                required LocalDate startDate,
                required LocalDate endDate,
                Value<String?> note = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> bloodTestId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedSupplementsTemporaryCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                itemId: itemId,
                amount: amount,
                mealName: mealName,
                startDate: startDate,
                endDate: endDate,
                note: note,
                source: source,
                bloodTestId: bloodTestId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $FeedSupplementsTemporaryTable,
                    FeedSupplementRow
                  >(table),
                  $$FeedSupplementsTemporaryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({horseId = false, itemId = false}) {
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
                        referencedTable:
                            $$FeedSupplementsTemporaryTableReferences
                                ._horseIdTable(db),
                        referencedColumn:
                            $$FeedSupplementsTemporaryTableReferences
                                ._horseIdTable(db)
                                .id,
                      ) as T;
                    }
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable:
                            $$FeedSupplementsTemporaryTableReferences
                                ._itemIdTable(db),
                        referencedColumn:
                            $$FeedSupplementsTemporaryTableReferences
                                ._itemIdTable(db)
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

typedef $$FeedSupplementsTemporaryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedSupplementsTemporaryTable,
      FeedSupplementRow,
      $$FeedSupplementsTemporaryTableFilterComposer,
      $$FeedSupplementsTemporaryTableOrderingComposer,
      $$FeedSupplementsTemporaryTableAnnotationComposer,
      $$FeedSupplementsTemporaryTableCreateCompanionBuilder,
      $$FeedSupplementsTemporaryTableUpdateCompanionBuilder,
      (FeedSupplementRow, $$FeedSupplementsTemporaryTableReferences),
      FeedSupplementRow,
      PrefetchHooks Function({bool horseId, bool itemId})
    >;
typedef $$BloodTestsTableCreateCompanionBuilder = BloodTestsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String id,
  required String horseId,
  required LocalDate date,
  Value<String?> lab,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$BloodTestsTableUpdateCompanionBuilder = BloodTestsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> id,
  Value<String> horseId,
  Value<LocalDate> date,
  Value<String?> lab,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$BloodTestsTableReferences
    extends BaseReferences<_$AppDatabase, $BloodTestsTable, BloodTestRow> {
  $$BloodTestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HorsesTable _horseIdTable(_$AppDatabase db) =>
      db.horses.createAlias('blood_tests__horse_id__horses__id');

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

  static MultiTypedResultKey<$BloodValuesTable, List<BloodValueRow>>
  _bloodValuesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bloodValues,
    aliasName: 'blood_tests__id__blood_values__test_id',
  );

  $$BloodValuesTableProcessedTableManager get bloodValuesRefs {
    final manager = $$BloodValuesTableTableManager(
      $_db,
      $_db.bloodValues,
    ).filter((f) => f.testId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bloodValuesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BloodTestsTableFilterComposer
    extends Composer<_$AppDatabase, $BloodTestsTable> {
  $$BloodTestsTableFilterComposer({
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

  ColumnFilters<String> get lab => $composableBuilder(
    column: $table.lab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

  Expression<bool> bloodValuesRefs(
    Expression<bool> Function($$BloodValuesTableFilterComposer f) f,
  ) {
    final $$BloodValuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bloodValues,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BloodValuesTableFilterComposer(
            $db: $db,
            $table: $db.bloodValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BloodTestsTableOrderingComposer
    extends Composer<_$AppDatabase, $BloodTestsTable> {
  $$BloodTestsTableOrderingComposer({
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

  ColumnOrderings<String> get lab => $composableBuilder(
    column: $table.lab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$BloodTestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BloodTestsTable> {
  $$BloodTestsTableAnnotationComposer({
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

  GeneratedColumn<String> get lab =>
      $composableBuilder(column: $table.lab, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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

  Expression<T> bloodValuesRefs<T extends Object>(
    Expression<T> Function($$BloodValuesTableAnnotationComposer a) f,
  ) {
    final $$BloodValuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bloodValues,
      getReferencedColumn: (t) => t.testId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BloodValuesTableAnnotationComposer(
            $db: $db,
            $table: $db.bloodValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BloodTestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BloodTestsTable,
          BloodTestRow,
          $$BloodTestsTableFilterComposer,
          $$BloodTestsTableOrderingComposer,
          $$BloodTestsTableAnnotationComposer,
          $$BloodTestsTableCreateCompanionBuilder,
          $$BloodTestsTableUpdateCompanionBuilder,
          (BloodTestRow, $$BloodTestsTableReferences),
          BloodTestRow,
          PrefetchHooks Function({bool horseId, bool bloodValuesRefs})
        > {
  $$BloodTestsTableTableManager(_$AppDatabase db, $BloodTestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BloodTestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BloodTestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BloodTestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> horseId = const Value.absent(),
                Value<LocalDate> date = const Value.absent(),
                Value<String?> lab = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BloodTestsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                date: date,
                lab: lab,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String id,
                required String horseId,
                required LocalDate date,
                Value<String?> lab = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BloodTestsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                id: id,
                horseId: horseId,
                date: date,
                lab: lab,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BloodTestsTable, BloodTestRow>(table),
                  $$BloodTestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({horseId = false, bloodValuesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bloodValuesRefs) db.bloodValues],
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
                        referencedTable: $$BloodTestsTableReferences
                            ._horseIdTable(db),
                        referencedColumn: $$BloodTestsTableReferences
                            ._horseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bloodValuesRefs)
                    await $_getPrefetchedDataByColumns<
                      BloodTestRow,
                      $BloodTestsTable,
                      BloodValueRow,
                      $BloodValuesTable
                    >(
                      currentTable: table,
                      referencedTable: $$BloodTestsTableReferences
                          ._bloodValuesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BloodTestsTableReferences(
                            db,
                            table,
                            p0,
                          ).bloodValuesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'test_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BloodTestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BloodTestsTable,
      BloodTestRow,
      $$BloodTestsTableFilterComposer,
      $$BloodTestsTableOrderingComposer,
      $$BloodTestsTableAnnotationComposer,
      $$BloodTestsTableCreateCompanionBuilder,
      $$BloodTestsTableUpdateCompanionBuilder,
      (BloodTestRow, $$BloodTestsTableReferences),
      BloodTestRow,
      PrefetchHooks Function({bool horseId, bool bloodValuesRefs})
    >;
typedef $$BloodValuesTableCreateCompanionBuilder =
    BloodValuesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      required String testId,
      required String paramKey,
      required double value,
      Value<double?> refLow,
      Value<double?> refHigh,
      Value<int> rowid,
    });
typedef $$BloodValuesTableUpdateCompanionBuilder =
    BloodValuesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> testId,
      Value<String> paramKey,
      Value<double> value,
      Value<double?> refLow,
      Value<double?> refHigh,
      Value<int> rowid,
    });

final class $$BloodValuesTableReferences
    extends BaseReferences<_$AppDatabase, $BloodValuesTable, BloodValueRow> {
  $$BloodValuesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BloodTestsTable _testIdTable(_$AppDatabase db) =>
      db.bloodTests.createAlias('blood_values__test_id__blood_tests__id');

  $$BloodTestsTableProcessedTableManager get testId {
    final $_column = $_itemColumn<String>('test_id')!;

    final manager = $$BloodTestsTableTableManager(
      $_db,
      $_db.bloodTests,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BloodValuesTableFilterComposer
    extends Composer<_$AppDatabase, $BloodValuesTable> {
  $$BloodValuesTableFilterComposer({
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

  ColumnFilters<String> get paramKey => $composableBuilder(
    column: $table.paramKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refLow => $composableBuilder(
    column: $table.refLow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refHigh => $composableBuilder(
    column: $table.refHigh,
    builder: (column) => ColumnFilters(column),
  );

  $$BloodTestsTableFilterComposer get testId {
    final $$BloodTestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.bloodTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BloodTestsTableFilterComposer(
            $db: $db,
            $table: $db.bloodTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BloodValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $BloodValuesTable> {
  $$BloodValuesTableOrderingComposer({
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

  ColumnOrderings<String> get paramKey => $composableBuilder(
    column: $table.paramKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refLow => $composableBuilder(
    column: $table.refLow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refHigh => $composableBuilder(
    column: $table.refHigh,
    builder: (column) => ColumnOrderings(column),
  );

  $$BloodTestsTableOrderingComposer get testId {
    final $$BloodTestsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.bloodTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BloodTestsTableOrderingComposer(
            $db: $db,
            $table: $db.bloodTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BloodValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BloodValuesTable> {
  $$BloodValuesTableAnnotationComposer({
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

  GeneratedColumn<String> get paramKey =>
      $composableBuilder(column: $table.paramKey, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<double> get refLow =>
      $composableBuilder(column: $table.refLow, builder: (column) => column);

  GeneratedColumn<double> get refHigh =>
      $composableBuilder(column: $table.refHigh, builder: (column) => column);

  $$BloodTestsTableAnnotationComposer get testId {
    final $$BloodTestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.testId,
      referencedTable: $db.bloodTests,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BloodTestsTableAnnotationComposer(
            $db: $db,
            $table: $db.bloodTests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BloodValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BloodValuesTable,
          BloodValueRow,
          $$BloodValuesTableFilterComposer,
          $$BloodValuesTableOrderingComposer,
          $$BloodValuesTableAnnotationComposer,
          $$BloodValuesTableCreateCompanionBuilder,
          $$BloodValuesTableUpdateCompanionBuilder,
          (BloodValueRow, $$BloodValuesTableReferences),
          BloodValueRow,
          PrefetchHooks Function({bool testId})
        > {
  $$BloodValuesTableTableManager(_$AppDatabase db, $BloodValuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BloodValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BloodValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BloodValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> testId = const Value.absent(),
                Value<String> paramKey = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<double?> refLow = const Value.absent(),
                Value<double?> refHigh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BloodValuesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                testId: testId,
                paramKey: paramKey,
                value: value,
                refLow: refLow,
                refHigh: refHigh,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String testId,
                required String paramKey,
                required double value,
                Value<double?> refLow = const Value.absent(),
                Value<double?> refHigh = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BloodValuesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                testId: testId,
                paramKey: paramKey,
                value: value,
                refLow: refLow,
                refHigh: refHigh,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BloodValuesTable, BloodValueRow>(table),
                  $$BloodValuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({testId = false}) {
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
                    if (testId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.testId,
                        referencedTable: $$BloodValuesTableReferences
                            ._testIdTable(db),
                        referencedColumn: $$BloodValuesTableReferences
                            ._testIdTable(db)
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

typedef $$BloodValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BloodValuesTable,
      BloodValueRow,
      $$BloodValuesTableFilterComposer,
      $$BloodValuesTableOrderingComposer,
      $$BloodValuesTableAnnotationComposer,
      $$BloodValuesTableCreateCompanionBuilder,
      $$BloodValuesTableUpdateCompanionBuilder,
      (BloodValueRow, $$BloodValuesTableReferences),
      BloodValueRow,
      PrefetchHooks Function({bool testId})
    >;
typedef $$PhotoBlobsTableCreateCompanionBuilder = PhotoBlobsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  required String path,
  required Uint8List data,
  Value<int> rowid,
});
typedef $$PhotoBlobsTableUpdateCompanionBuilder = PhotoBlobsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> path,
  Value<Uint8List> data,
  Value<int> rowid,
});

class $$PhotoBlobsTableFilterComposer
    extends Composer<_$AppDatabase, $PhotoBlobsTable> {
  $$PhotoBlobsTableFilterComposer({
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

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotoBlobsTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotoBlobsTable> {
  $$PhotoBlobsTableOrderingComposer({
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

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotoBlobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotoBlobsTable> {
  $$PhotoBlobsTableAnnotationComposer({
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

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<Uint8List> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$PhotoBlobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotoBlobsTable,
          PhotoBlobRow,
          $$PhotoBlobsTableFilterComposer,
          $$PhotoBlobsTableOrderingComposer,
          $$PhotoBlobsTableAnnotationComposer,
          $$PhotoBlobsTableCreateCompanionBuilder,
          $$PhotoBlobsTableUpdateCompanionBuilder,
          (
            PhotoBlobRow,
            BaseReferences<_$AppDatabase, $PhotoBlobsTable, PhotoBlobRow>,
          ),
          PhotoBlobRow,
          PrefetchHooks Function()
        > {
  $$PhotoBlobsTableTableManager(_$AppDatabase db, $PhotoBlobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotoBlobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotoBlobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotoBlobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<Uint8List> data = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoBlobsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                path: path,
                data: data,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                required String path,
                required Uint8List data,
                Value<int> rowid = const Value.absent(),
              }) => PhotoBlobsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                path: path,
                data: data,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhotoBlobsTable, PhotoBlobRow>(table),
                  BaseReferences<_$AppDatabase, $PhotoBlobsTable, PhotoBlobRow>(
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

typedef $$PhotoBlobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotoBlobsTable,
      PhotoBlobRow,
      $$PhotoBlobsTableFilterComposer,
      $$PhotoBlobsTableOrderingComposer,
      $$PhotoBlobsTableAnnotationComposer,
      $$PhotoBlobsTableCreateCompanionBuilder,
      $$PhotoBlobsTableUpdateCompanionBuilder,
      (
        PhotoBlobRow,
        BaseReferences<_$AppDatabase, $PhotoBlobsTable, PhotoBlobRow>,
      ),
      PhotoBlobRow,
      PrefetchHooks Function()
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
  $$TrainingPlansTableTableManager get trainingPlans =>
      $$TrainingPlansTableTableManager(_db, _db.trainingPlans);
  $$TrainingSessionsTableTableManager get trainingSessions =>
      $$TrainingSessionsTableTableManager(_db, _db.trainingSessions);
  $$FeedItemsTableTableManager get feedItems =>
      $$FeedItemsTableTableManager(_db, _db.feedItems);
  $$FeedPlansTableTableManager get feedPlans =>
      $$FeedPlansTableTableManager(_db, _db.feedPlans);
  $$FeedMealsTableTableManager get feedMeals =>
      $$FeedMealsTableTableManager(_db, _db.feedMeals);
  $$FeedMealItemsTableTableManager get feedMealItems =>
      $$FeedMealItemsTableTableManager(_db, _db.feedMealItems);
  $$FeedSupplementsTemporaryTableTableManager get feedSupplementsTemporary =>
      $$FeedSupplementsTemporaryTableTableManager(
        _db,
        _db.feedSupplementsTemporary,
      );
  $$BloodTestsTableTableManager get bloodTests =>
      $$BloodTestsTableTableManager(_db, _db.bloodTests);
  $$BloodValuesTableTableManager get bloodValues =>
      $$BloodValuesTableTableManager(_db, _db.bloodValues);
  $$PhotoBlobsTableTableManager get photoBlobs =>
      $$PhotoBlobsTableTableManager(_db, _db.photoBlobs);
}
