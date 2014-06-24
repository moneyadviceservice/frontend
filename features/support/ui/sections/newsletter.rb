require_relative '../section'

module UI::Sections
  class Newsletter < UI::Section
    element :email, '.newsletter__input'
    element :signup, '.newsletter__button'
  end
end
