import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'web_env.dart';

/// Ist der Browser-Speicher dauerhaft? (nur Web relevant)
final storagePersistedProvider = FutureProvider.autoDispose<bool>(
  (ref) => ref.watch(webEnvProvider).persisted(),
);

final storageEstimateProvider = FutureProvider.autoDispose<StorageInfo?>(
  (ref) => ref.watch(webEnvProvider).estimate(),
);

/// `true`, sobald eine neue Version bereitliegt (Service Worker wartet).
final updateAvailableProvider = StreamProvider<bool>((ref) async* {
  final env = ref.watch(webEnvProvider);
  yield env.updateAvailable;
  await for (final _ in env.onUpdateAvailable) {
    yield true;
  }
});

/// Gerundete Größenangabe (deutsch): „3,4 MB“.
String formatBytes(int bytes) {
  const units = ['B', 'KB', 'MB', 'GB', 'TB'];
  var v = bytes.toDouble();
  var i = 0;
  while (v >= 1000 && i < units.length - 1) {
    v /= 1000;
    i++;
  }
  final text = i == 0 || v >= 100
      ? v.round().toString()
      : v.toStringAsFixed(1).replaceAll('.', ',');
  return '$text ${units[i]}';
}
