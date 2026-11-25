import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/app_info.dart';

void main() {
  test('appVersion entspricht der Version in pubspec.yaml', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final version = RegExp(
      r'^version:\s*(\S+)',
      multiLine: true,
    ).firstMatch(pubspec)!.group(1);
    expect(appVersion, version);
  });
}
