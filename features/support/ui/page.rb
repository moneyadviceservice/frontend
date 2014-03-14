require 'site_prism'
require_relative 'sections/cookie_message'
require_relative 'sections/footer_site_links'
require_relative 'sections/search_box'

module UI
  class Page < SitePrism::Page
    element :heading, 'h1'

    element :description, :xpath, "//meta[@name='description']", visible: false
    element :canonical_tag, :xpath, "//link[@rel='canonical']", visible: false
    element :alternate_tag, :xpath, "//link[@rel='alternate']", visible: false

    section :cookie_message, UI::Sections::CookieMessage, '.cookie-message'
    section :search_box, UI::Sections::SearchBox, '.search-box'
    section :footer_site_links, UI::Sections::FooterSiteLinks, '.footer-site-links'
  end
end
