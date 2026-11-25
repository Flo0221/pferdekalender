import 'package:intl/intl.dart';

import '../time/local_date.dart';

/// Deutsche Anzeigeformate an einer Stelle.
abstract final class Fmt {
  static final _date = DateFormat('dd.MM.yyyy', 'de_DE');
  static final _dateShort = DateFormat('dd.MM.', 'de_DE');
  static final _decimal = NumberFormat('#,##0.#', 'de_DE');

  static String date(LocalDate d) => _date.format(d.toLocalDateTime());
  static String dateShort(LocalDate d) =>
      _dateShort.format(d.toLocalDateTime());
  static String decimal(num value) => _decimal.format(value);
  static final _money = NumberFormat('#,##0.00', 'de_DE');

  /// 1250 → „12,50“.
  static String money(int cents) => _money.format(cents / 100);

  /// Dauer → „1 h 30 min“, „45 min“, „2 h“.
  static String duration(int minutes) {
    final h = minutes ~/ 60, m = minutes % 60;
    if (h == 0) return '$m min';
    return m == 0 ? '$h h' : '$h h $m min';
  }

  /// Minuten seit Mitternacht → „07:30“.
  static String time(int minutes) =>
      '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
      '${(minutes % 60).toString().padLeft(2, '0')}';

  /// „12,50“ / „12.5“ / „12“ → Cent; `null` bei ungültiger Eingabe.
  static int? parseMoneyCents(String input) {
    final v = parseDecimal(input);
    return v == null ? null : (v * 100).round();
  }

  /// Parst deutsche Zahleneingaben („550,5“, „550.5“, „ 550 “).
  /// Gibt `null` zurück, wenn die Eingabe keine Zahl ist.
  static double? parseDecimal(String input) {
    final t = input.trim().replaceAll(' ', '');
    if (t.isEmpty) return null;
    // „1.234,5“ → „1234.5“; „550.5“ bleibt „550.5“.
    final normalized = t.contains(',')
        ? t.replaceAll('.', '').replaceAll(',', '.')
        : t;
    return double.tryParse(normalized);
  }
}
