require_relative '../section'

module UI::Sections
  class SubCategory < UI::Section
    element :title, 'h2'

    elements :subcategories, 'ul li a'
  end
end
