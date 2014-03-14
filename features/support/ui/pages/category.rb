require_relative '../page'
require_relative '../sections/child_category'

module UI::Pages
  class Category < UI::Page
    set_url '{/locale}/categories{/id}'

    element :description, '.intro'

    # can have one of the following two
    sections :child_categories, UI::Sections::ChildCategory, '.category-detail'
    elements  :items, 'ol li a'
  end
end
