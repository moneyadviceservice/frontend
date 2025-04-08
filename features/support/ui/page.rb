require 'site_prism'
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
    section :money_helper_auth, UI::Sections::Auth, '.authentication-links'
    section :auth, UI::Sections::Auth, '.authentication', match: :first
  end
end
