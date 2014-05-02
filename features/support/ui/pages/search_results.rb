require_relative '../page'
require_relative '../sections/header'
require_relative '../sections/pagination'
require_relative '../sections/footer_social_links'

module UI::Pages
  class SearchResults < UI::Page
    set_url '{/locale}/search'

    element  :robots_tag, :xpath, "//meta[@name='robots']", visible: false
    elements :results, '.search-results__item'
    section  :pagination, UI::Sections::Pagination, '.pagination'
  end
end
