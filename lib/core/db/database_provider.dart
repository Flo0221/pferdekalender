import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// Die App-Datenbank. In Tests mit `AppDatabase(NativeDatabase.memory())`
/// überschreiben.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});
