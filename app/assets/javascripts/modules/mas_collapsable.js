
define(['log', 'jquery'], function (Global, $) {
  'use strict';

  var defaults = {
    // Setup
    triggerEl: '.collapsible',
    targetEl: '.collapsible-section',
    targetType: 'class', // class / href / data-attr
    activeClass: 'is-on',
    inactiveClass: 'is-off',
    closeOffFocus: false,
    parentWrapper: false,
    accordion: false,
    showOnlyFirst: false,

    // Display options
    showIcon: false,
    headingIcon: '<span class="icon icon--toggle"></span><span class="visually-hidden">{{txt}}</span>',
    useButton: false,

    // Localised text strings
    textString: {
      showThisSection: 'Show this section',
      hideThisSection: 'Hide this section'
    }
  };

  $.fn.swapClass = function(from, to){
    this.removeClass(from).addClass(to);
  };

  var Collapsible = function(opts){
    this.o = $.extend({}, defaults, opts);
    this.sections = [];
    this.selected = false;

    var _this = this,
        triggers = $(this.o.triggerEl),
        l = triggers.length,
        i = 0;

    if(l === 0){
      return Global.warn('mas_collapsible => no trigger elements in page: ' + this.o.triggerEl);
    }

    for(i; i<l; i++){
      this._setupEach.call(this, i, triggers[i]);
    }

    if(this.o.closeOffFocus){
      this.$parent = $(this.o.parentWrapper);

      if(!this.o.parentWrapper || !this.$parent.length) {
        Global.warn('options.parentWrapper should be set & valid for closeOffFocus to work properly');
        return;
      }

      this.$parent.on('focusout', function(){
        setTimeout(function(){
          if( _this.$parent.find(document.activeElement).length === 0 && _this.selected){
            _this.hide(_this.selected);
          }
        },300);
      });
    }
  };

  Collapsible.prototype._modifyButtonHTML = function(i){
    var trigger = this.sections[i].trigger,
        icon = (this.o.showIcon)? trigger.prepend(this.o.headingIcon.replace('{{txt}}', this.o.textString.showThisSection)): '';

    if(this.o.useButton){
      var buttonTitle = trigger.text();

      if(trigger[0].nodeName === 'A'){
        // Anchor => replace elemnt
        var newEl = $('<a class-"' + trigger[0].className + '" id="' + trigger[0] + '">' + icon + buttonTitle + '</a>');
        // add new
        trigger.after(newEl);
        // remove old
        trigger.remove();
        trigger = newEl;
      }else{
        // Anything else => insert button inside
        trigger.html('<button class="button--unstyled">' + icon + buttonTitle  + '</button>');
      }
    }else{
      // Use aria-role
      trigger.attr('aria-role','button');
      trigger.attr('tabindex', '0');
      trigger.prepend(icon);
    }

    if(this.o.showIcon){
      this.sections[i].icon = trigger.find('.visually-hidden');
    }
  };

  Collapsible.prototype.getTarget = function($el){
    switch(this.o.targetType){
    case 'class':
      return $el.next(this.o.targetEl);
    case 'href':
      var href = $el.attr('href'),
        $t = $(href);
      return ($t.length)? $t : false;
    default:
      return false;
    }
  };

  Collapsible.prototype._setupEach = function(i,el){
    var $el = $(el);
    var _this = this;

    this.sections[i] = {
      index: i,
      trigger: $el,
      target: this.getTarget($el),
      hidden: !$el.hasClass(this.o.activeClass)
    };
    // Dont modify or bind events if no target element
    if(!this.sections[i].target.length) return;

    // Set show / hide states based on options
    if(this.o.showOnlyFirst){
      this.sections[i].hidden = (i === 0)? false : true;
    }

    if(this.o.accordion){
      if(this.selected === false && !this.sections[i].hidden){
      }else{
        this.sections[i].hidden = true;
      }
    }

    // Update Button HTML to make accessible
    this._modifyButtonHTML(i);

    // Set initial state
    this.toggle(!this.sections[i].hidden,i);

    // Bind events
    this.sections[i].trigger.on('click', i, function(e){
      e.preventDefault();
      _this.toggle(_this.sections[i].hidden, i);
    });

    // Accessibility support for spacebar
    this.sections[i].trigger.on('keypress', function(e){
      if(e.which === 32) {
        e.preventDefault();
        _this.sections[i].trigger.trigger('click');
      }
    });
  };

  Collapsible.prototype.toggle = function(show,i){
    if(show){
      this.show(i);
    }else{
      this.hide(i);
    }
  };

  Collapsible.prototype.show = function(i){
    var item = this.sections[i];
    if(this.o.showIcon) item.icon.text(this.o.textString.showThisSection);
    item.trigger.swapClass(this.o.inactiveClass, this.o.activeClass);
    item.target.swapClass(this.o.inactiveClass, this.o.activeClass);
    item.target.attr('aria-hidden', 'false');
    item.hidden = false;

    if (this.o.accordion && (this.selected !== false && this.selected !== i)){
      this.hide(this.selected);
    }
    this.selected = i;
  };

  Collapsible.prototype.hide = function(i){
    var item = this.sections[i];
    if(this.o.showIcon) item.icon.text(this.o.textString.hideThisSection);
    item.trigger.swapClass(this.o.activeClass, this.o.inactiveClass);
    item.target.swapClass(this.o.activeClass, this.o.inactiveClass);
    item.target.attr('aria-hidden', 'true');
    item.hidden = true;
  };

  return Collapsible;
});
