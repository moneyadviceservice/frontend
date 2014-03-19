define(['collapsable'], function(Collapsable) {
  var CategoryFilter = function() {
    this.collapsable = new Collapsable({
      triggerEl: '.category-detail__heading',
      targetEl: '.category-detail__content'
    });

    this.showAll();

    var $filters = $('.category-filter__list-item');
    var _this = this;

    $.each($filters, function(i) {
      var $item = $($filters[i]);

      if(i == 0) {
        $item.on('click', function() {
          _this.showAll();
          _this.setSelected(i);
        });
      } else {
        $item.on('click', function() {
          _this.showCategory(i - 1);
          _this.setSelected(i);
        });
      }
    });
  };

  CategoryFilter.prototype.showAll = function() {
    for(var i in this.collapsable.sections) {
      this.collapsable.show(i);
    }
    this.setSelected(0);
  };

  CategoryFilter.prototype.showCategory = function(i) {
    for(var j in this.collapsable.sections) {
      if(i == j) {
        this.collapsable.show(j);
      } else {
        this.collapsable.hide(j);
      }
    }
  };

  CategoryFilter.prototype.setSelected = function(i) {
    $('.category-filter__list-item').removeClass('is-selected');
    $($('.category-filter__list-item')[i]).addClass('is-selected');
  };

  return CategoryFilter;
})
