require_relative '../section'

module UI::Sections
  class SearchBox < UI::Section
    element :input, 'input.search-box__input'
    element :submit, 'button.search-box__submit'
  end
end
