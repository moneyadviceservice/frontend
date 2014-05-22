require_relative '../section'

module UI::Sections
  class Promo < UI::Section
    element :heading, '.promo__heading'
    element :content, '.promo__content'
  end
end
