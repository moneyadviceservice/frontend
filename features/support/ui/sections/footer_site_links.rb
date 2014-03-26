require_relative '../section'

module UI::Sections
  class FooterSiteLinks < UI::Section
    element :partners_link, 'ul.footer-site-links__internal-links li:nth-child(2)'
    element :cookie_guide_link, '.footer-site-links__cookie-message a'
    element :welsh_link, '#cyLink'
    element :english_link, '#enLink'
    element :opt_out_button, '.footer-site-links__opt_out'
  end
end
