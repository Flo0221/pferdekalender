import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Geschäftslogik (domain/ und core/time/) darf nichts von Flutter wissen,
/// damit sie plattformunabhängig und rein testbar bleibt.
void main() {
  test('domain-Ordner importieren weder Flutter noch Material', () {
    final forbidden = RegExp(
      r'''import\s+['"](package:(flutter|material_ui|cupertino_ui|flutter_riverpod|drift)/|dart:ui)''',
    );
    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .where(
          (f) =>
              f.path.contains(
                '${Platform.pathSeparator}domain${Platform.pathSeparator}',
              ) ||
              f.path.contains('core${Platform.pathSeparator}time'),
        )
        .toList();
    expect(files, isNotEmpty);
    final offenders = [
      for (final f in files)
        if (forbidden.hasMatch(f.readAsStringSync())) f.path,
    ];
    expect(offenders, isEmpty);
  });

  test('Zeitzonen nur aus eingebetteten Daten (kein HTTP-Nachladen)', () {
    final forbidden = RegExp(
      r"""import\s+['"]package:timezone/(standalone|browser)\.dart""",
    );
    final offenders = [
      for (final f in Directory(
        'lib',
      ).listSync(recursive: true).whereType<File>())
        if (f.path.endsWith('.dart') &&
            forbidden.hasMatch(f.readAsStringSync()))
          f.path,
    ];
    expect(offenders, isEmpty);
  });
}
