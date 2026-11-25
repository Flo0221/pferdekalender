import 'package:drift/drift.dart';

import '../../../core/db/converters.dart';
import '../../../core/db/tables/common.dart';
import '../../pferd/data/horse_tables.dart';

@DataClassName('BloodTestRow')
class BloodTests extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();
  TextColumn get date => text().map(const LocalDateConverter())();
  TextColumn get lab => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('BloodValueRow')
class BloodValues extends Table with Timestamps {
  TextColumn get testId =>
      text().references(BloodTests, #id, onDelete: KeyAction.cascade)();

  /// Schlüssel aus `assets/blood_reference.json` (`parameters[].key`).
  TextColumn get paramKey => text()();
  RealColumn get value => real()();

  /// Eigener Referenzbereich vom Befund (optional).
  RealColumn get refLow => real().nullable()();
  RealColumn get refHigh => real().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {testId, paramKey};
}
