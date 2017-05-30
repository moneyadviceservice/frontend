/* When the SW is installed, cache the assets required to display the offlinePage content
self.addEventListener('install', function(event) {
  var initialAssetsToCache = [
    '/en/offline_page',
    '/cy/offline_page'
  ];

  event.waitUntil(
    // open a cache named 'mas-offline-page'
    caches.open('mas-offline-page').then(function(cache) {
      // add the urls in urlsToCache to opened cache
      return cache.addAll(initialAssetsToCache, {credentials: 'same-origin'})
    })
  );
});
*/

// Test for network and use response if available plus cache assets, otherwise use offlinePage content
self.addEventListener('fetch', function(event) {
  if (event.request.url.match(/\/en$/) || event.request.url.match(/\/en\//)) {
    caches.open('mas-offline-page').then(function(cache) {
      return cache.add('/en/offline_page', {credentials: 'same-origin'})
    })
  } else if (event.request.url.match(/\/cy$/) || event.request.url.match(/\/cy\//)) {
    caches.open('mas-offline-page').then(function(cache) {
      return cache.add('/cy/offline_page', {credentials: 'same-origin'})
    })
  } else if (event.request.url.indexOf('logo-sprite-en') != -1) {
    caches.open('mas-offline-page').then(function(cache) {
      cache.add(event.request.url);
    })
  } else if (event.request.url.indexOf('logo-sprite-cy') != -1) {
    caches.open('mas-offline-page').then(function(cache) {
      cache.add(event.request.url);
    })
  } else if (event.request.url.indexOf('basic') != -1) {
    caches.open('mas-offline-page').then(function(cache) {
      cache.add(event.request.url);
    })
  } else if (event.request.url.indexOf('enhanced_responsive') != -1) {
    caches.open('mas-offline-page').then(function(cache) {
      cache.add(event.request.url);
    })
  }

  event.respondWith(
    fetch(event.request).then(function(response) {
      return response
    }).catch(function() {
      // send response from the cache
      if (event.request.url.match(/\/en$/) || event.request.url.match(/\/en\//)) {
        return caches.match('/en/offline_page');
      } else if (event.request.url.match(/\/cy$/) || event.request.url.match(/\/cy\//)) {
        return caches.match('/cy/offline_page');
      } else if (event.request.url.match(/logo-sprite-en/)) {
        return caches.match(event.request.url);
      } else if (event.request.url.match(/logo-sprite-cy/)) {
        return caches.match(event.request.url);
      } else if (event.request.url.match(/basic/)) {
        return caches.match(event.request.url);
      } else if (event.request.url.match(/enhanced_responsive/)) {
        return caches.match(event.request.url);
      }
    })
  );
});
