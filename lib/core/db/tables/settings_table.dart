import 'package:drift/drift.dart';

import 'common.dart';

/// Einfache Schlüssel/Wert-Einstellungen (z. B. Theme, Puffer-Minuten).
@DataClassName('SettingRow')
class Settings extends Table with Timestamps {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
