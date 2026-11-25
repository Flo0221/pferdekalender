import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

/// Liest die Unicode-Zeichen einer TrueType-Schrift (cmap Format 4 und 12).
Set<int> _codepoints(String path) {
  final b = ByteData.sublistView(File(path).readAsBytesSync());
  final numTables = b.getUint16(4);
  var cmap = -1;
  for (var i = 0; i < numTables; i++) {
    final rec = 12 + i * 16;
    final tag = String.fromCharCodes([
      for (var k = 0; k < 4; k++) b.getUint8(rec + k),
    ]);
    if (tag == 'cmap') cmap = b.getUint32(rec + 8);
  }
  final result = <int>{};
  final n = b.getUint16(cmap + 2);
  for (var i = 0; i < n; i++) {
    final sub = cmap + b.getUint32(cmap + 4 + i * 8 + 4);
    switch (b.getUint16(sub)) {
      case 4:
        final segX2 = b.getUint16(sub + 6);
        final ends = sub + 14;
        final starts = ends + segX2 + 2;
        for (var s = 0; s < segX2; s += 2) {
          final start = b.getUint16(starts + s);
          final end = b.getUint16(ends + s);
          for (var c = start; c <= end && c != 0xFFFF; c++) {
            result.add(c);
          }
        }
      case 12:
        final groups = b.getUint32(sub + 12);
        for (var g = 0; g < groups; g++) {
          final o = sub + 16 + g * 12;
          for (var c = b.getUint32(o); c <= b.getUint32(o + 4); c++) {
            result.add(c);
          }
        }
    }
  }
  return result;
}

void main() {
  test('Web: alle Zeichen der Oberfläche sind in den gebündelten Schriften '
      '(sonst lädt Flutter Ersatzschriften nach)', () {
    final covered = {
      ..._codepoints('assets/fonts/Roboto-Regular.ttf'),
      ..._codepoints('assets/fonts/PkSymbols.ttf'),
    };
    final files = [
      ...Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) => !f.path.contains('/generated/')),
      File('lib/l10n/app_de.arb'),
      File('assets/training_templates.json'),
      File('assets/blood_reference.json'),
    ];
    // Nur in Android-Benachrichtigungen (im Web abgeschaltet).
    const allowed = {'notificationBirthdayTitle'};
    final missing = <String>{};
    for (final f in files) {
      for (final line in f.readAsLinesSync()) {
        if (allowed.any(line.contains)) continue;
        for (final r in line.runes) {
          if (r > 127 && !covered.contains(r)) {
            missing.add('${String.fromCharCode(r)} in ${f.path}');
          }
        }
      }
    }
    expect(missing, isEmpty);
  });
}
