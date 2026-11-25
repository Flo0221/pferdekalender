/// Vom Nutzer gewähltes Erscheinungsbild. Reines Dart.
enum AppThemeMode {
  system,
  light,
  dark;

  static AppThemeMode fromKey(String? key) => AppThemeMode.values.firstWhere(
    (m) => m.name == key,
    orElse: () => AppThemeMode.system,
  );
}
