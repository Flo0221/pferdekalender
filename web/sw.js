// Pferdekalender – Service Worker (Offline + Update-Hinweis).
// VERSION und PRECACHE werden nach dem Build von tool/finalize_web_build.py
// eingesetzt. Nur gleiche Herkunft; fremde Server werden nie angefragt.
'use strict';

const VERSION = '__PK_VERSION__';
const CACHE = 'pferdekalender-' + VERSION;
const PRECACHE = __PK_PRECACHE__;

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE).then((cache) =>
      cache.addAll(PRECACHE.map((p) => new Request(p, { cache: 'reload' })))
    )
  );
  // Kein skipWaiting(): die App fragt erst nach („Neue Version verfügbar“).
});

self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    (async () => {
      const keys = await caches.keys();
      await Promise.all(
        keys.filter((k) => k.startsWith('pferdekalender-') && k !== CACHE)
            .map((k) => caches.delete(k))
      );
      await self.clients.claim();
    })()
  );
});

self.addEventListener('fetch', (event) => {
  const req = event.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return;
  // Der Service Worker selbst wird nie aus dem Cache geliefert.
  if (url.pathname.endsWith('/sw.js')) return;

  event.respondWith(
    (async () => {
      const cache = await caches.open(CACHE);
      // Seitenaufrufe (auch mit #-Routen) → index.html aus dem Cache.
      if (req.mode === 'navigate') {
        const index = await cache.match('index.html') || await cache.match('./');
        if (index) return index;
      }
      const hit = await cache.match(req, { ignoreSearch: true });
      if (hit) return hit;
      try {
        const res = await fetch(req);
        if (res.ok) cache.put(req, res.clone());
        return res;
      } catch (e) {
        return new Response('', { status: 504, statusText: 'offline' });
      }
    })()
  );
});
