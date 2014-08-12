require 'site_prism'
require_relative 'sections/newsletter'
require_relative 'sections/footer_cookie_message'
require_relative 'sections/footer_primary'
require_relative 'sections/footer_secondary'
require_relative 'sections/footer_social_links'
require_relative 'sections/opt_out_bar'
require_relative 'sections/header'
require_relative 'sections/search_box'
require_relative 'sections/auth'

module UI
  class Page < SitePrism::Page
    element :heading, 'h1'

    elements :alternate_tags, :xpath, "//link[@rel='alternate']", visible: false
    element :canonical_tag, :xpath, "//link[@rel='canonical']", visible: false
    element :description, :xpath, "//meta[@name='description']", visible: false

    element :contact_heading, '.t-contact-heading'
    element :contact_introduction, '.t-contact-introduction'
    element :contact_number, '.t-contact-number'
    section :newsletter, UI::Sections::Newsletter, '.t-newsletter'
    section :footer_cookie_message, UI::Sections::FooterCookieMessage, '.cookie-message'
    section :footer_primary, UI::Sections::FooterPrimary, '.t-footer-primary'
    section :footer_secondary, UI::Sections::FooterSecondary, '.t-footer-secondary'
    section :footer_social_links, UI::Sections::FooterSocialLinks, '.t-footer-social-links'
    section :opt_out_bar, UI::Sections::OptOutBar, '.opt-out'
    section :header, UI::Sections::Header, '.l-header'
    section :search_box, UI::Sections::SearchBox, '.search'
    section :auth, UI::Sections::Auth, '.authentication'
  end
end
