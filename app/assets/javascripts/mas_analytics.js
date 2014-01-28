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
  };

  // Private func to handle scrollTracking events
  this._handleScroll = function(dir, val){
    MAS.log('mas_analytics._handleScroll - ', arguments);

    // Only interested in down events
    if(dir === 'up') return;

    // check if already triggered, ## might be a .once equivelant
    if(_this._calledAlready.indexOf('scrollTracking-'+val) !== -1) return;

    // Unbind to prevent future events - as all events are
    _this._calledAlready.push('scrollTracking-'+val);

    // get offset time from pageload - can we get from google?
    var eventdelay = ((new Date().getTime()) -  MAS.timestamp)/1000;

    // push to datalayer OR MAS abstracted datalayer
    _this.triggerAnalytics({
      name:'test analytics call',
      type: 'scrollTracking',
      val: val,
      eventdelay: eventdelay,
      loadDelay: loadDelay,
      combinedDelay: eventdelay - loadDelay
    });
  }

  // Tracks user scrolling down to different parts of page
  this.scrollTracking = function(opts){
    if(!opts || !$(opts.el).length || !opts.triggerPoints) return MAS.warn('mas_analytics.scrollTracking - missing element or triggerPoints', opts);

    var $el = $(opts.el),
      h = $el.outerHeight(),
      wh = $.waypoints('viewportHeight'); // normalises $(window).height()

    $.each(opts.triggerPoints,function(i,val){
      MAS.info('mas_analytics.scrollTracking (bind each) - ', val);
      var offsetVal = h*val - wh;
      $el.waypoint(function(dir){
        _this._handleScroll(dir,val);
      }, {offset: -offsetVal});
    })
  }

  return {
    triggerAnalytics: this.triggerAnalytics,
    scrollTracking: this.scrollTracking
  }

});
