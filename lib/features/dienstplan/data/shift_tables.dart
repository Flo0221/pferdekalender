import 'package:drift/drift.dart';

import '../../../core/db/converters.dart';
import '../../../core/db/tables/common.dart';

@DataClassName('ShiftTemplateRow')
class ShiftTemplates extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get shortCode => text()();
  IntColumn get color => integer()();
  IntColumn get startMinutes => integer().nullable()();
  IntColumn get endMinutes => integer().nullable()();

  /// Stallzeit an diesem Tag (Minuten).
  IntColumn get stableMinutes => integer()();

  /// Siehe `DayTime.key`.
  TextColumn get preferredTime => text().nullable()();
  BoolColumn get isNight => boolean().withDefault(const Constant(false))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ShiftPatternRow')
class ShiftPatterns extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// JSON-Liste von Vorlagen-IDs bzw. `null` (Tag ohne Schicht).
  TextColumn get steps => text()();
  TextColumn get startDate => text().map(const LocalDateConverter())();
  IntColumn get weeks => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ShiftDayRow')
class ShiftDays extends Table with Timestamps {
  /// Ein Eintrag pro Kalendertag.
  TextColumn get date => text().map(const LocalDateConverter())();
  TextColumn get templateId => text().nullable().references(
    ShiftTemplates,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get overrideMinutes => integer().nullable()();
  BoolColumn get otherPersonCovers =>
      boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();

  /// Siehe `ShiftSource.key`.
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get patternId => text().nullable().references(
    ShiftPatterns,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  Set<Column<Object>> get primaryKey => {date};
}
