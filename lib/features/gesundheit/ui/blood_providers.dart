import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database_provider.dart';
import '../../../core/format/formatters.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../pferd/ui/horse_providers.dart';
import '../data/blood_repository.dart';
import '../domain/blood.dart';
import '../domain/blood_evaluation.dart';

final bloodRepositoryProvider = Provider<BloodRepository>(
  (ref) => BloodRepository(ref.watch(databaseProvider)),
);

/// Referenzwerte + Regeln aus `assets/blood_reference.json` (in Tests
/// überschreibbar).
final bloodCatalogProvider = FutureProvider<BloodCatalog>((ref) async {
  final raw = await rootBundle.loadString('assets/blood_reference.json');
  return BloodCatalog.fromJson(
    (jsonDecode(raw) as Map).cast<String, Object?>(),
  );
});

/// Blutbilder eines Pferdes (neueste zuerst).
final bloodTestsProvider = StreamProvider.family<List<BloodTest>, String>(
  (ref, horseId) => ref.watch(bloodRepositoryProvider).watchTests(horseId),
);

final selectedHorseBloodTestsProvider = Provider<AsyncValue<List<BloodTest>>>((
  ref,
) {
  final horse = ref.watch(selectedHorseProvider).value;
  if (horse == null) return const AsyncData([]);
  return ref.watch(bloodTestsProvider(horse.id));
});

/// Kurzinfo für die Gesundheits-Karte im Pferde-Profil.
String healthSummaryText(
  AppLocalizations l10n,
  BloodTest? latest,
  BloodCatalog? catalog,
) {
  if (latest == null) return l10n.healthNoTest;
  if (catalog == null) return Fmt.date(latest.date);
  final e = evaluate(latest, catalog);
  return e.summary.isEmpty
      ? l10n.healthAllInRange(Fmt.date(latest.date))
      : l10n.healthSummary(Fmt.date(latest.date), e.summary.join(' · '));
}

String rangeText(AppLocalizations l10n, double? low, double? high) {
  if (low != null && high != null) {
    return l10n.bloodRangeBetween(Fmt.decimal(low), Fmt.decimal(high));
  }
  if (high != null) return l10n.bloodRangeBelow(Fmt.decimal(high));
  if (low != null) return l10n.bloodRangeAbove(Fmt.decimal(low));
  return '–';
}

String statusText(AppLocalizations l10n, ValueFinding f) =>
    switch ((f.direction, f.strong)) {
      (Direction.high, true) => l10n.bloodStatusStrongHigh,
      (Direction.high, false) => l10n.bloodStatusHigh,
      (Direction.low, true) => l10n.bloodStatusStrongLow,
      (Direction.low, false) => l10n.bloodStatusLow,
      (null, _) => l10n.bloodStatusOk,
    };
