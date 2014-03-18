require 'site_prism'
require_relative 'sections/cookie_message'
require_relative 'sections/footer_site_links'
require_relative 'sections/footer_social_links'
require_relative 'sections/header'
require_relative 'sections/search_box'

module UI
  class Page < SitePrism::Page
    element :heading, 'h1'

    element :alternate_tag, :xpath, "//link[@rel='alternate']", visible: false
    element :canonical_tag, :xpath, "//link[@rel='canonical']", visible: false
    element :description, :xpath, "//meta[@name='description']", visible: false

    section :cookie_message, UI::Sections::CookieMessage, '.cookie-message'
    section :footer_site_links, UI::Sections::FooterSiteLinks, '.footer-site-links'
    section :footer_social_links, UI::Sections::FooterSocialLinks, '.footer-social-links'
    section :header, UI::Sections::Header, '.header'
    section :search_box, UI::Sections::SearchBox, '.search-box'
  end
end
