import 'package:drift/drift.dart';

import '../../../core/db/converters.dart';
import '../../../core/db/tables/common.dart';
import '../../pferd/data/horse_tables.dart';

@DataClassName('FeedItemRow')
class FeedItems extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// Siehe `FeedCategory.key`.
  TextColumn get category => text()();

  /// Siehe `FeedUnit.key`.
  TextColumn get unit => text()();
  TextColumn get notes => text().nullable()();
  RealColumn get stock => real().nullable()();
  RealColumn get lowStockThreshold => real().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FeedPlanRow')
class FeedPlans extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get validFrom => text().map(const LocalDateConverter())();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FeedMealRow')
class FeedMeals extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get planId =>
      text().references(FeedPlans, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  IntColumn get timeMinutes => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FeedMealItemRow')
class FeedMealItems extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get mealId =>
      text().references(FeedMeals, #id, onDelete: KeyAction.cascade)();
  TextColumn get itemId => text().references(FeedItems, #id)();
  RealColumn get amount => real()();

  /// Siehe `FeedVariant.key` (always/training/rest).
  TextColumn get variant => text().withDefault(const Constant('always'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FeedSupplementRow')
class FeedSupplementsTemporary extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();
  TextColumn get itemId => text().references(FeedItems, #id)();

  /// `null` = laut Packungsangabe.
  RealColumn get amount => real().nullable()();

  /// Name der Mahlzeit (Pläne haben Versionen – daher kein Fremdschlüssel).
  TextColumn get mealName => text().nullable()();
  TextColumn get startDate => text().map(const LocalDateConverter())();
  TextColumn get endDate => text().map(const LocalDateConverter())();
  TextColumn get note => text().nullable()();

  /// Siehe `SupplementSource.key` (manual/blood).
  TextColumn get source => text().withDefault(const Constant('manual'))();

  /// Bezug zum Blutbild (ab Schema v7), ohne Fremdschlüssel.
  TextColumn get bloodTestId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
