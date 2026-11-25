import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database_provider.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../data/shift_repository.dart';
import '../domain/shift.dart';

final shiftRepositoryProvider = Provider<ShiftRepository>(
  (ref) => ShiftRepository(ref.watch(databaseProvider)),
);

/// Aktive Vorlagen (zum Eintragen).
final shiftTemplatesProvider = StreamProvider<List<ShiftTemplate>>(
  (ref) => ref.watch(shiftRepositoryProvider).watchTemplates(),
);

/// Alle Vorlagen inkl. ausgeblendeter (zum Anzeigen vorhandener Tage).
final shiftTemplateMapProvider = StreamProvider<Map<String, ShiftTemplate>>(
  (ref) => ref
      .watch(shiftRepositoryProvider)
      .watchTemplates(includeArchived: true)
      .map((list) => {for (final t in list) t.id: t}),
);

/// Dienstplan-Tage im Zeitraum (von, bis – einschließlich).
final shiftDaysProvider =
    StreamProvider.family<Map<LocalDate, ShiftDay>, (LocalDate, LocalDate)>(
      (ref, range) =>
          ref.watch(shiftRepositoryProvider).watchDays(range.$1, range.$2),
    );

final shiftPatternsProvider = StreamProvider<List<ShiftPattern>>(
  (ref) => ref.watch(shiftRepositoryProvider).watchPatterns(),
);

String dayTimeLabel(AppLocalizations l10n, DayTime t) => switch (t) {
  DayTime.morgens => l10n.dayTime_morgens,
  DayTime.nachmittags => l10n.dayTime_nachmittags,
  DayTime.abends => l10n.dayTime_abends,
};
