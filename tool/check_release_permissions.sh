#!/usr/bin/env bash
# Prüft ein gebautes Release-APK: keine Netzwerk-Permissions, Backup aus.
# Aufruf: tool/check_release_permissions.sh [pfad/zur.apk]
set -euo pipefail
APK="${1:-build/app/outputs/flutter-apk/app-release.apk}"
AAPT="$(ls -d "${ANDROID_HOME:?ANDROID_HOME setzen}"/build-tools/*/ | sort -V | tail -1)aapt"

echo "Permissions in $APK:"
"$AAPT" dump permissions "$APK"

if "$AAPT" dump permissions "$APK" | grep -qE "android.permission.(INTERNET|ACCESS_NETWORK_STATE|ACCESS_WIFI_STATE)"; then
  echo "FEHLER: Netzwerk-Permission im Release-APK gefunden!" >&2
  exit 1
fi
MANIFEST="$("$AAPT" dump xmltree "$APK" AndroidManifest.xml)"
grep -q "android:allowBackup(0x01010280)=(type 0x12)0x0" <<<"$MANIFEST" \
  || { echo "FEHLER: allowBackup ist nicht false" >&2; exit 1; }
grep -q "android:dataExtractionRules" <<<"$MANIFEST" \
  || { echo "FEHLER: dataExtractionRules fehlt" >&2; exit 1; }
echo "OK: keine Netzwerk-Permission, Auto-Backup aus."
