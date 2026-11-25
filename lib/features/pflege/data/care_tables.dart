import 'package:drift/drift.dart';

import '../../../core/db/converters.dart';
import '../../../core/db/tables/common.dart';
import '../../pferd/data/horse_tables.dart';

@DataClassName('CareTypeRow')
class CareEventTypes extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// Siehe `CareKind.key` – bestimmt das Formular.
  TextColumn get kind => text()();
  IntColumn get color => integer()();
  TextColumn get icon => text()();
  BoolColumn get builtin => boolean().withDefault(const Constant(false))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CareIntervalDefaultRow')
class CareIntervalDefaults extends Table with Timestamps {
  TextColumn get typeId =>
      text().references(CareEventTypes, #id, onDelete: KeyAction.cascade)();

  /// Leerer Text = gilt für die Art ohne bestimmte Variante.
  /// `value` 0 = „kein Vorschlag“ (Startwerte werden sonst neu ergänzt).
  TextColumn get variantKey => text().withDefault(const Constant(''))();
  IntColumn get value => integer()();

  /// Siehe `IntervalUnit.key`.
  TextColumn get unit => text()();

  @override
  Set<Column<Object>> get primaryKey => {typeId, variantKey};
}

@DataClassName('CareEventRow')
class CareEvents extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();
  TextColumn get typeId => text().references(CareEventTypes, #id)();
  TextColumn get date => text().map(const LocalDateConverter())();
  IntColumn get timeMinutes => integer().nullable()();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
  TextColumn get variantKey => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get person => text().nullable()();
  IntColumn get costCents => integer().nullable()();
  TextColumn get notes => text().nullable()();

  /// Typspezifische Felder als JSON-Objekt (siehe `CareFields`).
  TextColumn get fields => text().withDefault(const Constant('{}'))();
  IntColumn get repeatValue => integer().nullable()();
  TextColumn get repeatUnit => text().nullable()();

  /// Kein Fremdschlüssel: Löschen eines Eintrags lässt Folgetermine bestehen.
  TextColumn get parentEventId => text().nullable()();
  TextColumn get seriesId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CareReminderRow')
class CareReminders extends Table with Timestamps {
  TextColumn get eventId =>
      text().references(CareEvents, #id, onDelete: KeyAction.cascade)();

  /// Tage vor dem Termin (0 = am Tag).
  IntColumn get offsetDays => integer()();

  @override
  Set<Column<Object>> get primaryKey => {eventId, offsetDays};
}
