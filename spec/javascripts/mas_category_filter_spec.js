//= require spec_helper
//= require templates/category_filter

describe('mas_category_filter', function() {
  'use strict';

  var template,
      $body,
      CategoryFilter,
      $categories;

  before(function(done) {
    template = JST['templates/category_filter']();

    require(['category_filter'], function(_CategoryFilter) {
      CategoryFilter = _CategoryFilter;
      done();
    }, done);
  });

  beforeEach(function() {
    $body = $('body').html(template);
    new CategoryFilter();
    $categories = $body.find('.category-detail__content');
  });

  describe('on initialisation', function() {
    it('marks "All" as selected', function() {
      var all = $body.find('.category-filter__list-item:first');
      expect(all.hasClass('is-selected')).to.be.true;
    });

    it('displays all the categories', function() {
      $.each($categories, function(i) {
        expect($($categories[i]).hasClass('is-on')).to.be.true;
      });
    });
  });

  describe('when selecting the first category', function() {
    var $item;

    beforeEach(function() {
      $item = $body.find('.category-filter__list-item:nth-child(2)');
      $item.trigger('click');
    });

    it('marks "First" as selected', function() {
      expect($item.hasClass('is-selected')).to.be.true;
    });

    it('displays the category', function() {
      expect($($categories[0]).hasClass('is-on')).to.be.true;
    });

    it('hides the other categories', function() {
      expect($($categories[1]).hasClass('is-off')).to.be.true;
    });
  });

  describe('when selecting "All" after selecting the first category', function() {
    var $item,
        $all;

    beforeEach(function() {
      $item = $body.find('.category-filter__list-item:nth-child(2)');
      $all = $body.find('.category-filter__list-item:first');
      $item.trigger('click');
      expect($($categories[1]).hasClass('is-off')).to.be.true;
      $all.trigger('click');
    });

    it('marks "All" as selected', function() {
      expect($all.hasClass('is-selected')).to.be.true;
    });

    it('displays all the categories', function() {
      $.each($categories, function(i) {
        expect($($categories[i]).hasClass('is-on')).to.be.true;
      });
    });
  });
});
