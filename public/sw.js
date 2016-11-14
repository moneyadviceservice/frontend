/*
This basically works but with some issues.
Good starting point though
**/

// When the SW is installed, cache the assets required to display the offlinePage content
this.addEventListener('install', function(event) {
  console.log('install!')

  var urlsToCache = [
        'en/offline_page',
        'cy/offline_page'
      ];

  event.waitUntil(
    // open a cache named 'mas-offline-page'
    caches.open('mas-offline-page').then(function(cache) {
      console.log('waitUntil!')

      // add the urls in urlsToCache to opened cache
      return cache.addAll(urlsToCache);
    })
  );
});

// Test for network and use response if available, otherwise use offlinePage content
this.addEventListener('fetch', function(event) {
  event.respondWith(
    fetch(event.request).then(function(response) {
      return response;
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
