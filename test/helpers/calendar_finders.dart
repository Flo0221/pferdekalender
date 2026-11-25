import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';

/// Tag [d] im Monatskalender. Das Raster zeigt auch Tage des Vor- und
/// Folgemonats (z. B. beginnt November 2026 mit dem 26.10.): hohe Zahlen
/// stehen zuerst als Vormonat, niedrige zuletzt als Folgemonat.
Finder dayCell(LocalDate d) {
  final all = find.text('${d.day}');
  return d.day > 15 ? all.last : all.first;
}
