#!/usr/bin/env bash
# Sucht im Repo (eingecheckte Dateien) nach Schlüsseln, Keystores und
# Passwörtern. Läuft im CI vor jedem Web-Deploy und vor dem Veröffentlichen.
set -euo pipefail
cd "$(dirname "$0")/.."
fail=0
if git ls-files | grep -iE '\.(jks|keystore|p12|pem|key|mobileprovision)$|key\.properties$|(^|/)\.env|google-services\.json|GoogleService-Info\.plist'; then
  echo "FEHLER: Schlüssel-/Konfigurationsdatei eingecheckt (siehe oben)"; fail=1
fi
pattern='(ghp_[A-Za-z0-9]{20,}|github_pat_|AKIA[0-9A-Z]{16}|BEGIN [A-Z ]*PRIVATE KEY|storePassword|keyPassword|xox[baprs]-|AIza[0-9A-Za-z_-]{30,})'
if git grep -nIE "$pattern" -- . ':!tool/check_secrets.sh'; then
  echo "FEHLER: mögliches Secret im Code (siehe oben)"; fail=1
fi
[ $fail -eq 0 ] && echo "OK: keine Secrets, Keystores oder Schlüsseldateien gefunden"
exit $fail
