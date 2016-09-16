define(['globals'], function(globals) {
  'use strict';

  var izHelpers = {
    getCookie: function(cname) {
      var name = cname + '=';
      var ca = document.cookie.split(';');
      for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') {
          c = c.substring(1);
        }
        if (c.indexOf(name) === 0) {
          return c.substring(name.length, c.length);
        }
      }
      return '';
    },
    setShowCookie: function(days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      var expires = '; expires=' + date.toUTCString();
      document.cookie = 'izHideSurvey=true' + expires + '; path=/';
      document.cookie = 'izCount=0; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/';
    },
    incrementCountCookie: function() {
      var count = this.getCountCookie() + 1;
      document.cookie = 'izCount=' + count + '; path=/';
    },
    getCountCookie: function() {
      var timesShown = this.getCookie('izCount');
      if (!timesShown) {
        timesShown = 0;
      }
      return parseInt(timesShown);
    }
  };

  var informizelyTag = {
    handleIzEvent: function(event, surveyId, surveyName, data, api) {
      if (event === 'SurveyStart') {
        izHelpers.incrementCountCookie();
      } else if (event === 'SurveyDone') {
        if (data.closeAction === 2 || api.getResults().length === 0) {
          // The survey has been closed prematurely
          izHelpers.setShowCookie(14);
        } else {
          // The survey has been completed
          izHelpers.setShowCookie(90);
        }
      }
    },
    init: function() {
      // If already shown three times, set the cookie to hide the survey
      if (izHelpers.getCountCookie() >= 3) {
        izHelpers.setShowCookie(14);
      }
      // Informizely snippet from informizely.com
      window.IzWidget = window.IzWidget || {};
      window.IzWidget.tracker = this.handleIzEvent;

      (function(d) {
        var scriptElement = d.createElement('script');
        scriptElement.type = 'text/javascript';
        scriptElement.async = true;
        scriptElement.src = 'https://insitez.blob.core.windows.net/site/' +
        globals.bootstrap.informizelyKey + '.js';
        d.body.appendChild(scriptElement);
      })(document);
    }
  };

  return informizelyTag;
});
