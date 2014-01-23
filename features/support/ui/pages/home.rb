require_relative '../page'
require_relative '../sections/header'
require_relative '../sections/footer_site_links'
require_relative '../sections/footer_social_links'

module UI::Pages
  class Home < UI::Page
    set_url '/'

    element :heading, 'h1'
    element :summary_list, 'ul.list-benefits'
    element :introduction_text, '#introduction-text'

    section :header, UI::Sections::Header, '.header'
    section :footer_site_links, UI::Sections::FooterSiteLinks, '.footer-site-links'
    section :footer_social_links, UI::Sections::FooterSocialLinks, '.footer-social-links'
  end
end
