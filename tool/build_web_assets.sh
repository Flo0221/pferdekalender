#!/usr/bin/env bash
# Erzeugt die lokal ausgelieferten Web-Bausteine der Datenbank:
#  - web/drift_worker.js  (aus tool/web/drift_worker.dart kompiliert)
#  - web/sqlite3.wasm     (Release der verwendeten sqlite3-Version)
# Beide werden eingecheckt, damit der Web-Build ohne Downloads auskommt.
set -euo pipefail
cd "$(dirname "$0")/.."
SQLITE_VERSION=$(awk '/^  sqlite3:$/{f=1} f&&/version:/{gsub(/"/,"",$2);print $2;exit}' pubspec.lock)
echo "sqlite3 $SQLITE_VERSION"
dart compile js -O4 tool/web/drift_worker.dart -o web/drift_worker.js
rm -f web/drift_worker.js.deps web/drift_worker.js.map
curl -sSfL -o web/sqlite3.wasm \
  "https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-${SQLITE_VERSION}/sqlite3.wasm"
echo "OK: web/drift_worker.js, web/sqlite3.wasm"
