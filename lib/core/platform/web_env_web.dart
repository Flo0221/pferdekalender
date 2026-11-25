import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

import 'web_env.dart';

WebEnv createWebEnv() => BrowserWebEnv();

/// Browser: Speicher, Standalone-Erkennung und Update-Hinweis. Das
/// Gegenstück steht in web/index.html (`pkUpdateAvailable`, `pkApplyUpdate`,
/// Ereignis `pk-update-available`).
class BrowserWebEnv implements WebEnv {
  BrowserWebEnv() {
    web.window.addEventListener(
      'pk-update-available',
      ((web.Event _) => _updates.add(null)).toJS,
    );
  }

  final _updates = StreamController<void>.broadcast();

  @override
  bool get isWeb => true;

  @override
  bool get isStandalone {
    if (web.window.matchMedia('(display-mode: standalone)').matches) {
      return true;
    }
    // iOS Safari: navigator.standalone
    final v = web.window.navigator.getProperty<JSAny?>('standalone'.toJS);
    return v.isA<JSBoolean>() && (v as JSBoolean).toDart;
  }

  @override
  bool get isAppleMobile {
    final nav = web.window.navigator;
    final ua = nav.userAgent;
    if (RegExp('iPhone|iPad|iPod').hasMatch(ua)) return true;
    // iPadOS meldet sich als Mac, hat aber Touch.
    return ua.contains('Macintosh') && nav.maxTouchPoints > 1;
  }

  @override
  Future<bool> persisted() async {
    try {
      return (await web.window.navigator.storage.persisted().toDart).toDart;
    } on Object {
      return false;
    }
  }

  @override
  Future<bool> requestPersist() async {
    try {
      return (await web.window.navigator.storage.persist().toDart).toDart;
    } on Object {
      return false;
    }
  }

  @override
  Future<StorageInfo?> estimate() async {
    try {
      final e = await web.window.navigator.storage.estimate().toDart;
      return StorageInfo(usageBytes: e.usage, quotaBytes: e.quota);
    } on Object {
      return null;
    }
  }

  @override
  bool get updateAvailable {
    final v = web.window.getProperty<JSAny?>('pkUpdateAvailable'.toJS);
    return v.isA<JSBoolean>() && (v as JSBoolean).toDart;
  }

  @override
  Stream<void> get onUpdateAvailable => _updates.stream;

  @override
  void applyUpdate() {
    if (web.window.has('pkApplyUpdate')) {
      web.window.callMethod<JSAny?>('pkApplyUpdate'.toJS);
    } else {
      web.window.location.reload();
    }
  }

  @override
  void setBadge(int count) {
    final nav = web.window.navigator as JSObject;
    try {
      if (count > 0 && nav.has('setAppBadge')) {
        nav.callMethod<JSAny?>('setAppBadge'.toJS, count.toJS);
      } else if (count == 0 && nav.has('clearAppBadge')) {
        nav.callMethod<JSAny?>('clearAppBadge'.toJS);
      }
    } on Object {
      // Badging API optional.
    }
  }
}
