import '../../../core/time/local_date.dart';

/// Einheit eines Wiederholungsintervalls. Der [key] wird gespeichert.
enum IntervalUnit {
  days('days'),
  weeks('weeks'),
  months('months'),
  years('years');

  const IntervalUnit(this.key);
  final String key;

  static IntervalUnit? fromKey(String? key) {
    for (final u in values) {
      if (u.key == key) return u;
    }
    return null;
  }
}

/// „Wiederholen nach X Tagen/Wochen/Monaten/Jahren“.
class RepeatInterval {
  const RepeatInterval(this.value, this.unit) : assert(value > 0);

  final int value;
  final IntervalUnit unit;

  /// Erzeugt ein Intervall aus gespeicherten Werten; `null`, wenn unvollständig.
  static RepeatInterval? tryCreate(int? value, String? unitKey) {
    final unit = IntervalUnit.fromKey(unitKey);
    if (value == null || value <= 0 || unit == null) return null;
    return RepeatInterval(value, unit);
  }

  LocalDate addTo(LocalDate date) => switch (unit) {
    IntervalUnit.days => date.addDays(value),
    IntervalUnit.weeks => date.addWeeks(value),
    IntervalUnit.months => date.addMonths(value),
    IntervalUnit.years => date.addYears(value),
  };

  @override
  bool operator ==(Object other) =>
      other is RepeatInterval && other.value == value && other.unit == unit;

  @override
  int get hashCode => Object.hash(value, unit);

  @override
  String toString() => '$value ${unit.key}';
}
