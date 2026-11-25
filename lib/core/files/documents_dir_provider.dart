import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

/// App-Dokumentenverzeichnis (Datenbank, Fotos). In Tests überschreiben.
final documentsDirProvider = FutureProvider<Directory>(
  (ref) => getApplicationDocumentsDirectory(),
);
