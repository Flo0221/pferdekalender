import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database_provider.dart';
import '../../../core/time/local_date.dart';
import '../../dienstplan/domain/shift_logic.dart';
import '../../dienstplan/ui/shift_providers.dart';
import '../../einstellungen/domain/setting_keys.dart';
import '../../einstellungen/ui/settings_providers.dart';
import '../../pferd/ui/horse_providers.dart';
import '../data/training_repository.dart';
import '../domain/training.dart';
import '../domain/training_catalog.dart';
import '../domain/training_generator.dart';

final trainingRepositoryProvider = Provider<TrainingRepository>(
  (ref) => TrainingRepository(ref.watch(databaseProvider)),
);

/// Vorlagen aus `assets/training_templates.json` (in Tests überschreibbar).
final trainingCatalogProvider = FutureProvider<TrainingCatalog>((ref) async {
  final raw = await rootBundle.loadString('assets/training_templates.json');
  return TrainingCatalog.fromJson(
    (jsonDecode(raw) as Map).cast<String, Object?>(),
  );
});

final trainingGeneratorProvider = FutureProvider<TrainingGenerator>(
  (ref) async =>
      TrainingGenerator(await ref.watch(trainingCatalogProvider.future)),
);

/// Alle Einheiten des ausgewählten Pferdes.
final selectedHorseSessionsProvider = StreamProvider<List<TrainingSession>>((
  ref,
) {
  final horse = ref.watch(selectedHorseProvider).value;
  if (horse == null) return Stream.value(const []);
  return ref.watch(trainingRepositoryProvider).watchSessions(horse.id);
});

/// Aktiver Plan des ausgewählten Pferdes.
final activePlanProvider = StreamProvider<TrainingPlan?>((ref) {
  final horse = ref.watch(selectedHorseProvider).value;
  if (horse == null) return Stream.value(null);
  return ref.watch(trainingRepositoryProvider).watchActivePlan(horse.id);
});

/// `true`, wenn der Dienstplan nach der letzten Verteilung geändert wurde.
final shiftChangedSincePlanProvider = Provider<bool>((ref) {
  final plan = ref.watch(activePlanProvider).value;
  final changed = ref
      .watch(settingValueProvider(SettingKeys.shiftChangedAt))
      .value;
  if (plan == null || changed == null || plan.distributedAt == null) {
    return false;
  }
  final at = DateTime.tryParse(changed);
  if (at == null) return false;
  if (!plan.params.endDate.isAfter(LocalDate.today())) return false;
  return at.isAfter(plan.distributedAt!);
});

/// Verfügbarkeit laut Dienstplan für einen Zeitraum (einschließlich).
Future<Map<LocalDate, DayAvailability>> loadAvailability(
  Ref ref,
  LocalDate from,
  LocalDate to,
) async {
  final repo = ref.read(shiftRepositoryProvider);
  final days = await repo.getDays(from.addDays(-1), to);
  final templates = await repo.getTemplateMap();
  return {
    for (final a in availabilityFor(from, to, days, templates)) a.date: a,
  };
}

/// Für Widgets: dieselbe Funktion mit einem `WidgetRef`.
final availabilityLoaderProvider =
    Provider<
      Future<Map<LocalDate, DayAvailability>> Function(LocalDate, LocalDate)
    >(
      (ref) =>
          (from, to) => loadAvailability(ref, from, to),
    );
