import 'dart:typed_data';

import 'package:pferdekalender/features/backup/ui/backup_files.dart';

/// Merkt sich geteilte Dateien; liefert eine vorgegebene Datei beim Import.
class FakeBackupFiles implements BackupFiles {
  final shared = <(String, Uint8List)>[];
  final autoBackups = <(String, Uint8List)>[];
  Uint8List? toPick;

  @override
  bool keepsAutoBackupLocally = true;

  @override
  Future<void> share(
    Uint8List bytes,
    String fileName, {
    String? subject,
  }) async => shared.add((fileName, bytes));

  @override
  Future<Uint8List?> pickZip() async => toPick;

  @override
  Future<void> keepAutoBackup(Uint8List bytes, String fileName) async =>
      autoBackups.add((fileName, bytes));

  @override
  Future<(DateTime, Uint8List)?> latestAutoBackup() async => autoBackups.isEmpty
      ? null
      : (DateTime(2026, 11, 25), autoBackups.last.$2);
}
