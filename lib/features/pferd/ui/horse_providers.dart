import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

import '../../../core/db/database_provider.dart';
import '../../../core/files/documents_dir_provider.dart';
import '../../einstellungen/domain/setting_keys.dart';
import '../../einstellungen/ui/settings_providers.dart';
import '../data/horse_repository.dart';
import '../data/photo_storage.dart';
import '../data/photo_store.dart';
import '../domain/contact.dart';
import '../domain/horse.dart';
import '../domain/horse_logic.dart';

/// Foto-Ablage: Dateien (Android/iOS) bzw. Datenbank-Blobs (Web).
final photoStorageProvider = Provider<PhotoStore>(
  (ref) => kIsWeb
      ? DbPhotoStore(ref.watch(databaseProvider))
      : PhotoStorage(() => ref.read(documentsDirProvider.future)),
);

/// Foto-Inhalt (nur Web benötigt; Android zeigt Dateien direkt an).
final photoBytesProvider = FutureProvider.family<Uint8List?, String>(
  (ref, relativePath) =>
      ref.watch(photoStorageProvider).readBytes(relativePath),
);

/// Bildquelle für ein Foto: `FileImage` (Android/iOS) bzw. `MemoryImage` (Web).
final photoImageProvider = Provider.family<ImageProvider?, String>((
  ref,
  relativePath,
) {
  if (kIsWeb) {
    final bytes = ref.watch(photoBytesProvider(relativePath)).value;
    return bytes == null ? null : MemoryImage(bytes);
  }
  final file = ref.watch(photoFileProvider(relativePath));
  return file == null ? null : FileImage(file);
});

final horseRepositoryProvider = Provider<HorseRepository>(
  (ref) => HorseRepository(
    ref.watch(databaseProvider),
    ref.watch(photoStorageProvider),
  ),
);

final activeHorsesProvider = StreamProvider<List<Horse>>(
  (ref) => ref.watch(horseRepositoryProvider).watchHorses(archived: false),
);

final archivedHorsesProvider = StreamProvider<List<Horse>>(
  (ref) => ref.watch(horseRepositoryProvider).watchHorses(archived: true),
);

final _storedSelectedHorseIdProvider = StreamProvider<String?>(
  (ref) => ref
      .watch(settingsRepositoryProvider)
      .watchValue(SettingKeys.selectedHorseId),
);

/// Das im Pferde-Umschalter gewählte Pferd (`null`, wenn es keins gibt).
/// Alle pferdebezogenen Bereiche filtern danach.
final selectedHorseProvider = Provider<AsyncValue<Horse?>>((ref) {
  final horses = ref.watch(activeHorsesProvider);
  final stored = ref.watch(_storedSelectedHorseIdProvider);
  if (stored.isLoading && !stored.hasValue) return const AsyncLoading();
  return horses.whenData((list) => resolveSelectedHorse(list, stored.value));
});

/// Merkt sich das gewählte Pferd dauerhaft (Tabelle `settings`).
final horseSelectionProvider = Provider<HorseSelection>(
  (ref) => HorseSelection(ref.watch(settingsRepositoryProvider).setValue),
);

class HorseSelection {
  HorseSelection(this._setValue);

  final Future<void> Function(String key, String value) _setValue;

  Future<void> select(String horseId) =>
      _setValue(SettingKeys.selectedHorseId, horseId);
}

final horseProvider = StreamProvider.family<Horse?, String>(
  (ref, id) => ref.watch(horseRepositoryProvider).watchHorse(id),
);

final horsePhotosProvider = StreamProvider.family<List<HorsePhoto>, String>(
  (ref, horseId) => ref.watch(horseRepositoryProvider).watchPhotos(horseId),
);

final horseWeightsProvider = StreamProvider.family<List<WeightEntry>, String>(
  (ref, horseId) => ref.watch(horseRepositoryProvider).watchWeights(horseId),
);

final horseContactsProvider = StreamProvider.family<List<Contact>, String>(
  (ref, horseId) => ref.watch(horseRepositoryProvider).watchContactsOf(horseId),
);

final allContactsProvider = StreamProvider<List<Contact>>(
  (ref) => ref.watch(horseRepositoryProvider).watchAllContacts(),
);

/// Absoluter Pfad eines Fotos, sobald das App-Verzeichnis bekannt ist.
final photoFileProvider = Provider.family<File?, String>((ref, relativePath) {
  if (kIsWeb) return null;
  final dir = ref.watch(documentsDirProvider).value;
  if (dir == null) return null;
  return File(p.joinAll([dir.path, ...p.posix.split(relativePath)]));
});

/// Profilbild eines Pferdes oder `null`.
final profilePhotoImageProvider = Provider.family<ImageProvider?, Horse>((
  ref,
  horse,
) {
  final photos = ref.watch(horsePhotosProvider(horse.id)).value ?? const [];
  for (final photo in photos) {
    if (photo.id == horse.profilePhotoId) {
      return ref.watch(photoImageProvider(photo.relativePath));
    }
  }
  return null;
});
