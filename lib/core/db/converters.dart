import 'package:drift/drift.dart';

import '../time/local_date.dart';

/// Speichert [LocalDate] als Text `YYYY-MM-DD` – ohne Zeitzone.
class LocalDateConverter extends TypeConverter<LocalDate, String> {
  const LocalDateConverter();

  @override
  LocalDate fromSql(String fromDb) => LocalDate.parse(fromDb);

  @override
  String toSql(LocalDate value) => value.toIso();
}
