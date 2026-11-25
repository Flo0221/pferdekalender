import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database_provider.dart';
import '../../pferd/ui/horse_providers.dart';
import '../data/care_repository.dart';
import '../domain/care_event.dart';
import '../domain/care_type.dart';
import '../domain/interval_defaults.dart';

final careRepositoryProvider = Provider<CareRepository>(
  (ref) => CareRepository(ref.watch(databaseProvider)),
);

/// Aktive Eintragsarten (zum Anlegen).
final careTypesProvider = StreamProvider<List<CareType>>(
  (ref) => ref.watch(careRepositoryProvider).watchTypes(),
);

/// Alle Arten inkl. ausgeblendeter (zum Anzeigen alter Einträge, Einstellungen).
final allCareTypesProvider = StreamProvider<List<CareType>>(
  (ref) => ref.watch(careRepositoryProvider).watchTypes(includeArchived: true),
);

final careTypeMapProvider = Provider<Map<String, CareType>>((ref) {
  final types = ref.watch(allCareTypesProvider).value ?? const <CareType>[];
  return {for (final t in types) t.id: t};
});

final intervalDefaultsProvider = StreamProvider<List<IntervalDefault>>(
  (ref) => ref.watch(careRepositoryProvider).watchIntervalDefaults(),
);

/// Alle Einträge des ausgewählten Pferdes.
final selectedHorseCareEventsProvider = StreamProvider<List<CareEvent>>((ref) {
  final horse = ref.watch(selectedHorseProvider).value;
  if (horse == null) return Stream.value(const []);
  return ref.watch(careRepositoryProvider).watchEvents(horse.id);
});

/// Vorschläge für ein Feld (`person` oder ein `CareFields`-Schlüssel),
/// optional auf eine Eintragsart beschränkt.
final careSuggestionsProvider =
    FutureProvider.family<List<String>, (String, String?)>(
      (ref, key) =>
          ref.watch(careRepositoryProvider).suggestions(key.$1, typeId: key.$2),
    );
