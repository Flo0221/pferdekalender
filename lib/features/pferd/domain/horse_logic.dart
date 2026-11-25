import '../../../core/time/local_date.dart';
import 'horse.dart';

/// Alter in ganzen Jahren und Restmonaten.
class HorseAge {
  const HorseAge(this.years, this.months);
  final int years;
  final int months;
}

/// Berechnet das Alter am Tag [today]. Gibt `null` zurück, wenn der
/// Geburtstag in der Zukunft liegt.
HorseAge? ageOn(LocalDate birthDate, LocalDate today) {
  if (birthDate.isAfter(today)) return null;
  var months =
      (today.year - birthDate.year) * 12 + (today.month - birthDate.month);
  // Monat erst voll, wenn der Tag erreicht ist (29.02. zählt im Nicht-
  // Schaltjahr ab dem 28.02., wie bei addMonths).
  if (birthDate.addMonths(months).isAfter(today)) months--;
  return HorseAge(months ~/ 12, months % 12);
}

/// Nächster Geburtstag ab [today] (einschließlich heute).
LocalDate nextBirthday(LocalDate birthDate, LocalDate today) {
  var years = today.year - birthDate.year;
  var candidate = birthDate.addYears(years);
  if (candidate.isBefore(today)) candidate = birthDate.addYears(++years);
  return candidate;
}

/// Wählt das aktuell anzuzeigende Pferd: das gespeicherte, wenn es noch
/// aktiv ist, sonst das erste aktive Pferd, sonst `null`.
Horse? resolveSelectedHorse(List<Horse> activeHorses, String? storedId) {
  if (activeHorses.isEmpty) return null;
  for (final h in activeHorses) {
    if (h.id == storedId) return h;
  }
  return activeHorses.first;
}
