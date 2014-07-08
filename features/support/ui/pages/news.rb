require_relative '../page'

module UI::Pages
  class News < UI::Page
    set_url '{/locale}/news{?page}'

    elements :items_titles, '.heading-small'
    elements :items_intros, '.t-news-intro'
    elements :items_dates,  '.smallprint'
    element :newer_button,  '.t-button--previous'
    element :older_button,  '.t-button--next'
  end
end
