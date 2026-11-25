import '../../../core/time/local_date.dart';
import 'care_event.dart';

/// Was mit dem Folgetermin eines Eintrags passieren soll.
sealed class FollowUpAction {
  const FollowUpAction();
}

/// Nichts tun.
class FollowUpNone extends FollowUpAction {
  const FollowUpNone();
}

/// Neuen geplanten Folgetermin an [date] anlegen.
class FollowUpCreate extends FollowUpAction {
  const FollowUpCreate(this.date);
  final LocalDate date;
}

/// Vorhandenen (noch nicht erledigten) Folgetermin auf [date] verschieben.
class FollowUpMove extends FollowUpAction {
  const FollowUpMove(this.followUpId, this.date);
  final String followUpId;
  final LocalDate date;
}

/// Vorhandenen (noch nicht erledigten) Folgetermin löschen, weil keine
/// Wiederholung mehr eingestellt ist.
class FollowUpDelete extends FollowUpAction {
  const FollowUpDelete(this.followUpId);
  final String followUpId;
}

/// Bestimmt nach dem Speichern von [event], wie sein Folgetermin aussehen muss.
///
/// - Mit Wiederholung und ohne Folgetermin → anlegen (Datum + Intervall),
///   aber nur, wenn der Eintrag erledigt ist oder selbst kein Folgetermin ist.
///   So läuft eine Kette nie mehr als einen Termin voraus.
/// - Mit Wiederholung und offenem Folgetermin → nur verschieben, wenn
///   [recalculate] gesetzt ist (Nutzer hat zugestimmt bzw. Intervall/Datum
///   wurde geändert).
/// - Ohne Wiederholung und offener Folgetermin → löschen.
/// - Ein bereits erledigter Folgetermin wird nie angefasst.
FollowUpAction planFollowUp(
  CareEvent event,
  CareEvent? existingFollowUp, {
  required bool recalculate,
}) {
  final repeat = event.repeat;
  final openFollowUp = (existingFollowUp != null && !existingFollowUp.done)
      ? existingFollowUp
      : null;

  if (repeat == null) {
    return openFollowUp == null
        ? const FollowUpNone()
        : FollowUpDelete(openFollowUp.id);
  }
  final target = repeat.addTo(event.date);
  if (existingFollowUp == null) {
    final mayCreate = event.done || event.parentEventId == null;
    return mayCreate ? FollowUpCreate(target) : const FollowUpNone();
  }
  if (openFollowUp == null || !recalculate || openFollowUp.date == target) {
    return const FollowUpNone();
  }
  return FollowUpMove(openFollowUp.id, target);
}

/// Erzeugt den Folgetermin zu [event] (ohne ID): gleiche Art, Variante,
/// Person, Felder, Wiederholung und Erinnerungen, aber offen und ohne Kosten.
CareEvent buildFollowUp(CareEvent event, LocalDate date, String newId) =>
    event.copyWith(
      id: newId,
      date: date,
      done: false,
      parentEventId: event.id,
      seriesId: event.seriesId ?? event.id,
      clearCost: true,
    );

/// Sortierung für „Anstehend“: überfällige zuerst (älteste oben), dann nach
/// Datum und Uhrzeit. Erledigte Einträge werden herausgefiltert.
List<CareEvent> upcomingSorted(Iterable<CareEvent> events) {
  final open = events.where((e) => !e.done).toList()
    ..sort((a, b) {
      final byDate = a.date.compareTo(b.date);
      if (byDate != 0) return byDate;
      return (a.timeMinutes ?? -1).compareTo(b.timeMinutes ?? -1);
    });
  return open;
}

/// Sortierung für „Historie“: erledigte Einträge, neueste zuerst, optional
/// gefiltert nach Art.
List<CareEvent> historySorted(Iterable<CareEvent> events, {String? typeId}) =>
    events
        .where((e) => e.done && (typeId == null || e.typeId == typeId))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

/// Eindeutige, nicht leere Vorschläge (neueste zuerst) für Autovervollständigung.
List<String> distinctSuggestions(Iterable<String?> valuesNewestFirst) {
  final seen = <String>{};
  final result = <String>[];
  for (final v in valuesNewestFirst) {
    final t = v?.trim();
    if (t == null || t.isEmpty) continue;
    if (seen.add(t.toLowerCase())) result.add(t);
  }
  return result;
}

/// Bereinigt Erinnerungs-Offsets: nicht negativ, sortiert, ohne Duplikate.
List<int> normalizeOffsets(Iterable<int> offsets) =>
    (offsets.where((o) => o >= 0).toSet().toList()..sort());
