import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';

import '../../../core/files/documents_dir_provider.dart';

/// Wo Sicherungsdateien landen bzw. herkommen. In Tests ersetzbar.
abstract interface class BackupFiles {
  /// Datei teilen bzw. herunterladen (Android: Teilen-Menü, iOS-Web:
  /// „In Dateien sichern“, Desktop-Browser: Download).
  Future<void> share(Uint8List bytes, String fileName, {String? subject});

  /// ZIP-Datei auswählen; `null` bei Abbruch.
  Future<Uint8List?> pickZip();

  /// Legt die automatische Sicherung vor einem Import ab. `true`, wenn sie
  /// im App-Speicher liegt (Android/iOS); im Web wird sie geteilt.
  bool get keepsAutoBackupLocally;
  Future<void> keepAutoBackup(Uint8List bytes, String fileName);

  /// Neueste automatische Sicherung (nur bei [keepsAutoBackupLocally]).
  Future<(DateTime, Uint8List)?> latestAutoBackup();
}

class PlatformBackupFiles implements BackupFiles {
  PlatformBackupFiles(this._documentsDir);

  final Future<Directory> Function() _documentsDir;
  static const _folder = 'backups';
  static const _keep = 3;

  @override
  Future<void> share(Uint8List bytes, String fileName, {String? subject}) =>
      SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(bytes, mimeType: 'application/zip', name: fileName),
          ],
          fileNameOverrides: [fileName],
          subject: subject,
          downloadFallbackEnabled: true,
          mailToFallbackEnabled: false,
        ),
      );

  @override
  Future<Uint8List?> pickZip() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['zip'],
    );
    if (files.isEmpty) return null;
    return files.first.readAsBytes();
  }

  @override
  bool get keepsAutoBackupLocally => !kIsWeb;

  @override
  Future<void> keepAutoBackup(Uint8List bytes, String fileName) async {
    if (kIsWeb) return share(bytes, fileName);
    final dir = Directory(p.join((await _documentsDir()).path, _folder));
    await dir.create(recursive: true);
    await File(p.join(dir.path, fileName)).writeAsBytes(bytes, flush: true);
    // Nur die letzten Sicherungen behalten.
    final files = dir.listSync().whereType<File>().toList()
      ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
    for (final f in files.skip(_keep)) {
      await f.delete();
    }
  }

  @override
  Future<(DateTime, Uint8List)?> latestAutoBackup() async {
    if (kIsWeb) return null;
    final dir = Directory(p.join((await _documentsDir()).path, _folder));
    if (!await dir.exists()) return null;
    final files = dir.listSync().whereType<File>().toList()
      ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
    if (files.isEmpty) return null;
    return (files.first.lastModifiedSync(), await files.first.readAsBytes());
  }
}

final backupFilesProvider = Provider<BackupFiles>(
  (ref) => PlatformBackupFiles(() => ref.read(documentsDirProvider.future)),
);
