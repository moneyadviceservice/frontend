//= require require_config

require(['common', 'jquery'], function(MAS, $) {
  'use strict';

	var html = document.getElementsByTagName('html')[0]; 

	html.className = html.className.replace('no-js', 'js'); 
	html.className = html.className + ' svg'; 

  require(['componentLoader'], function(componentLoader) {
    componentLoader.init($('body'));
  });
});
