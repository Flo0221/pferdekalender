import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/format/formatters.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/pferd/domain/contact.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/domain/horse_logic.dart';

void main() {
  group('ageOn', () {
    test('volle Jahre erst ab dem Geburtstag', () {
      final birth = LocalDate(2014, 5, 10);
      expect(ageOn(birth, LocalDate(2026, 5, 9))!.years, 11);
      expect(ageOn(birth, LocalDate(2026, 5, 10))!.years, 12);
      expect(ageOn(birth, LocalDate(2026, 5, 9))!.months, 11);
    });

    test('Fohlen in Monaten', () {
      final age = ageOn(LocalDate(2026, 4, 15), LocalDate(2026, 11, 25))!;
      expect(age.years, 0);
      expect(age.months, 7);
      expect(
        ageOn(LocalDate(2026, 11, 20), LocalDate(2026, 11, 25))!.months,
        0,
      );
    });

    test('Geburtstag am 29.02.', () {
      final birth = LocalDate(2020, 2, 29);
      expect(ageOn(birth, LocalDate(2021, 2, 28))!.years, 1);
      expect(ageOn(birth, LocalDate(2021, 2, 27))!.years, 0);
    });

    test('Geburtstag in der Zukunft ergibt null', () {
      expect(ageOn(LocalDate(2027, 1, 1), LocalDate(2026, 11, 25)), isNull);
    });
  });

  group('nextBirthday', () {
    test('heute oder später', () {
      final birth = LocalDate(2014, 5, 10);
      expect(
        nextBirthday(birth, LocalDate(2026, 5, 10)),
        LocalDate(2026, 5, 10),
      );
      expect(
        nextBirthday(birth, LocalDate(2026, 5, 11)),
        LocalDate(2027, 5, 10),
      );
      expect(
        nextBirthday(birth, LocalDate(2026, 1, 1)),
        LocalDate(2026, 5, 10),
      );
    });

    test('29.02. im Nicht-Schaltjahr am 28.02.', () {
      expect(
        nextBirthday(LocalDate(2020, 2, 29), LocalDate(2026, 1, 1)),
        LocalDate(2026, 2, 28),
      );
      expect(
        nextBirthday(LocalDate(2020, 2, 29), LocalDate(2027, 3, 1)),
        LocalDate(2028, 2, 29),
      );
    });
  });

  group('resolveSelectedHorse', () {
    const a = Horse(id: 'a', name: 'Amigo');
    const b = Horse(id: 'b', name: 'Bella');

    test('gespeichertes Pferd, wenn aktiv', () {
      expect(resolveSelectedHorse([a, b], 'b'), b);
    });

    test('sonst das erste aktive Pferd', () {
      expect(resolveSelectedHorse([a, b], 'weg'), a);
      expect(resolveSelectedHorse([a, b], null), a);
    });

    test('ohne Pferde null', () {
      expect(resolveSelectedHorse([], 'a'), isNull);
    });
  });

  test('displayName bevorzugt Rufnamen', () {
    expect(
      const Horse(id: '1', name: 'Don Diego', callName: 'Didi').displayName,
      'Didi',
    );
    expect(
      const Horse(id: '1', name: 'Don Diego', callName: ' ').displayName,
      'Don Diego',
    );
  });

  group('Contact.dialablePhone', () {
    Contact c(String? phone) =>
        Contact(id: '1', name: 'X', role: ContactRole.tierarzt, phone: phone);

    test('entfernt Leerzeichen, Klammern und Bindestriche', () {
      expect(c('0171 / 123-45 67').dialablePhone, '01711234567');
      expect(c('+49 (171) 1234567').dialablePhone, '+491711234567');
    });

    test('ohne brauchbare Nummer null', () {
      expect(c(null).dialablePhone, isNull);
      expect(c('   ').dialablePhone, isNull);
      expect(c('Praxis anrufen').dialablePhone, isNull);
    });
  });

  group('Fmt.parseDecimal', () {
    test('deutsche und englische Schreibweise', () {
      expect(Fmt.parseDecimal('550,5'), 550.5);
      expect(Fmt.parseDecimal('550.5'), 550.5);
      expect(Fmt.parseDecimal(' 1.234,5 '), 1234.5);
      expect(Fmt.parseDecimal('600'), 600);
    });

    test('ungültige Eingaben', () {
      expect(Fmt.parseDecimal(''), isNull);
      expect(Fmt.parseDecimal('abc'), isNull);
    });
  });
}
