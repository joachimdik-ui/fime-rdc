const CACHE_NAME = "fime-admin-shell-v2";
const APP_SHELL = [
  "./admin.html",
  "./manifest.webmanifest",
  "./supabase-config.js",
  "./favicon.ico",
  "./assets/logo.jpg",
  "./assets/pwa-icon-192.png",
  "./assets/pwa-icon-512.png"
];
const SUPABASE_CDN = "https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.45.4/dist/umd/supabase.js";

self.addEventListener("install", event => {
  event.waitUntil(Promise.all([
    caches.open(CACHE_NAME).then(cache => cache.addAll(APP_SHELL)),
    fetch(SUPABASE_CDN, {mode: "no-cors"}).then(response =>
      caches.open(CACHE_NAME).then(cache => cache.put(SUPABASE_CDN, response))
    ).catch(error => console.warn("Supabase SDK non mise en cache :", error))
  ]));
  self.skipWaiting();
});

self.addEventListener("activate", event => {
  event.waitUntil(
    caches.keys().then(keys => Promise.all(
      keys.filter(key => key.startsWith("fime-admin-shell-") && key !== CACHE_NAME)
        .map(key => caches.delete(key))
    )).then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", event => {
  const request = event.request;
  if (request.method !== "GET") return;

  if (request.url === SUPABASE_CDN) {
    event.respondWith(caches.match(request).then(cached => cached || fetch(request).then(response => {
      if (!response.ok && response.type !== "opaque") return response;
      return caches.open(CACHE_NAME).then(cache => cache.put(request, response.clone()).then(() => response));
    })));
    return;
  }

  const url = new URL(request.url);
  if (url.origin !== self.location.origin) return;

  const adminUrl = new URL("./admin.html", self.registration.scope);
  if (request.mode === "navigate" && url.pathname === adminUrl.pathname) {
    event.respondWith(fetch(request).then(response => {
      if (response.ok) caches.open(CACHE_NAME).then(cache => cache.put(adminUrl.href, response.clone()));
      return response;
    }).catch(async () => await caches.match(adminUrl.href) || Response.error()));
    return;
  }

  if (APP_SHELL.some(path => new URL(path, self.registration.scope).href === request.url)) {
    event.respondWith(caches.match(request).then(cached => cached || fetch(request)));
  }
});
