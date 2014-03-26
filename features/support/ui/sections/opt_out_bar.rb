require_relative '../section'

module UI::Sections
  class OptOutBar < UI::Section
    element :dismiss_button, '.opt-out__button--close'
    element :opt_out_button, '.opt-out__button'
  end
end
