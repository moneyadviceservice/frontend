
define(['jquery'], function ($) {

  "use strict";

  console.log('! v3')

  var defaults = {
    triggerEl: '.collapsible',
    targetEl: '.collapsible-section',
    activeClass: 'js-active',
    headingIcon: '<span class="icon icon--toggle"></span><span class="visually-hidden">{{txt}}</span>',
    closeOffFocus: false,
    accordion: false,
    showOnlyFirst: false,
    textString: {
      show_this_section: 'Show this section',
      hide_this_section: 'Hide this section'
    }
  };

  var Collapsible = function(opts){
    this.o = $.extend(defaults, opts);
    this.sections = [];

    var triggers = $(this.o.triggerEl),
        l = triggers.length;

    if(l === 0) MAS.warn('mas_collapsible => no trigger elements in page: ' + this.o.triggerEl);

    while(l--){
      Collapsible.prototype._setupEach.call(this, l, triggers[l])
    }
  }

  Collapsible.prototype._setupEach = function(i,el){
    var $el = $(el);

    this.sections[i] = {
      index: i,
      trigger: $el,
      target: $el.next('.collapsible-section'),
      hidden: $el.hasClass(this.o.activeClass)
    }

    // Wrap in button element to assist with accessibility
    var buttonTitle = this.sections[i].trigger.text();
    // this.sections[i].trigger.html('<button class="button--unstyled">' + this.o.headingIcon + buttonTitle  + '</button>');
    this.sections[i].trigger.prepend(this.o.headingIcon);
    this.sections[i].trigger.attr('aria-role','button');
    this.sections[i].trigger.attr('tabindex', '0');
    this.sections[i].icon = this.sections[i].trigger.find('.visually-hidden');

    console.log('ariaHiddenVal = '+ariaHiddenVal)
    var ariaHiddenVal = (this.sections[i].hidden)? 'true' : 'false';
    this.sections[i].target.attr('aria-hidden', ariaHiddenVal);

    // Bind events
    var _this = this;
    this.sections[i].trigger.on('click', i, function(){
      (_this.sections[i].hidden)? _this.show(i) : _this.hide(i);
    });

    this.sections[i].trigger.on('keyup', function(e){
      if(e.which === 32) {
        _this.sections[i].trigger.trigger('click');
      }
    })

    // Trigger events
    if(this.o.showOnlyFirst && i >= 1){
      this.sections[i].trigger.trigger('click');
    }
  }

  Collapsible.prototype.show = function(i){
    var item = this.sections[i];
    item.icon.text('Show this section');
    item.trigger.removeClass(this.o.activeClass);
    item.target.removeClass(this.o.activeClass);
    item.target.attr('aria-hidden', 'false');
    item.hidden = false;
  }
  
  Collapsible.prototype.hide = function(i){
    var item = this.sections[i];
    item.icon.text('Hide this section');
    item.trigger.addClass(this.o.activeClass);
    item.target.addClass(this.o.activeClass);
    item.target.attr('aria-hidden', 'true');
    item.hidden = true;
  }

  return Collapsible;
});
