define([], function () {
  'use strict';

  // Wrap logging so it can be pushed to log in prod, and used safely on old browsers
  var MAS = window.MAS,
      opts = ['log', 'info', 'warn', 'error'],
      l = opts.length,
      logs = {},
      logged = [];

  function logIt (name, options) {
    logged.push([name, options, type]);
  }

  while (l--) {
    var type = l;
    logs[opts[l]] = (window && window.console && MAS.bootstrap.env && MAS.bootstrap.env === 'development') ? console[opts[l]].bind(console) : logIt;
  }

  if(window) window.logged = logged;

  return logs;
});