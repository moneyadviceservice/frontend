define(['jquery', 'typeahead'], function($, typeahead) {
  'use strict';

  var GoogleComplete = function(options) {
    $(options.input).typeahead({}, {
      source: this.completions
    });
  };

  GoogleComplete.prototype.completions = function(query, cb) {
  }

  return GoogleComplete;
});
