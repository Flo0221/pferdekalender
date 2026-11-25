import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../domain/care_type.dart';
import '../domain/interval_defaults.dart';

/// Legt eingebaute Eintragsarten und Standard-Intervalle an, falls sie fehlen.
/// Vorhandene (vom Nutzer geänderte) Werte bleiben unangetastet.
Future<void> seedCareDefaults(AppDatabase db) async {
  await db.batch((b) {
    b.insertAll(db.careEventTypes, [
      for (final t in BuiltinCareTypes.all)
        CareEventTypesCompanion.insert(
          id: t.id,
          name: t.name,
          kind: t.kind.key,
          color: t.colorValue,
          icon: t.iconKey,
          builtin: const Value(true),
          sortOrder: Value(t.sortOrder),
        ),
    ], mode: InsertMode.insertOrIgnore);
    b.insertAll(db.careIntervalDefaults, [
      for (final d in defaultIntervals)
        CareIntervalDefaultsCompanion.insert(
          typeId: d.typeId,
          variantKey: Value(d.variantKey ?? ''),
          value: d.interval.value,
          unit: d.interval.unit.key,
        ),
    ], mode: InsertMode.insertOrIgnore);
  });
}
