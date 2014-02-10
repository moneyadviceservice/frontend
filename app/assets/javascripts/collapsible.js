$(document).ready(function () {

  var collapsibleSection = $('.collapsible-section'),
      collapsibleButton = $('.collapsible');

  collapsibleSection.hide();

  collapsibleButton.append('<span class="icon icon--open"></span><span class="visually-hidden">Hide this section</span>');

  collapsibleButton.on('click', function(event) {
    $(this).find('.icon').toggleClass('icon--open icon--closed');
    collapsibleSection.slideToggle(1000);
    event.stopPropagation();

  });
});