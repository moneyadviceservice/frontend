define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {

  'use strict';

  var Glossary;

  Glossary = function($el, config) {
    Glossary.baseConstructor.call(this, $el, config);

    var article = $('[data-dough-glossary-content]'),
    articleContent = article.text();

    $.getJSON('/glossary.json', function(data){
      var glossaryTerms = data.glossary.map(function (item) {
        // If the article content contains any of the keywords in the JSON
        if(articleContent.indexOf(item.term) >= 1){
          var updatedContent = $(article).html().replace(RegExp("\\b" + item.term + "\\b","gi"), "<button class='unstyled-button glossary__term' aria-label='" + item.term + " (see description)'>" + item.term + "</button><span class='glossary__description'><span class='glossary__description-title'>" + item.term + "</span>" + item.description + "<button class='glossary__description-close'>close</button></span>");
          $(article).html(updatedContent);
        } else {
          // For dev purposes
          console.log(item.term + ' has not been found in this article')
        };
      });

      // Show descriptions
      $('.glossary__term').on('click', function(){
        $(this).next('.glossary__description').toggle().focus();
      });

      // Close descriptions
      $('.glossary__description-close').on('click', function(){
        $(this).parents('.glossary__description').hide();
      });

    });

  };

  DoughBaseComponent.extend(Glossary);
  Glossary.componentName = 'Glossary';

  // Initialise the component
  Glossary.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
  };

  return Glossary;
});