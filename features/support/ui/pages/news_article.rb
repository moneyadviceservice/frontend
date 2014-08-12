require_relative '../page'

module UI::Pages
  class NewsArticle < UI::Page
    set_url '{/locale}/news{/id}'

    element :content, '.l-main'
    element :date,    '.t-news-article-date'
    element :breadcrumbs, '.l-context-bar'

    elements :latest_news, '.related-links li'
  end
end
