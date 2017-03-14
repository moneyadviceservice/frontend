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
            var updatedContent = articleContent.replace(RegExp("(?!<.*?)\\b(" + item.term + ")\\b(?![^<>]*?(<\/a>|<\/h2>|<\/h3>|>))","gi"),
                                                               "<button class='unstyled-button glossary__term' aria-label='" + item.term + " (see description)'>" + item.term + "</a></button><span class='glossary__description'><span class='glossary__description-title'>" + item.term + "</a></span>" + item.description + "<button class='glossary__description-close'><svg xmlns='http://www.w3.org/2000/svg' \
        class='svg-icon svg-icon--mobile-close-box'><use xmlns:xlink='http://www.w3.org/1999/xlink' xlink:href='#svg-icon--mobile-close-box'>\
        </use></svg></button></span>");

            articleContent = updatedContent;
            $(article).html(updatedContent);

          });
          
        };
      });

      // Show descriptions
      $('.glossary__term').on('click', function(){
        $(".glossary__description").removeClass('glossary__description--active');
        $(this).next('.glossary__description').addClass('glossary__description--active');

        // Calculate parent container width and apply its width to the tooltip width
        // Determine the clicked elements verticle position in the document and substract the height to position the tooltip
        var container = $('html,body'),
        scrollTo = $('.glossary__description--active'),
        tooltipWidth = $('.l-article-3col-main').innerWidth() - 10,
        top = $(this).position().top - scrollTo.outerHeight() - 10;

        // apply top positioning and width to tooltip class using tooltipWidth and top variables
        $('.glossary__description').css({top: top, width: tooltipWidth});

        // scroll and animate tooltip to the top of the page
        container.animate({
            scrollTop: scrollTo.offset().top - container.offset().top - 70 + container.scrollTop()
        });

        return false;
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
