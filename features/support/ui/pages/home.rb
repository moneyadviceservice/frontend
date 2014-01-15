require_relative '../page'
require_relative '../sections/header_section'
require_relative '../sections/footer_section'

module UI::Pages
  class Home < UI::Page
    set_url '/'

    element :heading, 'h1'
    element :summary_list, 'ul.specialList'
    element :introduction_text, '#introductionText'

    section :header, UI::Sections::Header, '.header'
    section :footer, UI::Sections::Footer, '.footerSocialLinks'
  end
end
