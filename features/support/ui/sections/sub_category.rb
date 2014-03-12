require_relative '../section'

module UI::Sections
  class SubCategory < UI::Section
    element :title, 'h2'

    elements :subcategories, 'ol li a'
  end
end
