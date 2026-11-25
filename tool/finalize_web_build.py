#!/usr/bin/env python3
"""Nach `flutter build web`: Service-Worker-Liste und Version einsetzen.

- build/web/sw.js: VERSION = Hash über alle Dateien, PRECACHE = alle Dateien
  (inkl. wasm, Worker, Schriften, Icons) relativ zum Scope.
- Entfernt Flutters veralteten flutter_service_worker.js (meldet sich nur ab)
  und Source-Maps.
"""
import hashlib, json, pathlib, sys

root = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else "build/web")
for junk in ["flutter_service_worker.js", "flutter.js.map", "main.dart.js.map"]:
    (root / junk).unlink(missing_ok=True)

files = sorted(
    p for p in root.rglob("*")
    if p.is_file() and p.name not in {"sw.js", ".last_build_id"}
)
h = hashlib.sha256()
for p in files:
    h.update(p.relative_to(root).as_posix().encode())
    h.update(p.read_bytes())
version = h.hexdigest()[:12]
precache = ["./"] + [p.relative_to(root).as_posix() for p in files]

sw = (root / "sw.js").read_text(encoding="utf-8")
if "__PK_VERSION__" not in sw:
    sys.exit("sw.js enthält keine Platzhalter – schon finalisiert?")
sw = sw.replace("'__PK_VERSION__'", json.dumps(version))
sw = sw.replace("__PK_PRECACHE__", json.dumps(precache, indent=1))
(root / "sw.js").write_text(sw, encoding="utf-8")
total = sum(p.stat().st_size for p in files)
print(f"sw.js: Version {version}, {len(precache)} Dateien, {total / 1e6:.1f} MB")
