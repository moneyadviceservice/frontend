"use strict";

$(document).ready(function () {

  var showFirst = true,
      activeClass = 'js-active',
      sections = [],
      headingIcon = '<span class="icon icon--open"></span><span class="visually-hidden">Hide this section</span>';

  function toggleSection(e, options){
    var data = e.data;
    data.trigger.toggleClass(activeClass);
    data.target.toggleClass(activeClass);
  }

  $('.collapsible').each(function(i,el){
    var $el = $(el);

    sections[i] = {
      index: i,
      trigger: $el,
      target: $el.next('.collapsible-section')
    }

    var buttonTitle = sections[i].trigger.text();
    sections[i].trigger.html('<button class="button--unstyled">' + buttonTitle + '</button>' + headingIcon);
    sections[i].trigger.on('click', sections[i], toggleSection);

    if(showFirst && i >= 1){
      sections[i].trigger.trigger('click');
    }
  })

});