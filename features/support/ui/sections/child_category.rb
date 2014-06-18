require_relative '../section'

module UI::Sections
  class ChildCategory < UI::Section
    element :heading, 'h2'
    element :title, 'h2'

    # can be a list of categories or content items
    elements :items, 'ol li a'
  end
end
