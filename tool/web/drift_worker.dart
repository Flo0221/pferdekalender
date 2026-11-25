// Quelle des Drift-Web-Workers. Neu erzeugen mit tool/build_web_assets.sh
// (ergibt web/drift_worker.js). Nicht in web/ ablegen, sonst wird die
// Dart-Quelle mit ausgeliefert.
import 'package:drift/wasm.dart';

void main() => WasmDatabase.workerMainForOpen();
