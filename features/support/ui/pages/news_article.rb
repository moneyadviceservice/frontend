require_relative '../page'

module UI::Pages
  class NewsArticle < UI::Page
    set_url '{/locale}/news{/id}'
  end
end
