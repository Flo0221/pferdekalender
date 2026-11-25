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
