require 'site_prism'
require_relative 'sections/footer_site_links'

module UI
  class Page < SitePrism::Page
    element :heading, 'h1'

    element :description, :xpath, "//meta[@name='description']", visible: false

    section :footer_site_links, UI::Sections::FooterSiteLinks, '.footer-site-links'
  end
end
