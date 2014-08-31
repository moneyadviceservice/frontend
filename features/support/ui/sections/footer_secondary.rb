require_relative '../section'

module UI::Sections
  class FooterSecondary < UI::Section
    element :cookie_guide_link, '.footer-site-links__cookie-message a'
    element :welsh_link, '.t-cy-link'
    element :english_link, '.t-en-link'
    element :opt_out_button, '.t-opt-out-button'
  end
end
