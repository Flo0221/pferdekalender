import '../../../core/time/local_date.dart';
import 'repeat_interval.dart';

/// Schlüssel der typspezifischen Felder in [CareEvent.fields].
/// Nie umbenennen – stehen in der Datenbank und in Backups.
abstract final class CareFields {
  static const praeparat = 'praeparat';
  static const wirkstoff = 'wirkstoff';
  static const dosierung = 'dosierung';
  static const labor = 'labor';
  static const epg = 'epg';
  static const ergebnis = 'ergebnis';
  static const impfungName = 'impfung_name';
  static const impfstoff = 'impfstoff';
  static const grundimmunisierung = 'grundimmunisierung';
}

/// Ein Eintrag im Pflege-Kalender (geplant oder erledigt).
class CareEvent {
  const CareEvent({
    required this.id,
    required this.horseId,
    required this.typeId,
    required this.date,
    this.timeMinutes,
    this.done = false,
    this.variantKey,
    this.title,
    this.person,
    this.costCents,
    this.notes,
    this.fields = const {},
    this.repeat,
    this.parentEventId,
    this.seriesId,
    this.reminderOffsets = const [],
  });

  final String id;
  final String horseId;
  final String typeId;
  final LocalDate date;

  /// Uhrzeit als Minuten seit Mitternacht, optional.
  final int? timeMinutes;
  final bool done;
  final String? variantKey;
  final String? title;

  /// Hufschmied, Tierarzt, Labor … (Freitext).
  final String? person;
  final int? costCents;
  final String? notes;

  /// Typspezifische Felder, siehe [CareFields]. Werte: String, int oder bool.
  final Map<String, Object> fields;
  final RepeatInterval? repeat;

  /// Der Eintrag, aus dem dieser Folgetermin entstanden ist.
  final String? parentEventId;

  /// Verbindet alle Termine einer Wiederholungskette.
  final String? seriesId;

  /// Erinnerungen: Tage vorher (0 = am Tag). Sortiert, ohne Duplikate.
  final List<int> reminderOffsets;

  bool isOverdue(LocalDate today) => !done && date.isBefore(today);

  CareEvent copyWith({
    String? id,
    LocalDate? date,
    bool? done,
    String? parentEventId,
    String? seriesId,
    bool clearTime = false,
    bool clearCost = false,
  }) => CareEvent(
    id: id ?? this.id,
    horseId: horseId,
    typeId: typeId,
    date: date ?? this.date,
    timeMinutes: clearTime ? null : timeMinutes,
    done: done ?? this.done,
    variantKey: variantKey,
    title: title,
    person: person,
    costCents: clearCost ? null : costCents,
    notes: notes,
    fields: fields,
    repeat: repeat,
    parentEventId: parentEventId ?? this.parentEventId,
    seriesId: seriesId ?? this.seriesId,
    reminderOffsets: reminderOffsets,
  );
}
