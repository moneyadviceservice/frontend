require_relative '../section'

module UI::Sections
  class CategoryNavItem < UI::Section
    element :title, '.link-list-primary__text'
    elements :categories, '.link-list-secondary__item'
    elements :selected_categories, '.link-list-secondary__text.is-selected'
  end
end
