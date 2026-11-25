import 'dart:async';

import 'package:pferdekalender/core/platform/web_env.dart';

/// Simulierter Browser für Widget-Tests der Web-Hinweise.
class FakeWebEnv implements WebEnv {
  FakeWebEnv({this.isStandalone = false, this.isAppleMobile = true});

  @override
  bool get isWeb => true;
  @override
  bool isStandalone;
  @override
  bool isAppleMobile;

  bool persistedValue = false;
  int persistRequests = 0;
  int applyUpdateCalls = 0;
  int? badge;
  StorageInfo? info = const StorageInfo(
    usageBytes: 3400000,
    quotaBytes: 1000000000,
  );

  final _updates = StreamController<void>.broadcast();
  bool _update = false;

  void announceUpdate() {
    _update = true;
    _updates.add(null);
  }

  @override
  Future<bool> persisted() async => persistedValue;
  @override
  Future<bool> requestPersist() async {
    persistRequests++;
    return persistedValue = true;
  }

  @override
  Future<StorageInfo?> estimate() async => info;
  @override
  bool get updateAvailable => _update;
  @override
  Stream<void> get onUpdateAvailable => _updates.stream;
  @override
  void applyUpdate() => applyUpdateCalls++;
  final downloads = <(String, String, List<int>)>[];
  @override
  Future<void> downloadFile(
    List<int> bytes,
    String fileName,
    String mimeType,
  ) async => downloads.add((fileName, mimeType, bytes));
  @override
  void setBadge(int count) => badge = count;
}
