define(['jquery', 'typeahead', 'globals'], function($, typeahead, globals) {
  'use strict';

  var GoogleComplete = function(options) {
    options.input.typeahead({
      minLength: 2
    }, {
      source: this.completions
    }).on('typeahead:selected', function() {
      options.form.submit();
    });
  };

  GoogleComplete.prototype.completions = function(query, cb) {
    var url = 'https://clients1.google.com/complete/search?q=' + query +
      '&hl=en&client=partner&source=gcsc&ds=cse&partnerid=' +
      globals.bootstrap.googleApiCx;

    $.ajax({
      url: url,
      dataType: 'jsonp',
      success: function(data) {
        var results = $.map(data[1], function(item) {
          return { value: item[0] };
        });
        cb(results);
      }
    });
  }

  return GoogleComplete;
});
