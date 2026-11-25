import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../futter/data/feed_repository.dart';
import '../../futter/domain/feed.dart';
import '../../futter/domain/feed_logic.dart';
import '../../pflege/data/care_repository.dart';
import '../../pflege/domain/care_event.dart';
import '../domain/blood.dart';

/// Ergebnis der Übernahme.
class ApplyResult {
  const ApplyResult(this.supplements, this.events, this.notes);
  final int supplements;
  final int events;
  final int notes;
}

/// Übernimmt ausgewählte Bausteine eines Blutbilds:
/// - Futter-Zusätze → zeitlich begrenzte Zusätze ab [today] (Menge laut
///   Packungsangabe), Futtermittel werden bei Bedarf angelegt.
/// - Termine → Pflege-Kalender (Tierarzt, Kotprobe, Kontroll-Blutbild).
/// - Fütterungs-/Haltungshinweise → Notiz der aktuellen Futterplan-Version.
Future<ApplyResult> applyBloodSuggestions({
  required AppLocalizations l10n,
  required BloodTest test,
  required List<BloodSuggestion> selected,
  required int? controlWeeks,
  required FeedRepository feed,
  required CareRepository care,
  required LocalDate today,
}) async {
  var supplements = 0, events = 0, notes = 0;
  final noteLines = <String>[];
  for (final s in selected) {
    switch (s.kind) {
      case SuggestionKind.supplement:
        if (s.itemName == null) continue;
        final itemId = await feed.findOrCreateItem(
          FeedItem(
            id: '',
            name: s.itemName!,
            category: FeedCategory.fromKey(s.itemCategory),
            unit: FeedUnit.fromKey(s.itemUnit),
            notes: s.text,
          ),
        );
        final weeks = s.weeks ?? 6;
        await feed.saveSupplement(
          TemporarySupplement(
            id: '',
            horseId: test.horseId,
            itemId: itemId,
            start: today,
            end: today.addWeeks(weeks).addDays(-1),
            note: s.title,
            source: SupplementSource.bloodTest,
            bloodTestId: test.id,
          ),
        );
        supplements++;
      case SuggestionKind.care:
        if (s.careType == null) continue;
        final days = s.key == 'kontrolle'
            ? (controlWeeks ?? 6) * 7
            : (s.inDays ?? 7);
        await care.saveEvent(
          CareEvent(
            id: '',
            horseId: test.horseId,
            typeId: s.careType!,
            date: today.addDays(days),
            title: s.careTitle ?? s.title,
            notes: s.text,
            reminderOffsets: const [1],
          ),
        );
        events++;
      case SuggestionKind.ration:
      case SuggestionKind.management:
        noteLines.add(l10n.bloodPlanNoteLine(Fmt.date(test.date), s.title));
        notes++;
    }
  }
  if (noteLines.isNotEmpty) {
    final plans = await feed.getPlans(test.horseId);
    final current = planOn(plans, today);
    if (current != null) {
      final existing = current.notes?.trim();
      await feed.savePlan(
        FeedPlan(
          id: current.id,
          horseId: current.horseId,
          name: current.name,
          validFrom: current.validFrom,
          notes: [
            ?(existing == null || existing.isEmpty ? null : existing),
            ...noteLines,
          ].join('\n'),
          meals: current.meals,
        ),
      );
    } else {
      notes = 0; // ohne Futterplan gibt es keine Notiz
    }
  }
  return ApplyResult(supplements, events, notes);
}
