import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'web_env_stub.dart' if (dart.library.js_interop) 'web_env_web.dart';

/// Speicher-Schätzung des Browsers (`navigator.storage.estimate()`).
class StorageInfo {
  const StorageInfo({required this.usageBytes, required this.quotaBytes});
  final int usageBytes;
  final int quotaBytes;
}

/// Browser-Funktionen der Web-App (PWA). Auf Android/iOS ist alles ein
/// No-op ([isWeb] = false) – dort gibt es keinen Browser-Speicher.
abstract class WebEnv {
  bool get isWeb;

  /// Läuft als installierte App vom Home-Bildschirm (nicht im Browser-Tab).
  bool get isStandalone;

  /// iPhone/iPad (Safari, auch iPadOS mit Desktop-Kennung).
  bool get isAppleMobile;

  /// Hat der Browser den Speicher als dauerhaft markiert?
  Future<bool> persisted();

  /// Bittet um dauerhaften Speicher; gibt das Ergebnis zurück.
  Future<bool> requestPersist();

  Future<StorageInfo?> estimate();

  /// Neue Version vom Service Worker geladen und wartet auf Neuladen.
  bool get updateAvailable;
  Stream<void> get onUpdateAvailable;

  /// Aktiviert die wartende Version und lädt die Seite neu.
  void applyUpdate();

  /// Datei direkt herunterladen bzw. öffnen (Web). Für .ics bietet Safari
  /// dann „Zum Kalender hinzufügen“ an. Native: nicht verfügbar.
  Future<void> downloadFile(List<int> bytes, String fileName, String mimeType);

  /// App-Abzeichen (Badging API), 0 entfernt es. Wird still ignoriert,
  /// wenn der Browser es nicht kann.
  void setBadge(int count);
}

final webEnvProvider = Provider<WebEnv>((ref) => createWebEnv());

/// Web: beim Start um dauerhaften Speicher bitten (Safari gewährt das
/// meist nur der installierten App). Native: nichts.
Future<bool> requestPersistentStorage() => createWebEnv().requestPersist();
