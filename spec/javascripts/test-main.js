require.config({
  baseUrl: '/base',
  callback: window.__karma__.start,
  paths: {
    // Translation JSON files
    en: 'app/assets/javascripts/translations/en',
    cy: 'app/assets/javascripts/ttranslations/cy',

    i18nTokens: 'app/assets/javascripts/translations/en',

    // External dependancies
    jquery: 'vendor/assets/bower_components/jquery/dist/jquery',
    waypoints: 'vendor/assets/bower_components/jquery-waypoints/waypoints',
    ujs: 'vendor/assets/bower_components/jquery-ujs/src/rails',
    eventsWithPromises: 'vendor/assets/bower_components/eventsWithPromises/src/eventsWithPromises',
    typeahead: 'vendor/assets/bower_components/typeahead.js/dist/typeahead.jquery',

    // Internal modules
    DoughBaseComponent: 'vendor/assets/bower_components/dough/assets/js/components/DoughBaseComponent',
    featureDetect: 'vendor/assets/bower_components/dough/assets/js/lib/featureDetect',

    globals: 'app/assets/javascripts/modules/globals',
    common: 'app/assets/javascripts/modules/common',
    log: 'app/assets/javascripts/modules/log',
    i18n: 'app/assets/javascripts/modules/i18n',

    pubsub: 'app/assets/javascripts/modules/mas_pubsub',
    scrollTracking: 'app/assets/javascripts/modules/mas_scrollTracking',
    collapsable: 'app/assets/javascripts/modules/mas_collapsable',
    googleComplete: 'app/assets/javascripts/modules/google_complete',

    // Dough components
    ClearInput: 'app/assets/javascripts/components/ClearInput',
    Newsletter: 'app/assets/javascripts/components/Newsletter',
    NewsletterSticky: 'app/assets/javascripts/components/NewsletterSticky',
    StickyColumn: 'app/assets/javascripts/components/StickyColumn',
    EmbedCodeGenerator: 'app/assets/javascripts/components/EmbedCodeGenerator',

    rsvp: 'vendor/assets/bower_components/rsvp/rsvp',

    utilities: 'vendor/assets/bower_components/dough/assets/js/lib/utilities',
    componentLoader: 'vendor/assets/bower_components/dough/assets/js/lib/componentLoader',
    RangeInput: 'vendor/assets/bower_components/dough/assets/js/components/RangeInput',
    TabSelector: 'vendor/assets/bower_components/dough/assets/js/components/TabSelector'
  },
  shim: {
    'ujs': ['jquery'],
    'typeahead': ['jquery']
  },
  config: {
    globals: (function() {
      var MAS = {};

      MAS.bootstrap = {
        env: 'production',
        timestamp: new Date().getTime(),
        I18nLocale: 'en',
        googleApiCx: '123'
      };

      MAS.supports = (function(w,d){
        var S = {};
        function supportTest(prop, context){
          try {
            return prop in context && context[prop] !== null;
          } catch (e) {
            return false;
          }
        }

        S.fonts = false; // Required for webfont loader to work, default false, set true in view/base
        S.js = ( supportTest('querySelector',d) && supportTest('localStorage',w) && supportTest('addEventListener',w) ) ? 'advanced' : 'basic';
        S.touch = ( supportTest('ontouchstart', w) || supportTest('onmsgesturechange',w) );
        S.localstorage = supportTest('localStorage', w);

        return S;
      })(window, document);

      return MAS;
    }())
  }
});
