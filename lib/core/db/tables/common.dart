import 'package:drift/drift.dart';

/// Gemeinsame Zeitstempel für alle Tabellen (Unix-Sekunden, UTC-neutral).
mixin Timestamps on Table {
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
