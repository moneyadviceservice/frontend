require_relative '../section'

module UI::Sections
  class SearchBox < UI::Section
    element :input, '.search__input'
    element :submit, '.search__submit'
  end
end
