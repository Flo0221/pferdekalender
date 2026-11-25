import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/pferd/data/horse_repository.dart';
import 'package:pferdekalender/features/pferd/data/photo_storage.dart';
import 'package:pferdekalender/features/pferd/domain/contact.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';

void main() {
  late AppDatabase db;
  late Directory dir;
  late HorseRepository repo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    dir = await Directory.systemTemp.createTemp('pferdekalender_test');
    repo = HorseRepository(db, PhotoStorage(() async => dir));
  });

  tearDown(() async {
    await db.close();
    await dir.delete(recursive: true);
  });

  Future<String> sourceImage(String name) async {
    final f = File('${dir.path}/quelle_$name.jpg');
    await f.writeAsBytes([1, 2, 3]);
    return f.path;
  }

  test('Pferd anlegen, lesen, ändern', () async {
    final id = await repo.createHorse(
      Horse(
        id: '',
        name: '  Don Diego ',
        callName: 'Didi',
        birthDate: LocalDate(2014, 5, 10),
        sex: HorseSex.wallach,
        heightCm: 168,
        breed: '',
      ),
    );
    var h = (await repo.getHorse(id))!;
    expect(h.name, 'Don Diego');
    expect(h.breed, isNull, reason: 'leere Texte werden nicht gespeichert');
    expect(h.birthDate, LocalDate(2014, 5, 10));
    expect(h.sex, HorseSex.wallach);

    await repo.updateHorse(
      Horse(id: id, name: 'Don Diego', breed: 'Hannoveraner'),
    );
    h = (await repo.getHorse(id))!;
    expect(h.breed, 'Hannoveraner');
    expect(h.callName, isNull);
  });

  test('Archivieren blendet aus, Wiederherstellen zeigt wieder', () async {
    final a = await repo.createHorse(const Horse(id: '', name: 'Amigo'));
    final b = await repo.createHorse(const Horse(id: '', name: 'Bella'));
    await repo.setArchived(a, archived: true);

    expect((await repo.watchHorses(archived: false).first).map((h) => h.id), [
      b,
    ]);
    expect((await repo.watchHorses(archived: true).first).map((h) => h.id), [
      a,
    ]);

    await repo.setArchived(a, archived: false);
    expect(await repo.watchHorses(archived: false).first, hasLength(2));
  });

  test('Fotos: Kopie im App-Ordner, erstes Foto wird Profilbild', () async {
    final id = await repo.createHorse(const Horse(id: '', name: 'Amigo'));
    final src = await sourceImage('a');
    final p1 = await repo.addPhoto(id, src);
    final p2 = await repo.addPhoto(id, await sourceImage('b'));

    final photos = await repo.watchPhotos(id).first;
    expect(photos, hasLength(2));
    expect(photos.first.relativePath, startsWith('photos/'));
    expect(
      File('${dir.path}/${photos.first.relativePath}').existsSync(),
      isTrue,
    );
    // Original bleibt unangetastet.
    expect(File(src).existsSync(), isTrue);
    expect((await repo.getHorse(id))!.profilePhotoId, p1);

    await repo.setProfilePhoto(id, p2);
    expect((await repo.getHorse(id))!.profilePhotoId, p2);
  });

  test('Profilbild löschen wählt das nächste Foto', () async {
    final id = await repo.createHorse(const Horse(id: '', name: 'Amigo'));
    final p1 = await repo.addPhoto(id, await sourceImage('a'));
    final p2 = await repo.addPhoto(id, await sourceImage('b'));
    final path1 = (await repo.watchPhotos(id).first).first.relativePath;

    await repo.deletePhoto(p1);
    expect((await repo.getHorse(id))!.profilePhotoId, p2);
    expect(File('${dir.path}/$path1').existsSync(), isFalse);

    await repo.deletePhoto(p2);
    expect((await repo.getHorse(id))!.profilePhotoId, isNull);
  });

  test('Gewichte nach Datum sortiert', () async {
    final id = await repo.createHorse(const Horse(id: '', name: 'Amigo'));
    await repo.addWeight(id, LocalDate(2026, 6, 1), 560);
    await repo.addWeight(id, LocalDate(2026, 1, 1), 545.5, note: 'Winter');
    final w = await repo.watchWeights(id).first;
    expect(w.map((e) => e.weightKg), [545.5, 560]);
    expect(w.first.note, 'Winter');
  });

  test('Kontakt mehreren Pferden zuordnen und entfernen', () async {
    final a = await repo.createHorse(const Horse(id: '', name: 'Amigo'));
    final b = await repo.createHorse(const Horse(id: '', name: 'Bella'));
    final vet = await repo.saveContact(
      const Contact(
        id: '',
        name: 'Dr. Huf',
        role: ContactRole.tierarzt,
        phone: '0171 123',
      ),
      horseId: a,
    );
    await repo.linkContact(b, vet);
    await repo.linkContact(b, vet); // doppelt ist harmlos

    expect((await repo.watchContactsOf(a).first).single.name, 'Dr. Huf');
    expect((await repo.watchContactsOf(b).first).single.id, vet);

    // Änderung wirkt für beide Pferde.
    await repo.saveContact(
      Contact(id: vet, name: 'Dr. Hufeisen', role: ContactRole.tierarzt),
    );
    expect((await repo.watchContactsOf(b).first).single.name, 'Dr. Hufeisen');

    await repo.unlinkContact(a, vet);
    expect(await repo.watchContactsOf(a).first, isEmpty);
    expect(await repo.watchContactsOf(b).first, hasLength(1));
  });

  test('Endgültig löschen entfernt Fotos, Gewichte und Zuordnungen', () async {
    final id = await repo.createHorse(const Horse(id: '', name: 'Amigo'));
    await repo.addPhoto(id, await sourceImage('a'));
    final photoPath = (await repo.watchPhotos(id).first).single.relativePath;
    await repo.addWeight(id, LocalDate(2026, 1, 1), 550);
    final vet = await repo.saveContact(
      const Contact(id: '', name: 'Dr. Huf', role: ContactRole.tierarzt),
      horseId: id,
    );

    await repo.deleteHorsePermanently(id);

    expect(await repo.getHorse(id), isNull);
    expect(await db.select(db.horsePhotos).get(), isEmpty);
    expect(await db.select(db.horseWeights).get(), isEmpty);
    expect(await db.select(db.horseContacts).get(), isEmpty);
    expect(File('${dir.path}/$photoPath').existsSync(), isFalse);
    // Der Kontakt selbst bleibt (könnte anderen Pferden gehören).
    expect((await repo.watchAllContacts().first).single.id, vet);
  });
}
