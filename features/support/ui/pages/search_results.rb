require_relative '../page'
require_relative '../sections/header'
require_relative '../sections/pagination'
require_relative '../sections/footer_social_links'

module UI::Pages
  class SearchResults < UI::Page
    set_url '{/locale}/search'

    element  :robots_tag, :xpath, "//meta[@name='robots']", visible: false
    element  :spelling_suggestion, '.t-spelling-suggestion'
    elements :results, '.search-results__item'
    section  :pagination, UI::Sections::Pagination, '.pagination'
  end
end
