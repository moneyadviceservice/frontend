define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {

  'use strict';

  var Glossary;

  Glossary = function($el, config) {
    Glossary.baseConstructor.call(this, $el, config);

    var article = $('[data-dough-glossary-content]'),
        articleContent = $(article).html(),
        updatedContent;

    $.getJSON('/glossary.json', function(data){
      data.glossary.map(function (item) {

        // If the article content contains any of the keywords in the JSON
        if(articleContent.indexOf(item.term) >= 1){

          console.log('The term ' + item.term + ' has been found in this article')

          $(item).each(function(){
            var updatedContent = articleContent.replace(RegExp("(?!<.*?)\\b(" + item.term + ")\\b(?![^<>]*?(<\/a>|<\/h2>|<\/h3>|>))","i"),
                                                               "<button class='unstyled-button glossary__term' aria-label='" + item.term + " (see description)'>" + item.term + "</button><span class='glossary__description'><span class='glossary__description-title'>" + item.term + "</span>" + item.description + "<button class='glossary__description-close'>close</button></span>");
            articleContent = updatedContent;
            $(article).html(updatedContent);
          });
          
        };
      });

      // Show descriptions
      $('.glossary__term').on('click', function(){
        event.stopPropagation();
        $(this).next('.glossary__description').addClass('glossary__description--active');
      });

      // Close descriptions using button
      $('.glossary__description-close').on('click', function(){
        $(this).parents('.glossary__description').removeClass('glossary__description--active');
        console.log('closed');
      });

      // Close descriptions by clicking outside description element
      $('body').click(function() {
        if(!$(this.target).is('.glossary__description')) {
          $(".glossary__description").removeClass('glossary__description--active');
        }
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