/// Rolle eines Kontakts. Der [key] wird gespeichert – nie ändern.
enum ContactRole {
  tierarzt('tierarzt'),
  hufschmied('hufschmied'),
  zahnarzt('zahnarzt'),
  physio('physio'),
  sattler('sattler'),
  trainer('trainer'),
  stall('stall'),
  besitzer('besitzer'),
  notfall('notfall'),
  sonstige('sonstige');

  const ContactRole(this.key);
  final String key;

  static ContactRole fromKey(String? key) => values.firstWhere(
    (r) => r.key == key,
    orElse: () => ContactRole.sonstige,
  );
}

/// Ein Kontakt (Tierarzt, Hufschmied …), kann mehreren Pferden zugeordnet sein.
class Contact {
  const Contact({
    required this.id,
    required this.name,
    required this.role,
    this.phone,
    this.email,
    this.notes,
  });

  final String id;
  final String name;
  final ContactRole role;
  final String? phone;
  final String? email;
  final String? notes;

  /// Telefonnummer für einen `tel:`-Link (nur Ziffern und führendes +),
  /// oder `null`, wenn keine brauchbare Nummer vorhanden ist.
  String? get dialablePhone {
    final raw = phone?.trim();
    if (raw == null || raw.isEmpty) return null;
    final cleaned = raw.replaceAll(RegExp(r'[^\d+]'), '');
    final normalized = cleaned.startsWith('+')
        ? '+${cleaned.substring(1).replaceAll('+', '')}'
        : cleaned.replaceAll('+', '');
    return RegExp(r'\d{3,}').hasMatch(normalized) ? normalized : null;
  }
}
