
define(['log', 'jquery'], function (Global, $) {
  "use strict";

  var defaults = {
    // Setup
    triggerEl: '.collapsible',
    targetEl: '.collapsible-section',
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
      show_this_section: 'Show this section',
      hide_this_section: 'Hide this section'
    }
  };

  $.fn.swapClass = function(from,to){
    var c = this[0].className;
    if( c.indexOf(to) !== -1 ){
      return;
    }else if( c.indexOf(from) === -1 ){
      this[0].className = c + ' ' + to;
    }else{
      this[0].className = c.replace(from,to);
    }
  }

  var Collapsible = function(opts){

    this.o = $.extend({}, defaults, opts);
    this.sections = [];
    this.selected = false;

    var _this = this,
        triggers = $(this.o.triggerEl),
        l = triggers.length,
        i = 0;

    if(l === 0) return Global.warn('mas_collapsible => no trigger elements in page: ' + this.o.triggerEl);

    for(i; i<l; i++){
      this._setupEach.call(this, i, triggers[i]);
    }

    if(this.o.closeOffFocus){
      this.$parent = $(this.o.parentWrapper);

      if(!this.o.parentWrapper || !this.$parent.length) {
        Global.warn('options.parentWrapper should be set & valid for closeOffFocus to work properly');
        return;
      }

      this.$parent.on('focusout', function(e){
        setTimeout(function(){
          if( _this.$parent.find(document.activeElement).length === 0 ){
            _this.hide(_this.selected);
          }
        },10)
      })
    }
  }

  Collapsible.prototype._modifyButtonHTML = function(i){
    var trigger = this.sections[i].trigger,
        target =  this.sections[i].target,
        icon = (this.o.showIcon)? trigger.prepend(this.o.headingIcon.replace('{{txt}}', this.o.textString.show_this_section)): '';

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
  }

  Collapsible.prototype._setupEach = function(i,el){
    var $el = $(el);
    var _this = this;

    this.sections[i] = {
      index: i,
      trigger: $el,
      target: $el.next(this.o.targetEl),
      hidden: !$el.hasClass(this.o.activeClass)
    }

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

    // if(this.o.closeOffFocus){
    //   if(!this.o.parentWrapper) {Global.warn('options.parentWrapper should be set for closeOffFocus to work properly')}

    //   this.sections[i].target.on('focusout', function(e){
    //     setTimeout(function(){
    //       console.log('focusout => ' + document.activeElement)
    //       if( _this.sections[i].target.find(document.activeElement).length === 0 ){
    //         _this.hide(i);
    //       }
    //     },10)
    //   })
    // }
  }

  Collapsible.prototype.show = function(i){
    var item = this.sections[i];
    if(this.o.showIcon) item.icon.text(this.o.textString.show_this_section);
    item.trigger.swapClass(this.o.inactiveClass, this.o.activeClass);
    item.target.swapClass(this.o.inactiveClass, this.o.activeClass);
    item.target.attr('aria-hidden', 'false');
    item.hidden = false;

    if (this.o.accordion && (this.selected !== false && this.selected !== i)) this.hide(this.selected);
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
