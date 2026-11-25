import 'package:drift/drift.dart' show Variable;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/db/converters.dart';
import 'package:pferdekalender/core/time/local_date.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test(
    'Datenbank öffnet mit aktueller Schema-Version und Fremdschlüsseln',
    () async {
      expect(db.schemaVersion, 5);
      final rows = await db.customSelect('PRAGMA foreign_keys').getSingle();
      expect(rows.data.values.single, 1);
    },
  );

  test('LocalDate wird als Text ohne Zeitzone gespeichert', () async {
    const converter = LocalDateConverter();
    final dstDay = LocalDate(2026, 3, 29);
    final stored = converter.toSql(dstDay);
    expect(stored, '2026-03-29');
    // Roundtrip über SQLite.
    final row = await db
        .customSelect('SELECT ? AS d', variables: [Variable.withString(stored)])
        .getSingle();
    expect(converter.fromSql(row.read<String>('d')), dstDay);
  });
}
