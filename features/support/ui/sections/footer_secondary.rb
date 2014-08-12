require_relative '../section'

module UI::Sections
  class FooterSecondary < UI::Section
    element :cookie_guide_link, '.footer-site-links__cookie-message a'
    element :welsh_link, '#cyLink'
    element :english_link, '#enLink'
    element :opt_out_button, '.t-opt-out-button'
  end
end
