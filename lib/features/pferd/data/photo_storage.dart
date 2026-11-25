import 'dart:io';

import 'package:path/path.dart' as p;

/// Legt Fotos als Kopie im App-Verzeichnis ab (nicht nur den Pfad merken –
/// die Galerie-Datei könnte sonst gelöscht werden).
class PhotoStorage {
  PhotoStorage(this._baseDir);

  /// Liefert das App-Dokumentenverzeichnis (in Tests ein Temp-Ordner).
  final Future<Directory> Function() _baseDir;

  static const folder = 'photos';

  /// Kopiert [sourcePath] nach `photos/<id>.<endung>` und gibt den
  /// relativen Pfad zurück.
  Future<String> importFile(String sourcePath, String id) async {
    final base = await _baseDir();
    final ext = p.extension(sourcePath).toLowerCase();
    final relative = p.posix.join(folder, '$id${ext.isEmpty ? '.jpg' : ext}');
    final target = File(p.joinAll([base.path, ...p.posix.split(relative)]));
    await target.parent.create(recursive: true);
    await File(sourcePath).copy(target.path);
    return relative;
  }

  Future<File> resolve(String relativePath) async {
    final base = await _baseDir();
    return File(p.joinAll([base.path, ...p.posix.split(relativePath)]));
  }

  Future<void> deleteFile(String relativePath) async {
    final file = await resolve(relativePath);
    if (await file.exists()) await file.delete();
  }
}
