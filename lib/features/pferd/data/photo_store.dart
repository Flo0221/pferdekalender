import 'dart:typed_data';

import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';

/// Ablage für Foto-Inhalte – Dateien (Android/iOS, `PhotoStorage`) oder
/// Datenbank-Blobs (Web, [DbPhotoStore]). `relativePath` ist überall gleich
/// (`photos/<id>.<endung>`), damit Sicherungen austauschbar sind.
abstract interface class PhotoStore {
  /// Speichert ein ausgewähltes Foto unter `photos/<id>.<endung>`.
  /// Entweder [sourcePath] (Datei) oder [bytes] angeben.
  Future<String> importPhoto(
    String id, {
    String? sourcePath,
    Uint8List? bytes,
    String extension = '.jpg',
  });

  Future<Uint8List?> readBytes(String relativePath);
  Future<void> writeBytes(String relativePath, Uint8List bytes);
  Future<void> deleteFile(String relativePath);

  /// Alle Fotos löschen (vor einem Import).
  Future<void> deleteAll();
}

/// Web: Fotos als Blob in der Datenbank (IndexedDB/OPFS über Drift).
class DbPhotoStore implements PhotoStore {
  DbPhotoStore(this._db);

  final AppDatabase _db;

  @override
  Future<String> importPhoto(
    String id, {
    String? sourcePath,
    Uint8List? bytes,
    String extension = '.jpg',
  }) async {
    if (bytes == null) {
      throw ArgumentError('Im Web werden Fotos als Bytes übergeben.');
    }
    final rel =
        'photos/$id${extension.isEmpty ? '.jpg' : extension.toLowerCase()}';
    await writeBytes(rel, bytes);
    return rel;
  }

  @override
  Future<Uint8List?> readBytes(String relativePath) async => (await (_db.select(
    _db.photoBlobs,
  )..where((b) => b.path.equals(relativePath))).getSingleOrNull())?.data;

  @override
  Future<void> writeBytes(String relativePath, Uint8List bytes) => _db
      .into(_db.photoBlobs)
      .insertOnConflictUpdate(
        PhotoBlobsCompanion.insert(path: relativePath, data: bytes),
      );

  @override
  Future<void> deleteFile(String relativePath) => (_db.delete(
    _db.photoBlobs,
  )..where((b) => b.path.equals(relativePath))).go();

  @override
  Future<void> deleteAll() => _db.delete(_db.photoBlobs).go();
}
