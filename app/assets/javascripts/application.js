console.info('Application.js');

// This can be wrapper so in prod it outputs to MAS.log rather than console
if(MAS.env === 'development'){
  MAS.log = console.log;
  MAS.info = console.info;
  MAS.warn = console.warn;
}else{
  MAS.logged = [];
  MAS.log = function(name, options){ MAS.logged.push(name, options, 'log') };
  MAS.info = function(name, options){ MAS.logged.push(name, options, 'info') };
  MAS.warn = function(name, options){ MAS.logged.push(name, options, 'warn') };
}


// Setup requireJS config
requirejs.config({
  baseUrl: '/assets',
  paths: {
    pubsub: 'jquery-tiny-pubsub/src/tiny-pubsub',
    waypoints: 'jquery-waypoints/waypoints',
    webfonts: '//ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont'
  },
  shim: {
    'pubsub': ['jquery'],
    'waypoints': ['jquery']
  }
});


// If fonts supported, load them! Config + fontSupport set in base.html head
if(MAS.fontSupport){
  require(['webfonts'], function(){
    WebFont.load(MAS.fontConfig);
  })
}

// Load analytics
require(['mas_analytics'], function(analytics) {

  MAS.analytics = analytics;
  // Initiate analytics & pass in config
  analytics.scrollTracking({
    el: '.editorial',
    triggerPoints: [0.25, 0.5, 0.75, 1]
  });

});

// require(['jquery', 'pubsub', 'waypoints'], function($, pubsub, waypoints) {
//   console.log( $.subscribe )
//   console.log( $.waypoints )

//   // function handle(e, a, b, c) {
//   //   // `e` is the event object, you probably don't care about it.
//   //   console.info(a + b + c);
//   // };
//   // $.subscribe("/some/topic", handle);
//   // $.publish("/some/topic", [ "a", "b", "c" ]);
// });
