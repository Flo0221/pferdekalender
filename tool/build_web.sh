#!/usr/bin/env bash
# Release-Build der Web-App (PWA), komplett ohne CDN:
#   tool/build_web.sh [base-href]   (Standard: /pferdekalender/ für GitHub Pages)
# Danach liegt alles in build/web; tool/check_web_requests.mjs prüft, dass
# zur Laufzeit nur die eigene Herkunft angefragt wird.
set -euo pipefail
cd "$(dirname "$0")/.."
BASE="${1:-/pferdekalender/}"
flutter build web --release --no-web-resources-cdn --no-source-maps --base-href "$BASE"
python3 tool/finalize_web_build.py build/web
