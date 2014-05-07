define([], function() {
  'use strict';

  return (function() {

    /**
     * Microevent class (as from Backbone.js)
     */

    function MicroEvent() {

    }

    var MicroEventProto = MicroEvent.prototype;

    MicroEventProto.bind = function(event, fct) {
      this._events = this._events || {};
      this._events[event] = this._events[event] || [];
      this._events[event].push(fct);
    };

    MicroEventProto.unbind = function(event, fct) {
      this._events = this._events || {};
      if (event in this._events === false) {
        return;
      }
      this._events[event].splice(this._events[event].indexOf(fct), 1);
    };

    MicroEventProto.trigger = function(event /* , args... */) {
      var eventName,
        args;

      if (event instanceof $.Event) {
        eventName = event.type;
        args = Array.prototype.slice.call(arguments, 0);
      } else {
        eventName = event;
        args = Array.prototype.slice.call(arguments, 1);
      }
      this._events = this._events || {};

      if (eventName in this._events === false) {
        return event;
      }

      for (var i = 0, len = this._events[eventName].length; i < len; i++) {
        this._events[eventName][i].apply(this, args);
      }

      return event;
    };

    return MicroEvent;
  }());
});