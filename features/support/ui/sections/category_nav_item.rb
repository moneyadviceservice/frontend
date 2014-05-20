require_relative '../section'

module UI::Sections
  class CategoryNavItem < UI::Section
    element :title, '.category-nav__item-title'
    elements :categories, '.category_nav__item-subcategory'
    elements :selected_categories, '.category_nav__item-subcategory--selected'
  end
end
