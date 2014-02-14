require_relative '../section'

module UI::Sections
  class FooterSiteLinks < UI::Section
    element :welsh_link, '#cyLink'
    element :english_link, '#enLink'
  end
end
