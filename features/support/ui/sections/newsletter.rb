require_relative '../section'

module UI::Sections
  class Newsletter < UI::Section
    element :email, '.t-newsletter-email'
    element :signup, '.t-newsletter-button'
  end
end
