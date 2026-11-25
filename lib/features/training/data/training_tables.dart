import 'package:drift/drift.dart';

import '../../../core/db/converters.dart';
import '../../../core/db/tables/common.dart';
import '../../pferd/data/horse_tables.dart';

@DataClassName('TrainingPlanRow')
class TrainingPlans extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();

  /// Siehe `TrainingGoal.key` (zusätzlich in `params`, für Abfragen).
  TextColumn get goal => text()();

  /// `TrainingParams.toJson()`.
  TextColumn get params => text()();
  TextColumn get startDate => text().map(const LocalDateConverter())();
  IntColumn get weeks => integer()();

  /// `active` | `archived`
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get distributedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('TrainingSessionRow')
class TrainingSessions extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get planId => text().nullable().references(
    TrainingPlans,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();
  TextColumn get date => text().map(const LocalDateConverter())();

  /// Vorlage (`units[].key`), optional.
  TextColumn get templateKey => text().nullable()();

  /// Trainingsform (`forms[].key`), optional.
  TextColumn get form => text().nullable()();
  TextColumn get title => text()();
  IntColumn get level => integer()();
  IntColumn get durationMinutes => integer()();

  /// `SessionContent.toJson()`.
  TextColumn get content => text().withDefault(const Constant('{}'))();

  /// Siehe `SessionStatus.key`.
  TextColumn get status => text().withDefault(const Constant('planned'))();
  IntColumn get rating => integer().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();

  /// `SessionReason.toJson()`, optional.
  TextColumn get reason => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
