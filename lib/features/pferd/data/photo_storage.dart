import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import 'photo_store.dart';

/// Legt Fotos als Kopie im App-Verzeichnis ab (nicht nur den Pfad merken –
/// die Galerie-Datei könnte sonst gelöscht werden).
class PhotoStorage implements PhotoStore {
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

  @override
  Future<String> importPhoto(
    String id, {
    String? sourcePath,
    Uint8List? bytes,
    String extension = '.jpg',
  }) async {
    if (sourcePath != null) return importFile(sourcePath, id);
    final rel = p.posix.join(folder, '$id${extension.toLowerCase()}');
    await writeBytes(rel, bytes!);
    return rel;
  }

  Future<File> resolve(String relativePath) async {
    final base = await _baseDir();
    return File(p.joinAll([base.path, ...p.posix.split(relativePath)]));
  }

  @override
  Future<void> deleteFile(String relativePath) async {
    final file = await resolve(relativePath);
    if (await file.exists()) await file.delete();
  }

  @override
  Future<Uint8List?> readBytes(String relativePath) async {
    final file = await resolve(relativePath);
    return await file.exists() ? file.readAsBytes() : null;
  }

  @override
  Future<void> writeBytes(String relativePath, Uint8List bytes) async {
    final file = await resolve(relativePath);
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes, flush: true);
  }

  /// Löscht alle Fotos (vor einem Import).
  @override
  Future<void> deleteAll() async {
    final base = await _baseDir();
    final dir = Directory(p.join(base.path, folder));
    if (await dir.exists()) await dir.delete(recursive: true);
  }
}
