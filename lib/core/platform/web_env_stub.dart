import 'web_env.dart';

WebEnv createWebEnv() => const NativeWebEnv();

/// Android/iOS: keine Browser-Funktionen.
class NativeWebEnv implements WebEnv {
  const NativeWebEnv();
  @override
  bool get isWeb => false;
  @override
  bool get isStandalone => true;
  @override
  bool get isAppleMobile => false;
  @override
  Future<bool> persisted() async => true;
  @override
  Future<bool> requestPersist() async => true;
  @override
  Future<StorageInfo?> estimate() async => null;
  @override
  bool get updateAvailable => false;
  @override
  Stream<void> get onUpdateAvailable => const Stream.empty();
  @override
  void applyUpdate() {}
  @override
  void setBadge(int count) {}
}
