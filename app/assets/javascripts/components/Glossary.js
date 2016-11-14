define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {

  'use strict';

  var Glossary;

  Glossary = function($el, config) {
    Glossary.baseConstructor.call(this, $el, config);

    var article = $('[data-dough-glossary-content]'),
    articleContent = article.text();

    $.getJSON('/glossary.json', function(data){
      var glossaryTerms = data.glossary.map(function (item) {
        if(articleContent.indexOf(item.term) >= 1){

          // var updatedContent = $(article).html().replace(RegExp("\\b" + item.term + "\\b","gi"), "<button class='unstyled-button glossary__term' aria-label='" + item.term + " click for description'>" + item.term + "</button><span class='glossary__description'>" + item.description + "</span>");
          
          var updatedContent = $(article).html().replace(RegExp("\\b" + item.term + "\\b","gi"), "<button class='unstyled-button glossary__term'>" + item.term + "</button><span class='glossary__description'>" + item.description + "</span>");
          $(article).html(updatedContent);

          console.log(updatedContent);
        } else {
          console.log(item.term + ' has not been found in this article')
        };
      });

      // Show descriptions
      $('.glossary__term').on('click', function(){
        $(this).next('.glossary__description').toggle().focus();
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