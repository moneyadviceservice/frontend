define([MAS.bootstrap.I18nLocale, 'log'], function(i18n, log) {

  /**
   * This is used as the base class for all modules.
   * All modules/components should extend this class.
   *
   * Includes:
   *  event binding/triggering
   *  logging
   *  i18n library
   */
  return (function MASModule() {

    function MASModule() {
      return this;
    }

    var MASModuleProto = MASModule.prototype;

    MASModuleProto.bind = function(event, fct){
      this._events = this._events || {};
      this._events[event] = this._events[event] || [];
      this._events[event].push(fct);
    };

    MASModuleProto.unbind = function(event, fct){
      this._events = this._events || {};
      if( event in this._events === false ) { return; }
      this._events[event].splice(this._events[event].indexOf(fct), 1);
    };

    MASModuleProto.trigger = function(event /* , args... */) {
      var eventName,
        args;

      if (event instanceof $.Event) {
        eventName = event.type;
        args = Array.prototype.slice.call(arguments, 0);
      }
      else {
        eventName = event;
        args = Array.prototype.slice.call(arguments, 1);
      }
      this._events = this._events || {};

      if ( eventName in this._events === false  ) { return event; }

      for (var i = 0, len = this._events[eventName].length; i < len; i++) {
        this._events[eventName][i].apply( this, args );
      }

      return event;
    };


    /**
     * Attach i18n strings and logger
     */
    MASModuleProto.i18n = i18n;
    MASModuleProto.log = log;


    /**
     * All MASModules (if applicable) should have this method,
     * which will unbind all events it attached when initialising itself.
     *
     * After this has been run, you can safely run 'delete [[instance]]' to remove it from memory.
     *
     * @return {[type]}
     */
    MASModuleProto.destroy = function() {
      return this;
    };

    return MASModule;

  }());
});