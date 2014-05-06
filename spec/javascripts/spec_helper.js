//= require sinonjs/sinon
//= require requirejs/require
//= require require_config
//= require jquery
var expect = chai.expect;

// Any properties that require Ruby @ runtime

var require = {
  config: {
    globals: (function() {
      var MAS = {};

      MAS.bootstrap = {
        env: 'production',
        timestamp: new Date().getTime(),
        I18nLocale: 'en'
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
    }());
  }
}
