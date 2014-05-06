define(['jquery', 'MASModule'], function ($, MASModule) {
  'use strict';

  return (function() {
    /**
     * Set up a new toggler.
     *
     * Requires an element to have a data-mas-toggler attribute. The application
     * file will spawn an instance
     * of this class for each element it finds on the page.
     *
     * Events used: toggler:toggled(element, isShown) [Event for when the toggler is doing its work]
     *
     * @param {Object} $el
     */
    function Toggler($el) {
      this.setElement($el);
      this.attrs = ['toggler'];

      this.init();

      return this;
    }

    /**
     * Inherit from base module, for shared methods and interface
     * @type {[type]}
     */
    var TogglerProto = Toggler.prototype = new MASModule();

    /**
     * Init function
     * @return {[type]}
     */
    TogglerProto.init = function() {
      this.$target = $(this.attr('toggler'));
      this.isShown = !!this.$target.hasClass('show'); // is the target element visible already

      return this.setListeners(true);
    };

    /**
     * Bind or unbind relevant DOM events
     * @param {Boolean} to Set to 'true' to bind to events, 'false' to unbind.
     */
    TogglerProto.setListeners = function(to) {
      this.$el[ to ? 'on' : ' off']('click', $.proxy(function(e) {
        this.toggle();

        e.preventDefault();
      }, this));

      return this;
    };

    /**
     * Toggle the element
     * @param  {[type]} forceTo Supply 'show' or 'hide' to
     * explicitly set, otherwise will automatically toggle
     * @return {[type]}         [description]
     */
    TogglerProto.toggle = function(forceTo) {
      var func;

      // is there an override parameter?
      if (typeof forceTo !== 'undefined') {
        func = forceTo === 'show' ? 'addClass' : 'removeClass';
      }
      else {
        func = this.isShown ? 'removeClass' : 'addClass';
      }

      // toggle the element
      this.isShown = !!this.$target[func]('show').hasClass('show');

      // toggle the class on the trigger element (active = shown / nothing = not shown)
      this.$el[func]('active');

      // can bind to this by toggler.bind('toggler:toggled', function(Toggler) { });
      if (typeof forceTo === 'undefined') {
        this.trigger('toggler:toggled', this);
      }

      if (this.hideAfter) {
        this.$el.hide();
      }

      return this;
    };

    /**
     * Public method to unbind all events this instance bound.
     * @return {[type]}
     */
    TogglerProto.destroy = function() {
      return this.setListeners(false);
    };

    return Toggler;

  }());
});
