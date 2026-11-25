/// Erinnerungs-Einstellungen. Reines Dart.
class ReminderSettings {
  const ReminderSettings({
    this.minutes = defaultMinutes,
    this.defaultOffsets = const [1],
    this.exact = false,
  });

  static const defaultMinutes = 9 * 60;

  /// Uhrzeit (Minuten seit Mitternacht).
  final int minutes;

  /// Vorbelegung für neue Pflegetermine (Tage vorher).
  final List<int> defaultOffsets;

  /// Pünktliche Alarme verwenden (braucht Systemberechtigung).
  final bool exact;

  static int parseMinutes(String? v) {
    final n = int.tryParse(v ?? '');
    return (n == null || n < 0 || n >= 24 * 60) ? defaultMinutes : n;
  }

  /// `null` (nie gesetzt) → Standard `[1]`; `""` → keine Vorbelegung.
  static List<int> parseOffsets(String? v) {
    if (v == null) return const [1];
    return (v
        .split(',')
        .map((s) => int.tryParse(s.trim()))
        .whereType<int>()
        .where((o) => o >= 0)
        .toSet()
        .toList()
      ..sort());
  }

  static String encodeOffsets(Iterable<int> offsets) =>
      (offsets.toSet().toList()..sort()).join(',');
}
