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

      /*
       Populate this array with the data attributes this module will use.
       Exclude 'data-mas-' prefix, as this is automatically added.

       For example: ['collapsible', 'only-first']
       */
      this.attrs = [];

      return this;
    }

    var MASModuleProto = MASModule.prototype = new MicroEvent();

    /**
     * Set the parent element for this context.
     * @param {[type]} $el [description]
     */
    MASModuleProto.setElement = function($el) {
      this.$el = $el;
      return this;
    };

    /**
     * Fetch the parent element
     * @return {Array} jQuery object or empty array (for safe jQuery ops)
     */
    MASModuleProto.getElement = function() {
      return this.$el || [];
    };

    /**
     * Get attribute from data attributes on element.
     * @param  {[type]} attr [description]
     * @return {[type]}      [description]
     */
    MASModuleProto.attr = function(attr) {
      return this.getElement().attr('data-mas-' + attr);
    };

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
