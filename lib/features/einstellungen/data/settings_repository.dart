import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../domain/app_theme_mode.dart';
import '../domain/setting_keys.dart';

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Stream<String?> watchValue(String key) =>
      (_db.select(_db.settings)..where((s) => s.key.equals(key)))
          .watchSingleOrNull()
          .map((row) => row?.value);

  Future<String?> getValue(String key) async => (await (_db.select(
    _db.settings,
  )..where((s) => s.key.equals(key))).getSingleOrNull())?.value;

  Future<void> setValue(String key, String value) => _db
      .into(_db.settings)
      .insert(
        SettingsCompanion.insert(key: key, value: value),
        onConflict: DoUpdate(
          (_) => SettingsCompanion(
            value: Value(value),
            updatedAt: Value(DateTime.now()),
          ),
        ),
      );

  Stream<AppThemeMode> watchThemeMode() =>
      watchValue(SettingKeys.themeMode).map(AppThemeMode.fromKey);

  Future<void> setThemeMode(AppThemeMode mode) =>
      setValue(SettingKeys.themeMode, mode.name);
}
