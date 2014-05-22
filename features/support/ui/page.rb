require 'site_prism'
require_relative 'sections/footer_cookie_message'
require_relative 'sections/footer_site_links'
require_relative 'sections/footer_social_links'
require_relative 'sections/opt_out_bar'
require_relative 'sections/header'
require_relative 'sections/search_box'

module UI
  class Page < SitePrism::Page
    element :heading, 'h1'

    elements :alternate_tags, :xpath, "//link[@rel='alternate']", visible: false
    element :canonical_tag, :xpath, "//link[@rel='canonical']", visible: false
    element :description, :xpath, "//meta[@name='description']", visible: false

    element :contact_heading, '.contact__heading'
    element :contact_introduction, '.contact__introduction'
    element :contact_number, '.bubble__text'
    section :footer_cookie_message, UI::Sections::FooterCookieMessage, '.cookie-message'
    section :footer_site_links, UI::Sections::FooterSiteLinks, '.footer-site-links'
    section :footer_social_links, UI::Sections::FooterSocialLinks, '.footer-social-links'
    section :opt_out_bar, UI::Sections::OptOutBar, '.opt-out'
    section :header, UI::Sections::Header, '.l-header'
    section :search_box, UI::Sections::SearchBox, '.search-box'
  end
end
