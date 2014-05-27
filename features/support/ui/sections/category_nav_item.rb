require_relative '../section'

module UI::Sections
  class CategoryNavItem < UI::Section
    element :title, '.link-list-primary__link'
    elements :categories, '.link-list-secondary__item'
    elements :selected_categories, '.link-list-secondary__item.is-selected'
  end
end
