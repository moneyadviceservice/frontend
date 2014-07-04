require_relative '../page'

module UI::Pages
  class News < UI::Page
    set_url '{/locale}/news'

    elements :items_titles, '.heading-small'
    elements :items_intros, '.t-news-intro'
    elements :items_dates, '.smallprint'
    element :breadcrumbs, '.l-context-bar'
  end
end
