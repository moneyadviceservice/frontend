require_relative '../section'

module UI::Sections
  class SearchBox < UI::Section
    element :input, Feature.active?(:new_header) ? '.search__input' : '.search-box__input'
    element :submit, Feature.active?(:new_header) ? '.search__submit' : '.search-box__submit'
  end
end
