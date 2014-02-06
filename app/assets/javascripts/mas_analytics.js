/*
 
MAS_analytics.js
- this should contain all analytic methods required throught the site
- current idea is to require this, then call .triggerAnalytics, 
- an alternative would be to use pubsub, but this is better for fire & forget

*/


define(['jquery', 'waypoints'],function ($) {
  
  var _this = this,
    loadDelay = ((new Date().getTime()) -  MAS.timestamp)/1000;

  // Cache analytics calls so we can prevent duplicate
  this._calledAlready = [];

  // General call to trigger GA analytics
  this.triggerAnalytics = function(data){
    MAS.log('mas_analytics.triggerAnalytics', data);
    MAS.datalayer.push(data);
    // dataLayer.push(data);
  };

  // Private func to handle scrollTracking events
  this._handleScroll = function(dir, val, contentRatio){
    MAS.log('mas_analytics._handleScroll - ', arguments);

    // Only interested in down events
    if(dir === 'up') return false;

    // check if already triggered, ## might be a .once equivelant
    if(_this._calledAlready.indexOf('scrollTracking-'+val) !== -1) return;

    // Unbind to prevent future events - as all events are 
    _this._calledAlready.push('scrollTracking-'+val);

    // get offset time from pageload - can we get from google?
    var eventdelay = ((new Date().getTime()) -  MAS.timestamp)/1000,
      combinedDelay = eventdelay - loadDelay;

    // push to datalayer OR MAS abstracted datalayer
    _this.triggerAnalytics({
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
  }

  // Tracks user scrolling down to different parts of page
  this.scrollTracking = function(opts){
    function areOptionsValid(){
       return (!opts || !$(opts.el).length || !opts.triggerPoints || !$.isArray(opts.triggerPoints))
    };

    if( areOptionsValid() ){
      MAS.warn('mas_analytics.scrollTracking - missing element or triggerPoints', opts);
      // console.warn('mas_analytics.scrollTracking - missing element or triggerPoints', opts);
      return false;
    }

    var $el = $(opts.el),
      h = $el.outerHeight(),
      wh = $.waypoints('viewportHeight'); // normalises $(window).height()

    // get scroll content ratio = length of content / length of viewport
    var contentRatio = $el.outerHeight() / wh;

    // send ratioCalculated event - used by analytics events to determine page size and meaninfulness of scroll event
    // _this.triggerAnalytics({
    //  'contentRatio': contentRatio,
    //  'event': 'ratioCalculated'
    // });

    // Bind event for each trigger point
    $.each(opts.triggerPoints,function(i,val){
      MAS.info('mas_analytics.scrollTracking (bind each) - ', val);
      var offsetVal = h*val - wh;

      $el.waypoint(function(dir){
        _this._handleScroll(dir,val,contentRatio);
      }, {offset: -offsetVal});  

    })
  }

  return {
    triggerAnalytics: this.triggerAnalytics,
    scrollTracking: this.scrollTracking
  }
});
