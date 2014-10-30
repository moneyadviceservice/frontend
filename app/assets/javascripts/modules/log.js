define(['globals'], function(globals) {
  'use strict';

  // Wrap logging so it can be pushed to log in prod, and used safely on old browsers
  var opts = ['log', 'info', 'warn', 'error'],
      l = opts.length,
      logs = {},
      logged = [],
      useConsole = typeof window !== 'undefined' && window.console &&
        globals.bootstrap.env && typeof Function.prototype.bind === 'function' &&
        globals.bootstrap.env === 'development';

  function logIt(name, options) {
    logged.push([name, options, type]);
  }

  while (l--) {
    var type = l;
    logs[opts[l]] = useConsole ? console[opts[l]].bind(console) : logIt;
  }

  if (typeof window !== 'undefined') window.logged = logged;

  return logs;
});
