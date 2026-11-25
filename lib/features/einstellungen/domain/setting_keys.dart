/// Schlüssel der Tabelle `settings`. Nie umbenennen – sonst gehen
/// gespeicherte Werte (und Werte in alten Backups) verloren.
abstract final class SettingKeys {
  static const themeMode = 'theme_mode';
  static const selectedHorseId = 'selected_horse_id';

  /// Uhrzeit der Erinnerungen in Minuten seit Mitternacht (Standard 9:00).
  static const reminderMinutes = 'reminder_minutes';

  /// Vorbelegte Erinnerungen für neue Pflegetermine, z. B. `"1,7"`.
  static const reminderDefaultOffsets = 'reminder_default_offsets';

  /// `"true"`: pünktliche (exakte) Alarme verwenden, falls erlaubt.
  static const exactReminders = 'exact_reminders';

  /// `"true"`, sobald der Hinweis zu Intervallen einmal bestätigt wurde.
  static const careDisclaimerSeen = 'care_disclaimer_seen';

  /// Zeitpunkt (ISO-8601, UTC) der letzten Dienstplan-Änderung – der
  /// Trainings-Tab bietet danach „Plan neu verteilen“ an.
  static const shiftChangedAt = 'shift_changed_at';

  /// `"true"`, sobald der Hinweis beim ersten Trainingsplan bestätigt wurde.
  static const trainingDisclaimerSeen = 'training_disclaimer_seen';

  /// Zeitpunkt (ISO-8601, UTC) der letzten Datensicherung (Export/Import).
  static const lastExportAt = 'last_export_at';

  /// Export-Erinnerung bis zu diesem Zeitpunkt (ISO-8601, UTC) ausblenden.
  static const exportSnoozedUntil = 'export_snoozed_until';
}
