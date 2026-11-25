import 'package:drift/drift.dart';

import 'package:uuid/uuid.dart';

import '../../../core/db/app_database.dart';
import '../../../core/time/local_date.dart';
import '../domain/contact.dart';
import '../domain/horse.dart';
import 'photo_store.dart';

/// Zugriff auf Pferde, Fotos, Gewichte und Kontakte.
class HorseRepository {
  HorseRepository(this._db, this._photos, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final PhotoStore _photos;
  final Uuid _uuid;

  // ---------------------------------------------------------------- Pferde

  Stream<List<Horse>> watchHorses({required bool archived}) {
    final query = _db.select(_db.horses)
      ..where(
        (h) => archived ? h.archivedAt.isNotNull() : h.archivedAt.isNull(),
      )
      ..orderBy([
        (h) => OrderingTerm(expression: h.sortOrder),
        (h) => OrderingTerm(expression: h.name.collate(Collate.noCase)),
      ]);
    return query.watch().map((rows) => rows.map(_toHorse).toList());
  }

  Stream<Horse?> watchHorse(String id) =>
      (_db.select(_db.horses)..where((h) => h.id.equals(id)))
          .watchSingleOrNull()
          .map((row) => row == null ? null : _toHorse(row));

  Future<Horse?> getHorse(String id) async {
    final row = await (_db.select(
      _db.horses,
    )..where((h) => h.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toHorse(row);
  }

  /// Legt ein neues Pferd an und gibt die neue ID zurück.
  /// `id` und `profilePhotoId` von [horse] werden ignoriert.
  Future<String> createHorse(Horse horse) async {
    final id = _uuid.v4();
    await _db.into(_db.horses).insert(_toCompanion(horse, id: id));
    return id;
  }

  Future<void> updateHorse(Horse horse) =>
      (_db.update(_db.horses)..where((h) => h.id.equals(horse.id))).write(
        _toCompanion(horse, id: horse.id).copyWith(
          // Profilbild wird nur über setProfilePhoto geändert.
          profilePhotoId: const Value.absent(),
          archivedAt: const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> setArchived(String id, {required bool archived}) =>
      (_db.update(_db.horses)..where((h) => h.id.equals(id))).write(
        HorsesCompanion(
          archivedAt: Value(archived ? DateTime.now() : null),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Löscht ein Pferd endgültig – inklusive aller Fotos (auch der Dateien),
  /// Gewichte und Kontakt-Zuordnungen. Kontakte selbst bleiben erhalten.
  Future<void> deleteHorsePermanently(String id) async {
    final photos = await (_db.select(
      _db.horsePhotos,
    )..where((p) => p.horseId.equals(id))).get();
    await (_db.delete(_db.horses)..where((h) => h.id.equals(id))).go();
    for (final p in photos) {
      await _photos.deleteFile(p.relativePath);
    }
  }

  // ---------------------------------------------------------------- Fotos

  Stream<List<HorsePhoto>> watchPhotos(String horseId) =>
      (_db.select(_db.horsePhotos)
            ..where((p) => p.horseId.equals(horseId))
            ..orderBy([(p) => OrderingTerm(expression: p.createdAt)]))
          .watch()
          .map((rows) => rows.map(_toPhoto).toList());

  /// Kopiert die Datei [sourcePath] ins App-Verzeichnis und speichert sie als
  /// Foto. Das erste Foto eines Pferdes wird automatisch Profilbild.
  ///
  /// Android/iOS: [sourcePath] (Datei wird kopiert); Web: [bytes].
  Future<String> addPhoto(
    String horseId,
    String? sourcePath, {
    Uint8List? bytes,
    String extension = '.jpg',
  }) async {
    final id = _uuid.v4();
    final relativePath = await _photos.importPhoto(
      id,
      sourcePath: sourcePath,
      bytes: bytes,
      extension: extension,
    );
    await _db.transaction(() async {
      await _db
          .into(_db.horsePhotos)
          .insert(
            HorsePhotosCompanion.insert(
              id: id,
              horseId: horseId,
              relativePath: relativePath,
            ),
          );
      final horse = await (_db.select(
        _db.horses,
      )..where((h) => h.id.equals(horseId))).getSingle();
      if (horse.profilePhotoId == null) {
        await setProfilePhoto(horseId, id);
      }
    });
    return id;
  }

  Future<void> setProfilePhoto(String horseId, String? photoId) =>
      (_db.update(_db.horses)..where((h) => h.id.equals(horseId))).write(
        HorsesCompanion(
          profilePhotoId: Value(photoId),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Löscht ein Foto samt Datei. War es das Profilbild, wird das nächste
  /// vorhandene Foto Profilbild (oder keins).
  Future<void> deletePhoto(String photoId) async {
    final photo = await (_db.select(
      _db.horsePhotos,
    )..where((p) => p.id.equals(photoId))).getSingleOrNull();
    if (photo == null) return;
    await _db.transaction(() async {
      await (_db.delete(
        _db.horsePhotos,
      )..where((p) => p.id.equals(photoId))).go();
      final horse = await (_db.select(
        _db.horses,
      )..where((h) => h.id.equals(photo.horseId))).getSingle();
      if (horse.profilePhotoId == photoId) {
        final next =
            await (_db.select(_db.horsePhotos)
                  ..where((p) => p.horseId.equals(photo.horseId))
                  ..orderBy([(p) => OrderingTerm(expression: p.createdAt)])
                  ..limit(1))
                .getSingleOrNull();
        await setProfilePhoto(photo.horseId, next?.id);
      }
    });
    await _photos.deleteFile(photo.relativePath);
  }

  // ---------------------------------------------------------------- Gewicht

  /// Gewichtseinträge, älteste zuerst.
  Stream<List<WeightEntry>> watchWeights(String horseId) =>
      (_db.select(_db.horseWeights)
            ..where((w) => w.horseId.equals(horseId))
            ..orderBy([
              (w) => OrderingTerm(expression: w.date),
              (w) => OrderingTerm(expression: w.createdAt),
            ]))
          .watch()
          .map(
            (rows) => [
              for (final r in rows)
                WeightEntry(
                  id: r.id,
                  horseId: r.horseId,
                  date: r.date,
                  weightKg: r.weightKg,
                  note: r.note,
                ),
            ],
          );

  Future<void> addWeight(
    String horseId,
    LocalDate date,
    double weightKg, {
    String? note,
  }) => _db
      .into(_db.horseWeights)
      .insert(
        HorseWeightsCompanion.insert(
          id: _uuid.v4(),
          horseId: horseId,
          date: date,
          weightKg: weightKg,
          note: Value(_clean(note)),
        ),
      );

  Future<void> deleteWeight(String id) =>
      (_db.delete(_db.horseWeights)..where((w) => w.id.equals(id))).go();

  // ---------------------------------------------------------------- Kontakte

  Stream<List<Contact>> watchAllContacts() =>
      (_db.select(_db.contacts)..orderBy([
            (c) => OrderingTerm(expression: c.name.collate(Collate.noCase)),
          ]))
          .watch()
          .map((rows) => rows.map(_toContact).toList());

  Stream<List<Contact>> watchContactsOf(String horseId) {
    final query =
        _db.select(_db.contacts).join([
            innerJoin(
              _db.horseContacts,
              _db.horseContacts.contactId.equalsExp(_db.contacts.id),
            ),
          ])
          ..where(_db.horseContacts.horseId.equals(horseId))
          ..orderBy([
            OrderingTerm(expression: _db.contacts.role),
            OrderingTerm(expression: _db.contacts.name.collate(Collate.noCase)),
          ]);
    return query.watch().map(
      (rows) => [for (final r in rows) _toContact(r.readTable(_db.contacts))],
    );
  }

  /// Legt einen Kontakt an (oder aktualisiert ihn, wenn [Contact.id] existiert)
  /// und ordnet ihn optional [horseId] zu. Gibt die Kontakt-ID zurück.
  Future<String> saveContact(Contact contact, {String? horseId}) async {
    final id = contact.id.isEmpty ? _uuid.v4() : contact.id;
    await _db.transaction(() async {
      await _db
          .into(_db.contacts)
          .insert(
            ContactsCompanion.insert(
              id: id,
              name: contact.name.trim(),
              role: contact.role.key,
              phone: Value(_clean(contact.phone)),
              email: Value(_clean(contact.email)),
              notes: Value(_clean(contact.notes)),
            ),
            onConflict: DoUpdate(
              (_) => ContactsCompanion(
                name: Value(contact.name.trim()),
                role: Value(contact.role.key),
                phone: Value(_clean(contact.phone)),
                email: Value(_clean(contact.email)),
                notes: Value(_clean(contact.notes)),
                updatedAt: Value(DateTime.now()),
              ),
            ),
          );
      if (horseId != null) await linkContact(horseId, id);
    });
    return id;
  }

  Future<void> linkContact(String horseId, String contactId) => _db
      .into(_db.horseContacts)
      .insert(
        HorseContactsCompanion.insert(horseId: horseId, contactId: contactId),
        mode: InsertMode.insertOrIgnore,
      );

  Future<void> unlinkContact(String horseId, String contactId) =>
      (_db.delete(_db.horseContacts)..where(
            (hc) => hc.horseId.equals(horseId) & hc.contactId.equals(contactId),
          ))
          .go();

  // ---------------------------------------------------------------- Mapping

  static String? _clean(String? value) {
    final t = value?.trim();
    return (t == null || t.isEmpty) ? null : t;
  }

  Horse _toHorse(HorseRow r) => Horse(
    id: r.id,
    name: r.name,
    callName: r.callName,
    birthDate: r.birthDate,
    birthdayReminder: r.birthdayReminder,
    sex: HorseSex.fromKey(r.sex),
    breed: r.breed,
    colorMarkings: r.colorMarkings,
    heightCm: r.heightCm,
    ueln: r.ueln,
    chipNumber: r.chipNumber,
    passportNumber: r.passportNumber,
    sire: r.sire,
    dam: r.dam,
    stableLocation: r.stableLocation,
    keepingType: r.keepingType,
    owner: r.owner,
    insurance: r.insurance,
    intolerances: r.intolerances,
    medicalHistory: r.medicalHistory,
    notes: r.notes,
    profilePhotoId: r.profilePhotoId,
    archived: r.archivedAt != null,
  );

  HorsesCompanion _toCompanion(Horse h, {required String id}) =>
      HorsesCompanion.insert(
        id: id,
        name: h.name.trim(),
        callName: Value(_clean(h.callName)),
        birthDate: Value(h.birthDate),
        birthdayReminder: Value(h.birthdayReminder),
        sex: Value(h.sex?.key),
        breed: Value(_clean(h.breed)),
        colorMarkings: Value(_clean(h.colorMarkings)),
        heightCm: Value(h.heightCm),
        ueln: Value(_clean(h.ueln)),
        chipNumber: Value(_clean(h.chipNumber)),
        passportNumber: Value(_clean(h.passportNumber)),
        sire: Value(_clean(h.sire)),
        dam: Value(_clean(h.dam)),
        stableLocation: Value(_clean(h.stableLocation)),
        keepingType: Value(_clean(h.keepingType)),
        owner: Value(_clean(h.owner)),
        insurance: Value(_clean(h.insurance)),
        intolerances: Value(_clean(h.intolerances)),
        medicalHistory: Value(_clean(h.medicalHistory)),
        notes: Value(_clean(h.notes)),
      );

  HorsePhoto _toPhoto(HorsePhotoRow r) => HorsePhoto(
    id: r.id,
    horseId: r.horseId,
    relativePath: r.relativePath,
    createdAt: r.createdAt,
  );

  Contact _toContact(ContactRow r) => Contact(
    id: r.id,
    name: r.name,
    role: ContactRole.fromKey(r.role),
    phone: r.phone,
    email: r.email,
    notes: r.notes,
  );
}
