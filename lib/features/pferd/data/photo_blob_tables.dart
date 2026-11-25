import 'package:drift/drift.dart';

import '../../../core/db/tables/common.dart';

/// Foto-Inhalte für die Web-App (kein Dateisystem). Auf Android/iOS bleibt
/// die Tabelle leer – dort liegen Fotos als Dateien.
@DataClassName('PhotoBlobRow')
class PhotoBlobs extends Table with Timestamps {
  /// Wie `horse_photos.relative_path`, z. B. `photos/<uuid>.jpg`.
  TextColumn get path => text()();
  BlobColumn get data => blob()();

  @override
  Set<Column<Object>> get primaryKey => {path};
}
