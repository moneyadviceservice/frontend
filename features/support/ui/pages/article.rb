require_relative '../page'
require_relative '../sections/footer_site_links'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :heading, 'h1'
    element :content, '#article-content'

    section :footer_site_links, UI::Sections::FooterSiteLinks, '.footer-site-links'
  end
end
