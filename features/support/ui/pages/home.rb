require_relative '../page'
require_relative '../sections/header'
require_relative '../sections/footer_social_links'

module UI::Pages
  class Home < UI::Page
    set_url '/{locale}'

    element :summary_list, 'ul.list--benefits'
    element :introduction_text, '#introduction-text'

    element :contact_heading, '.home-contact__header h2'
    element :contact_introduction, '.home-contact__introduction'
    element :contact_details, '.home-contact__details'

    section :header, UI::Sections::Header, '.header'
    section :footer_social_links, UI::Sections::FooterSocialLinks, '.footer-social-links'
  end
end
