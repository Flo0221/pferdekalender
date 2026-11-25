import 'dart:convert';

import '../../../core/time/local_date.dart';

/// Ein Termin für den Kalender-Export (RFC 5545). Reines Dart.
class IcsEvent {
  const IcsEvent({
    required this.uid,
    required this.date,
    required this.summary,
    this.startMinutes,
    this.durationMinutes = 60,
    this.description,
    this.alarmOffsetsDays = const [],
  });

  /// Stabil je Eintrag (z. B. `care-<id>@pferdekalender`), damit ein erneuter
  /// Import den Termin aktualisiert statt ihn zu verdoppeln.
  final String uid;
  final LocalDate date;

  /// Uhrzeit (Minuten seit Mitternacht); `null` = ganztägig.
  final int? startMinutes;
  final int durationMinutes;
  final String summary;
  final String? description;

  /// Erinnerungen „Tage vorher“ (0 = am Tag), wie in der App.
  final List<int> alarmOffsetsDays;
}

/// Zeitpunkt einer Erinnerung relativ zum Terminbeginn in Minuten –
/// dieselbe Regel wie bei den Android-Benachrichtigungen:
/// [reminderMinutes] am Tag `Datum − Offset`; am Termintag mit Uhrzeit vor
/// der Erinnerungszeit 60 Minuten vorher.
int alarmTriggerMinutes({
  required int offsetDays,
  required int reminderMinutes,
  int? startMinutes,
}) {
  final start = startMinutes ?? 0;
  if (offsetDays == 0 &&
      startMinutes != null &&
      startMinutes < reminderMinutes) {
    return -60;
  }
  return -offsetDays * 24 * 60 + reminderMinutes - start;
}

/// RFC-5545-Dauer, z. B. `-P1DT15H`, `PT9H`, `-PT1H30M`, `PT0M`.
String icsDuration(int minutes) {
  final sign = minutes < 0 ? '-' : '';
  var m = minutes.abs();
  final days = m ~/ (24 * 60);
  m %= 24 * 60;
  final hours = m ~/ 60;
  final mins = m % 60;
  final b = StringBuffer('${sign}P');
  if (days > 0) b.write('${days}D');
  if (hours > 0 || mins > 0 || days == 0) {
    b.write('T');
    if (hours > 0) b.write('${hours}H');
    if (mins > 0 || hours == 0) b.write('${mins}M');
  }
  return b.toString();
}

/// Text-Werte escapen (Backslash, Semikolon, Komma, Zeilenumbruch).
String icsEscape(String v) => v
    .replaceAll(r'\', r'\\')
    .replaceAll(';', r'\;')
    .replaceAll(',', r'\,')
    .replaceAll('\r\n', r'\n')
    .replaceAll('\n', r'\n');

/// Zeilen auf 75 Byte falten (UTF-8, ohne Zeichen zu zerteilen).
String icsFold(String line) {
  final out = StringBuffer();
  var bytes = 0;
  for (final rune in line.runes) {
    final ch = String.fromCharCode(rune);
    final len = utf8.encode(ch).length;
    if (bytes + len > 75) {
      out.write('\r\n ');
      bytes = 1;
    }
    out.write(ch);
    bytes += len;
  }
  return out.toString();
}

String _two(int n) => n.toString().padLeft(2, '0');
String _date(LocalDate d) =>
    '${d.year.toString().padLeft(4, '0')}${_two(d.month)}${_two(d.day)}';
String _localDateTime(LocalDate d, int minutes) =>
    '${_date(d)}T${_two(minutes ~/ 60)}${_two(minutes % 60)}00';
String _utcStamp(DateTime t) {
  final u = t.toUtc();
  return '${u.year.toString().padLeft(4, '0')}${_two(u.month)}${_two(u.day)}'
      'T${_two(u.hour)}${_two(u.minute)}${_two(u.second)}Z';
}

const icsTimeZone = 'Europe/Berlin';

const _vTimeZone = [
  'BEGIN:VTIMEZONE',
  'TZID:$icsTimeZone',
  'BEGIN:DAYLIGHT',
  'TZOFFSETFROM:+0100',
  'TZOFFSETTO:+0200',
  'TZNAME:CEST',
  'DTSTART:19700329T020000',
  'RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU',
  'END:DAYLIGHT',
  'BEGIN:STANDARD',
  'TZOFFSETFROM:+0200',
  'TZOFFSETTO:+0100',
  'TZNAME:CET',
  'DTSTART:19701025T030000',
  'RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU',
  'END:STANDARD',
  'END:VTIMEZONE',
];

/// Baut eine .ics-Datei (CRLF, gefaltet). Uhrzeiten in Europe/Berlin,
/// ganztägige Termine als DATE. [now] für DTSTAMP.
String buildIcs(
  List<IcsEvent> events, {
  required int reminderMinutes,
  required DateTime now,
  required String alarmText,
  String calendarName = 'Pferdekalender',
}) {
  final lines = <String>[
    'BEGIN:VCALENDAR',
    'VERSION:2.0',
    'PRODID:-//Pferdekalender//DE',
    'CALSCALE:GREGORIAN',
    'METHOD:PUBLISH',
    'X-WR-CALNAME:${icsEscape(calendarName)}',
    if (events.any((e) => e.startMinutes != null)) ..._vTimeZone,
  ];
  final stamp = _utcStamp(now);
  for (final e in events) {
    lines
      ..add('BEGIN:VEVENT')
      ..add('UID:${icsEscape(e.uid)}')
      ..add('DTSTAMP:$stamp');
    if (e.startMinutes case final start?) {
      final end = e.date
          .atMinutes(start)
          .add(Duration(minutes: e.durationMinutes));
      final endDate = LocalDate.fromDateTime(end);
      lines
        ..add('DTSTART;TZID=$icsTimeZone:${_localDateTime(e.date, start)}')
        ..add(
          'DTEND;TZID=$icsTimeZone:'
          '${_localDateTime(endDate, end.hour * 60 + end.minute)}',
        );
    } else {
      lines
        ..add('DTSTART;VALUE=DATE:${_date(e.date)}')
        ..add('DTEND;VALUE=DATE:${_date(e.date.addDays(1))}')
        ..add('TRANSP:TRANSPARENT');
    }
    lines.add('SUMMARY:${icsEscape(e.summary)}');
    if (e.description case final d? when d.trim().isNotEmpty) {
      lines.add('DESCRIPTION:${icsEscape(d.trim())}');
    }
    for (final offset in {...e.alarmOffsetsDays}) {
      final trigger = alarmTriggerMinutes(
        offsetDays: offset,
        reminderMinutes: reminderMinutes,
        startMinutes: e.startMinutes,
      );
      lines.addAll([
        'BEGIN:VALARM',
        'ACTION:DISPLAY',
        'DESCRIPTION:${icsEscape(alarmText.isEmpty ? e.summary : alarmText)}',
        'TRIGGER:${icsDuration(trigger)}',
        'END:VALARM',
      ]);
    }
    lines.add('END:VEVENT');
  }
  lines.add('END:VCALENDAR');
  return '${lines.map(icsFold).join('\r\n')}\r\n';
}

/// Stabile UID eines Pflegetermins.
String careEventUid(String eventId) => 'care-$eventId@pferdekalender';

/// Dateiname, z. B. `pferdekalender-termine-2026-11-25.ics`.
String icsFileName(LocalDate today, {String kind = 'termine'}) =>
    'pferdekalender-$kind-${today.toIso()}.ics';
