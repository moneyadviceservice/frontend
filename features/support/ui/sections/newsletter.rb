require_relative '../section'

module UI::Sections
  class Newsletter < UI::Section
    element :email, '.t-newsletter-email'
    element :signup, '.t-newsletter-button'
    element :close_button, '.news-signup-sticky__close'
  end
end
