require_relative '../section'
require_relative 'category_nav_item'

module UI::Sections
  class CategoryNav < UI::Section
    sections :categories, UI::Sections::CategoryNavItem, '.category-nav__item'
    sections :selected_categories, UI::Sections::CategoryNavItem, '.category-nav__item--selected'
  end
end
