// When the SW is installed, cache the assets required to display the offlinePage content
self.addEventListener('install', function(event) {
  event.waitUntil(
    cacheAssets()
  );
});

// Test for network and use response if available plus cache assets, otherwise use offlinePage content
self.addEventListener('fetch', function(event) {
  event.respondWith(
    fetch(event.request).then(function(response) {
      caches.open('mas-offline-page').then(function(cache) {
        return caches.match(event.request);
      })

      return response
    }).catch(function() {
      // send response from the cache
      if (event.request.url.match(/\/en$/) || event.request.url.match(/\/en\//)) {
        return caches.match('/en/offline_page');
      } else if (event.request.url.match(/\/assets\/logo-sprite-en.png/)) {
        return caches.match('/assets/logo-sprite-en.png');
      } else if (event.request.url.match(/\/cy$/) || event.request.url.match(/\/cy\//)) {
        return caches.match('/cy/offline_page');
      } else if (event.request.url.match(/\/assets\/logo-sprite-cy.png/)) {
        return caches.match('/assets/logo-sprite-cy.png');
      }
    })
  );
});

function cacheAssets() {
  var urlsToCache = [
    '/assets/logo-sprite-en.png',
    '/assets/logo-sprite-cy.png',
    '/assets/dough/assets/stylesheets/basic.css',
    '/assets/enhanced_responsive.css',
    'en/offline_page',
    'cy/offline_page'
  ];

  // open a cache named 'mas-offline-page'
  caches.open('mas-offline-page').then(function(cache) {
    // add the urls in urlsToCache to opened cache
    return cache.addAll(urlsToCache)
  })
}
