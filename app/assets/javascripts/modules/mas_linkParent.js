define(['jquery'], function ($) {

  "use strict";

  var defaults = {
    target: '.js-linkParent'
  }

  var LP = function(options){
    var o = $.extend(defaults, options),
        _this = this;

    $(o.target).each( _this.setupLinkWrap );
  };

  LP.prototype.setupLinkWrap = function(i,el){
    var $el = $(el),
        href = $el.attr('href');

    if(!href) return;

    $el.parent().on('click', function(){
      document.location = href;
    })
  }

  return LP;

})
