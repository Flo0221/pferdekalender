import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database_provider.dart';
import '../../../core/time/local_date.dart';
import '../../pferd/ui/horse_providers.dart';
import '../../training/domain/training.dart';
import '../../training/ui/training_providers.dart';
import '../data/feed_repository.dart';
import '../domain/feed.dart';

final feedRepositoryProvider = Provider<FeedRepository>(
  (ref) => FeedRepository(ref.watch(databaseProvider)),
);

final feedItemsProvider = StreamProvider<List<FeedItem>>(
  (ref) => ref.watch(feedRepositoryProvider).watchItems(),
);

/// Alle Futtermittel inkl. archivierter als Map (zur Anzeige alter Pläne).
final feedItemMapProvider = StreamProvider<Map<String, FeedItem>>(
  (ref) => ref
      .watch(feedRepositoryProvider)
      .watchItems(includeArchived: true)
      .map((l) => {for (final i in l) i.id: i}),
);

/// Planversionen des ausgewählten Pferdes (neueste zuerst).
final selectedHorseFeedPlansProvider = StreamProvider<List<FeedPlan>>((ref) {
  final horse = ref.watch(selectedHorseProvider).value;
  if (horse == null) return Stream.value(const []);
  return ref.watch(feedRepositoryProvider).watchPlans(horse.id);
});

final selectedHorseSupplementsProvider =
    StreamProvider<List<TemporarySupplement>>((ref) {
      final horse = ref.watch(selectedHorseProvider).value;
      if (horse == null) return Stream.value(const []);
      return ref.watch(feedRepositoryProvider).watchSupplements(horse.id);
    });

/// Trainingstag = mindestens eine nicht ausgefallene Einheit ab Stufe 2.
final trainingDaysProvider = Provider<Set<LocalDate>>((ref) {
  final sessions = ref.watch(selectedHorseSessionsProvider).value ?? const [];
  return {
    for (final s in sessions)
      if (s.level >= 2 && s.status != SessionStatus.cancelled) s.date,
  };
});
