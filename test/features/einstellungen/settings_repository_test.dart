import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/features/einstellungen/data/settings_repository.dart';
import 'package:pferdekalender/features/einstellungen/domain/app_theme_mode.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = SettingsRepository(db);
  });
  tearDown(() => db.close());

  test('Standard-Theme ist "wie System"', () async {
    expect(await repo.watchThemeMode().first, AppThemeMode.system);
  });

  test('Theme wird gespeichert und überschrieben', () async {
    await repo.setThemeMode(AppThemeMode.dark);
    expect(await repo.watchThemeMode().first, AppThemeMode.dark);
    await repo.setThemeMode(AppThemeMode.light);
    expect(await repo.watchThemeMode().first, AppThemeMode.light);
    expect(await db.select(db.settings).get(), hasLength(1));
  });

  test('unbekannter Wert fällt auf System zurück', () {
    expect(AppThemeMode.fromKey('lila'), AppThemeMode.system);
    expect(AppThemeMode.fromKey(null), AppThemeMode.system);
  });
}
