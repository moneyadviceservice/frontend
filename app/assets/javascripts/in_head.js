console.info('in_head.js loaded');

// Money Advice global namespace
var MAS = window.MAS || {};

(function(d, w){
  // JS is enabled, add class .js to html, also based on feature support add .js-advanced or .js-basic
  MAS.jsSupport = ('querySelector' in d && 'localStorage' in w  && 'addEventListener' in w)? 'advanced' : 'basic';

  // Update className
  var el = d.getElementsByTagName('html')[0];
  el.className = el.className.replace('no-js','js js-'+ MAS.jsSupport);
})(document, window);

// For GoogleTagManager
MAS.datalayer = dataLayer = [];

// For analytics to work out time user has been on page when the do an interaction
MAS.timestamp = new Date().getTime();