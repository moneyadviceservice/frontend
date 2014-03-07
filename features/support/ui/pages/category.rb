require_relative '../page'
require_relative '../sections/sub_category'

module UI::Pages
  class Category < UI::Page
    set_url '{/locale}/categories{/id}'

    element :heading, 'h1'
    element :description, '#description'

    sections :sub_categories, UI::Sections::SubCategory, 'article'
  end
end
