
define(['jquery'], function ($) {

  "use strict";

  console.log('! v10')

  var defaults = {
    targetType: 'next',                 // options: next | data | href
    triggerEl: '.collapsible',
    targetEl: '.collapsible-section',
    activeClass: 'is-on',
    inactiveClass: 'is-off',
    showIcon: false,
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
    this.selected = false;

    var triggers = $(this.o.triggerEl),
        l = triggers.length,
        i = 0;

    if(l === 0) return MAS.warn('mas_collapsible => no trigger elements in page: ' + this.o.triggerEl);

    for(i; i<l; i++){
      Collapsible.prototype._setupEach.call(this, i, triggers[i])
    }
  }

  Collapsible.prototype._modifyButtonHTML = function(i){
    // move modify code here for cleaner separation of accessibility stuff
    // Wrap in button element to assist with accessibility
    var buttonTitle = this.sections[i].trigger.text();
    // this.sections[i].trigger.html('<button class="button--unstyled">' + this.o.headingIcon + buttonTitle  + '</button>');
    this.sections[i].trigger.attr('aria-role','button');
    this.sections[i].trigger.attr('tabindex', '0');

    if(this.o.showIcon){
      this.sections[i].trigger.prepend(this.o.headingIcon.replace('{{txt}}', this.o.textString.show_this_section));
      this.sections[i].icon = this.sections[i].trigger.find('.visually-hidden');
    }
  }

  Collapsible.prototype._findTarget = function($el){
    switch(this.o.targetType){
      case 'data':
        // Trigger must have data-target = string that can be interpreted by jQuery
        var d = $el.attr('data-target');
        return $(d);
        break;
      case 'href':
        var href = $el.attr('href');
        if( href.indexOf('#') !== 0 ){
          // HREF must be formatted as #ID
          return false;
        }else{
          return $(href);
        }
        break;
      case 'next':
      default:
        return $el.next(this.o.targetEl);
        break;
    }
  }

  Collapsible.prototype._setupEach = function(i,el){
    var $el = $(el);

    this.sections[i] = {
      index: i,
      trigger: $el,
      target: this._findTarget($el),
      hidden: !$el.hasClass(this.o.activeClass)
    }

    console.log(i +' >> '+this.sections[i].hidden)

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
    (this.sections[i].hidden) ? this.hide(i) : this.show(i);

    // Bind events
    var _this = this;
    this.sections[i].trigger.on('click', i, function(e){
      e.preventDefault();
      (_this.sections[i].hidden)? _this.show(i) : _this.hide(i);
    });

    // Accessibility support for spacebar
    this.sections[i].trigger.on('keypress', function(e){
      if(e.which === 32) {
        _this.sections[i].trigger.trigger('click');
      }
    })

    this.sections[i].target.on('focusout', function(e){
      alert('! focus <output></output>')
    })
  }

  $.fn.swapClass = function(from,to){
    console.log(this)
    var c = this[0].className;
    if( c.indexOf(to) !== -1 ){
      return;
    }else if( c.indexOf(from) === -1 ){
      this[0].className = c + ' ' + to;
    }else{
      this[0].className = c.replace(from,to);
    }
  }

  Collapsible.prototype.show = function(i){
    var item = this.sections[i];
    if(this.o.showIcon) item.icon.text(this.o.textString.show_this_section);
    item.trigger.swapClass(this.o.inactiveClass, this.o.activeClass);
    item.target.swapClass(this.o.inactiveClass, this.o.activeClass);
    item.target.attr('aria-hidden', 'false');
    item.hidden = false;

    if(this.o.accordion && this.selected !== false) this.hide(this.selected);
    this.selected = i;
  }
  
  Collapsible.prototype.hide = function(i){
    var item = this.sections[i];
    if(this.o.showIcon) item.icon.text(this.o.textString.hide_this_section);
    item.trigger.swapClass(this.o.activeClass, this.o.inactiveClass);
    item.target.swapClass(this.o.activeClass, this.o.inactiveClass);
    item.target.attr('aria-hidden', 'true');
    item.hidden = true;
  }

  return Collapsible;
});
