// Prüft den Web-Build im echten Browser (Playwright/Chromium):
//  1. Erster Aufruf: ALLE Anfragen gehen an die eigene Herkunft.
//  2. App startet (Flutter-Bild erscheint), Datenbank öffnet.
//  3. Service Worker aktiv; zweiter Aufruf OFFLINE funktioniert.
// Aufruf: node tool/check_web_requests.mjs [build/web] [/pferdekalender/]
import { createServer } from 'node:http';
import { readFile, stat } from 'node:fs/promises';
import { extname, join, normalize } from 'node:path';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
const { chromium } = require('playwright');

const root = process.argv[2] ?? 'build/web';
const base = process.argv[3] ?? '/pferdekalender/';
const types = {
  '.html': 'text/html', '.js': 'text/javascript', '.mjs': 'text/javascript',
  '.json': 'application/json', '.wasm': 'application/wasm', '.png': 'image/png',
  '.ttf': 'font/ttf', '.otf': 'font/otf', '.css': 'text/css',
};

const server = createServer(async (req, res) => {
  let path = decodeURIComponent(new URL(req.url, 'http://x').pathname);
  if (!path.startsWith(base)) { res.writeHead(404).end(); return; }
  path = path.slice(base.length);
  if (path === '' || path.endsWith('/')) path += 'index.html';
  path = normalize(path);
  if (path.startsWith('..')) { res.writeHead(403).end(); return; }
  const file = join(root, path);
  try {
    if (!(await stat(file)).isFile()) throw 0;
    res.writeHead(200, {
      'content-type': types[extname(file)] ?? 'application/octet-stream',
      'cache-control': 'no-cache',
    });
    res.end(await readFile(file));
  } catch {
    res.writeHead(404).end();
  }
});
await new Promise((r) => server.listen(0, '127.0.0.1', r));
const origin = `http://127.0.0.1:${server.address().port}`;
const url = origin + base;

const browser = await chromium.launch();
const context = await browser.newContext();
const page = await context.newPage();
const foreign = [];
const notFound = [];
const errors = [];
context.on('request', (r) => {
  const u = r.url();
  if (!u.startsWith(origin) && !u.startsWith('data:') && !u.startsWith('blob:')) foreign.push(u);
});
context.on('response', (r) => { if (r.status() === 404) notFound.push(r.url()); });
page.on('pageerror', (e) => errors.push(String(e)));

let failed = false;
const fail = (msg) => { console.error('FEHLER: ' + msg); failed = true; };

await page.goto(url);
// Flutter zeigt das erste Bild → Ladebildschirm verschwindet.
await page.waitForSelector('#loading', { state: 'detached', timeout: 60000 })
  .catch(() => fail('App ist nicht gestartet (Ladebildschirm bleibt)'));
// Warten, bis der Service Worker alles vorab geladen hat und aktiv ist.
await page.waitForFunction(
  async () => (await navigator.serviceWorker.getRegistration())?.active?.state === 'activated',
  null, { timeout: 60000, polling: 500 },
).then(() => console.log('OK: Service Worker aktiv'))
  .catch(() => fail('Service Worker nicht aktiv'));

const state = await page.evaluate(async () => ({
  controlled: !!navigator.serviceWorker.controller,
  caches: await caches.keys(),
  cached: (await (await caches.open((await caches.keys())[0])).keys()).length,
}));
console.log('Service Worker:', JSON.stringify(state));
// Offline neu laden
await context.setOffline(true);
await page.reload();
await page.waitForSelector('#loading', { state: 'detached', timeout: 60000 })
  .then(() => console.log('OK: startet offline'))
  .catch(() => fail('App startet offline nicht'));
await page.waitForTimeout(2000);
await page.screenshot({ path: process.env.SCREENSHOT ?? '/dev/null' }).catch(() => {});
await context.setOffline(false);

if (foreign.length) fail('Anfragen an fremde Server:\n  ' + [...new Set(foreign)].join('\n  '));
else console.log('OK: nur Anfragen an die eigene Herkunft');
if (notFound.length) console.warn('Hinweis 404:\n  ' + [...new Set(notFound)].join('\n  '));
if (errors.length) fail('JavaScript-Fehler:\n  ' + errors.join('\n  '));

await browser.close();
server.close();
process.exit(failed ? 1 : 0);
