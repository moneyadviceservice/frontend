require_relative '../page'

module UI::Pages
  class NewsArticle < UI::Page
    set_url '{/locale}/news{/id}'

    element :content, '.l-main'
    element :date,    '.smallprint'
  end
end
