import '../../../core/time/local_date.dart';

/// Geschlecht eines Pferdes. Der [key] wird gespeichert – nie ändern.
enum HorseSex {
  stute('stute'),
  wallach('wallach'),
  hengst('hengst');

  const HorseSex(this.key);
  final String key;

  static HorseSex? fromKey(String? key) {
    for (final s in values) {
      if (s.key == key) return s;
    }
    return null;
  }
}

/// Stammdaten eines Pferdes. Reines Dart.
class Horse {
  const Horse({
    required this.id,
    required this.name,
    this.callName,
    this.birthDate,
    this.birthdayReminder = false,
    this.sex,
    this.breed,
    this.colorMarkings,
    this.heightCm,
    this.ueln,
    this.chipNumber,
    this.passportNumber,
    this.sire,
    this.dam,
    this.stableLocation,
    this.keepingType,
    this.owner,
    this.insurance,
    this.intolerances,
    this.medicalHistory,
    this.notes,
    this.profilePhotoId,
    this.archived = false,
  });

  final String id;
  final String name;
  final String? callName;
  final LocalDate? birthDate;
  final bool birthdayReminder;
  final HorseSex? sex;
  final String? breed;
  final String? colorMarkings;

  /// Stockmaß in Zentimetern.
  final int? heightCm;
  final String? ueln;
  final String? chipNumber;
  final String? passportNumber;
  final String? sire;
  final String? dam;
  final String? stableLocation;
  final String? keepingType;
  final String? owner;
  final String? insurance;
  final String? intolerances;
  final String? medicalHistory;
  final String? notes;
  final String? profilePhotoId;
  final bool archived;

  /// Anzeigename: Rufname, falls vorhanden, sonst Name.
  String get displayName =>
      (callName != null && callName!.trim().isNotEmpty) ? callName! : name;
}

/// Ein Foto eines Pferdes. [relativePath] ist relativ zum
/// App-Dokumentenverzeichnis (z. B. `photos/<uuid>.jpg`).
class HorsePhoto {
  const HorsePhoto({
    required this.id,
    required this.horseId,
    required this.relativePath,
    required this.createdAt,
  });

  final String id;
  final String horseId;
  final String relativePath;
  final DateTime createdAt;
}

/// Ein Gewichtseintrag (Datum + kg).
class WeightEntry {
  const WeightEntry({
    required this.id,
    required this.horseId,
    required this.date,
    required this.weightKg,
    this.note,
  });

  final String id;
  final String horseId;
  final LocalDate date;
  final double weightKg;
  final String? note;
}
