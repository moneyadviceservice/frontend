
define(['jquery'], function ($) {

  "use strict";

  var defaults = {
    showOnlyFirst: true,
    toggleClass: '.collapsible',
    targetClass: '.collapsible-section',
    activeClass: 'js-active',
    headingIcon: '<span class="icon icon--toggle"></span><span class="visually-hidden">Show this section</span>'
  };

  var collapsible = function(opts){
    MAS.info('collapsible');

    var _this = this;

    this.o = $.extend(defaults, opts);
    this.sections = [];

    collapsible.prototype.setupEach.call(this);

    var triggers = $(this.o.toggleClass),
    l = triggers.length;

    while(l--){
      collapsible.prototype.setupEach.call(this, l, triggers[l])
    }
  }

  collapsible.prototype.setupEach = function(i,el){

    var $el = $(el);

    this.sections[i] = {
      index: i,
      trigger: $el,
      target: $el.next('.collapsible-section'),
      hidden: $el.hasClass(this.o.activeClass)
    }

    // Wrap in button element to assist with accessibility
    var buttonTitle = this.sections[i].trigger.text();
    this.sections[i].trigger.html('<button class="button--unstyled">' + this.o.headingIcon + buttonTitle  + '</button>');
    this.sections[i].icon = this.sections[i].trigger.find('.visually-hidden');

    // Bind events
    var _this = this;
    this.sections[i].trigger.on('click', i, function(){
      (_this.sections[i].hidden)? _this.show(i) : _this.hide(i);
    });

    // Trigger events
    if(this.o.showOnlyFirst && i >= 1){
      this.sections[i].trigger.trigger('click');
    }

  }

  collapsible.prototype.show = function(i){
    var item = this.sections[i];
    item.icon.text('Show this section');
    item.trigger.removeClass(this.o.activeClass);
    item.target.removeClass(this.o.activeClass);
    item.target.removeAttr('aria-hidden');
    item.hidden = false;
  }
  
  collapsible.prototype.hide = function(i){
    var item = this.sections[i];
    item.icon.text('Hide this section');
    item.trigger.addClass(this.o.activeClass);
    item.target.addClass(this.o.activeClass);
    item.target.attr('aria-hidden', 'true');
    item.hidden = true;
  }

  return collapsible;
});
