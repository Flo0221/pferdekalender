/// Ein Kalendertag ohne Uhrzeit und ohne Zeitzone.
///
/// Alle Termine der App werden als [LocalDate] gespeichert (in der Datenbank
/// als Text `YYYY-MM-DD`). Rechnungen laufen intern über UTC-Mitternacht,
/// damit sich Kalendertage bei Sommer-/Winterzeitumstellung nie verschieben.
///
/// Reines Dart, keine Abhängigkeit zu Flutter.
class LocalDate implements Comparable<LocalDate> {
  LocalDate(int year, int month, int day)
    : this._fromUtc(DateTime.utc(year, month, day));

  LocalDate._fromUtc(DateTime utc)
    : year = utc.year,
      month = utc.month,
      day = utc.day;

  /// Übernimmt nur Jahr/Monat/Tag aus [dateTime] (in dessen eigener Zone).
  factory LocalDate.fromDateTime(DateTime dateTime) =>
      LocalDate(dateTime.year, dateTime.month, dateTime.day);

  /// Heute laut Gerätezeit.
  factory LocalDate.today() => LocalDate.fromDateTime(DateTime.now());

  /// Parst `YYYY-MM-DD`. Wirft [FormatException] bei ungültigen Werten.
  factory LocalDate.parse(String iso) {
    final match = _isoPattern.firstMatch(iso);
    if (match == null) {
      throw FormatException('Ungültiges Datum (erwartet YYYY-MM-DD)', iso);
    }
    final y = int.parse(match.group(1)!);
    final m = int.parse(match.group(2)!);
    final d = int.parse(match.group(3)!);
    final result = LocalDate(y, m, d);
    if (result.year != y || result.month != m || result.day != d) {
      throw FormatException('Ungültiges Datum', iso);
    }
    return result;
  }

  static final _isoPattern = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');

  final int year;
  final int month;
  final int day;

  DateTime get _utc => DateTime.utc(year, month, day);

  /// 1 = Montag … 7 = Sonntag (ISO 8601, wie [DateTime.weekday]).
  int get weekday => _utc.weekday;

  /// Montag der Woche, in der dieser Tag liegt.
  LocalDate get startOfWeek => addDays(1 - weekday);

  LocalDate addDays(int days) =>
      LocalDate._fromUtc(_utc.add(Duration(days: days)));

  LocalDate addWeeks(int weeks) => addDays(weeks * 7);

  /// Addiert Monate. Gibt es den Tag im Zielmonat nicht (31.01. + 1 Monat),
  /// wird auf den letzten Tag des Monats begrenzt (28./29.02.).
  LocalDate addMonths(int months) {
    final totalMonths = year * 12 + (month - 1) + months;
    final y = totalMonths ~/ 12;
    final m = totalMonths % 12 + 1;
    final lastDay = DateTime.utc(y, m + 1, 0).day;
    return LocalDate(y, m, day > lastDay ? lastDay : day);
  }

  LocalDate addYears(int years) => addMonths(years * 12);

  /// Anzahl Tage von diesem Tag bis [other] (negativ, wenn [other] davor liegt).
  int daysUntil(LocalDate other) => other._utc.difference(_utc).inDays;

  bool isBefore(LocalDate other) => compareTo(other) < 0;
  bool isAfter(LocalDate other) => compareTo(other) > 0;

  /// Lokale Mitternacht dieses Tages (z. B. für Kalender-Widgets).
  DateTime toLocalDateTime() => DateTime(year, month, day);

  /// Lokaler Zeitpunkt an diesem Tag, [minutesOfDay] Minuten nach Mitternacht.
  DateTime atMinutes(int minutesOfDay) =>
      DateTime(year, month, day, minutesOfDay ~/ 60, minutesOfDay % 60);

  String toIso() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  @override
  int compareTo(LocalDate other) {
    if (year != other.year) return year.compareTo(other.year);
    if (month != other.month) return month.compareTo(other.month);
    return day.compareTo(other.day);
  }

  @override
  bool operator ==(Object other) =>
      other is LocalDate &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => toIso();
}
