require_relative '../page'
require_relative '../sections/header_section'
require_relative '../sections/footer_section'

module UI::Pages
  class Home < UI::Page
    set_url '/'

    section :header, UI::Sections::Header, '.header'
    section :footer, UI::Sections::Footer, '.footerSocialLinks'
  end
end
