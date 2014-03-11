require_relative '../page'
require_relative '../sections/header'
require_relative '../sections/footer_social_links'

module UI::Pages
  class SearchResults < UI::Page
    set_url '{/locale}/search'

    elements :results, '.search-results__item'
  end
end
