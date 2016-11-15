/*
This basically works but with some issues.
Good starting point though
**/

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
      // cache all the required assets each time
      // this works but does it affect performance?
      if (response.ok) {
        cacheAssets()
      }
      return response
    }).catch(function() {
      // send response from the cache
      if (event.request.url.indexOf('/en') != -1) {
        return caches.match('en/offline_page')
      } else {
        return caches.match('cy/offline_page')
      }
    })
  );
});

function cacheAssets() {
  var urlsToCache = [
    'en/offline_page',
    'cy/offline_page'
  ];

  // open a cache named 'mas-offline-page'
  caches.open('mas-offline-page').then(function(cache) {
    // add the urls in urlsToCache to opened cache
    return cache.addAll(urlsToCache)
  })
}
