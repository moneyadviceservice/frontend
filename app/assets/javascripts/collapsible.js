"use strict";

// Add the aria hidden attribute to the collapsible content section.
//var showTip = function(el) {
//  el.setAttribute('aria-hidden', 'true');
//}

$(document).ready(function () {

  var showFirst = true,
      activeClass = 'js-active',
      sections = [],

// variable need to be refactored so it can toggle between "hide this text" and "show..."
      headingIcon = '<span class="icon icon--toggle"></span><span class="visually-hidden">Show this section</span>';


  function show(i){
    var item = sections[i];
    item.icon.text('Show this section');
    item.trigger.removeClass(activeClass);
    item.target.removeClass(activeClass);
    item.target.removeAttr('aria-hidden');
    item.hidden = false;
    console.log(item)
  }

  function hide(i){
    var item = sections[i];
    item.icon.text('Hide this section');
    item.trigger.addClass(activeClass);
    item.target.addClass(activeClass);
    item.target.attr('aria-hidden', 'true');
    item.hidden = true;
  }


  $('.collapsible').each(function(i,el){
    var $el = $(el);

    sections[i] = {
      index: i,
      trigger: $el,
      target: $el.next('.collapsible-section'),
      hidden: $el.hasClass(activeClass)
    }

    // Setup DOM
    var buttonTitle = sections[i].trigger.text();
    sections[i].trigger.html('<button class="button--unstyled">' + headingIcon + buttonTitle  + '</button>');
    sections[i].icon = sections[i].trigger.find('.visually-hidden');

    // Bind events
    sections[i].trigger.on('click', i, function(){
      (sections[i].hidden)? show(i) : hide(i);
    });

    // Trigger events
    if(showFirst && i >= 1){
      sections[i].trigger.trigger('click');
    }
  })

});