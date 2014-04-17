define(['MicroEvent'], function(MicroEvent) {
  'use strict';

  /**
   * This is used as the base class for all modules.
   * All modules/components should extend this class.
   *
   * Includes:
   *  event binding/triggering
   *  logging
   *  i18n library
   */
  return (function() {

    function MASModule() {
      return this;
    }

    var MASModuleProto = MASModule.prototype = new MicroEvent();

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