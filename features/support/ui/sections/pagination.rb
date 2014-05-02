require_relative '../section'

module UI::Sections
  class Pagination < UI::Section
    element :page_info, '.pagination__counter'
    element :previous_button, '.t-button--previous'
    element :next_button, '.t-button--next'
  end
end
