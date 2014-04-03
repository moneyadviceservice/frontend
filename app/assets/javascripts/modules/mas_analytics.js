/*
 MAS_analytics.js
 - contains all analytic methods required throught the site
 - standard event binding is handles by GTM (google tag manager)
 - modules can require this and then call analytics.trigger()
 - we could extend this to use pubSub so remove the possible depandancy
 */

define(['jquery','log', 'waypoints'], function ($, log, WP) {

  'use strict';

  var onloadTimestamp = window.MAS.bootstrap.timestamp,
      DL = window.dataLayer || [],
      loadDelay = ((new Date().getTime()) - onloadTimestamp) / 1000,
      analytics = {},
      _calledAlready = [],
      _handleScroll;

  // Private func to handle scrollTracking events
  _handleScroll = function (dir, val, contentRatio) {
    log.log('mas_analytics._handleScroll - ', arguments);

    // Only interested in down events
    if (dir === 'up') return false;

    // check if already triggered, ## might be a .once equivelant
    if (_calledAlready.indexOf('scrollTracking-' + val) !== -1) return;

    // Unbind to prevent future events - as all events are
    _calledAlready.push('scrollTracking-' + val);

    // get offset time from pageload - can we get from google?
    var eventdelay = ((new Date().getTime()) - onloadTimestamp) / 1000,
      combinedDelay = eventdelay - loadDelay;

    // push to datalayer OR MAS abstracted datalayer
    analytics.trigger({
      // GA event data
      'gaEventCat': 'Scroll Tracking',
      'gaEventAct': val,
      'gaEventLab': combinedDelay + '',
      'gaEventVal': combinedDelay,
      'gaEventNonint': true,
      'event': 'gaEvent',
      // Custom additional data
      'eventdelay': eventdelay,
      'loadDelay': loadDelay,
      'combinedDelay': combinedDelay,
      'contentRatio': contentRatio
    });
  };

  // General call to trigger GA analytics
  analytics.trigger = function (data) {
    log.log('mas_analytics.triggerAnalytics', data);
    DL.push(data);
  };

  // Tracks user scrolling down to different parts of page
  analytics.scrollTracking = function (opts) {

    function areOptionsValid() {
      return (!opts || !$(opts.el).length || !opts.triggerPoints || !$.isArray(opts.triggerPoints));
    }

    if (areOptionsValid()) {
      log.warn('mas_analytics.scrollTracking - missing element or triggerPoints', opts);
      return false;
    }

    var $el = $(opts.el),
      h = $el.outerHeight(),
      wh = $.waypoints('viewportHeight'), // normalises $(window).height()
      contentRatio = $el.outerHeight() / wh;

    // send ratioCalculated event
    // used by analytics events to determine page size and meaninfulness of scroll event
    analytics.trigger({
      'contentRatio': contentRatio,
      'event': 'ratioCalculated'
    });

    // Bind event for each trigger point
    $.each(opts.triggerPoints, function (i, val) {
      var offsetVal = h * val - wh;

      $el.waypoint(function (dir) {
        _handleScroll(dir, val, contentRatio);
      }, {offset: -offsetVal});
    });
  };



  return analytics;
});
