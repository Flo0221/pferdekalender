import 'package:drift/drift.dart';

import '../../../core/db/converters.dart';
import '../../../core/db/tables/common.dart';

@DataClassName('HorseRow')
class Horses extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get callName => text().nullable()();
  TextColumn get birthDate =>
      text().map(const LocalDateConverter()).nullable()();
  BoolColumn get birthdayReminder =>
      boolean().withDefault(const Constant(false))();

  /// `stute` | `wallach` | `hengst`
  TextColumn get sex => text().nullable()();
  TextColumn get breed => text().nullable()();
  TextColumn get colorMarkings => text().nullable()();
  IntColumn get heightCm => integer().nullable()();
  TextColumn get ueln => text().nullable()();
  TextColumn get chipNumber => text().nullable()();
  TextColumn get passportNumber => text().nullable()();
  TextColumn get sire => text().nullable()();
  TextColumn get dam => text().nullable()();
  TextColumn get stableLocation => text().nullable()();
  TextColumn get keepingType => text().nullable()();
  TextColumn get owner => text().nullable()();
  TextColumn get insurance => text().nullable()();
  TextColumn get intolerances => text().nullable()();
  TextColumn get medicalHistory => text().nullable()();
  TextColumn get notes => text().nullable()();

  /// Kein Fremdschlüssel (Zyklus mit horse_photos); wird im Repository gepflegt.
  TextColumn get profilePhotoId => text().nullable()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('HorsePhotoRow')
class HorsePhotos extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();

  /// Relativ zum App-Dokumentenverzeichnis, z. B. `photos/<uuid>.jpg`.
  TextColumn get relativePath => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('HorseWeightRow')
class HorseWeights extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();
  TextColumn get date => text().map(const LocalDateConverter())();
  RealColumn get weightKg => real()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ContactRow')
class Contacts extends Table with Timestamps {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// Siehe `ContactRole.key`.
  TextColumn get role => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('HorseContactRow')
class HorseContacts extends Table with Timestamps {
  TextColumn get horseId =>
      text().references(Horses, #id, onDelete: KeyAction.cascade)();
  TextColumn get contactId =>
      text().references(Contacts, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {horseId, contactId};
}
