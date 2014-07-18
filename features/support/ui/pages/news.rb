require_relative '../page'

module UI::Pages
  class News < UI::Page
    set_url '{/locale}/news{?page_number}'

    elements :items_titles, '.heading-small'
    elements :items_descriptions, '.t-news-description'
    elements :items_dates,  '.smallprint'

    element :newer_button,  '.t-button--previous'
    element :older_button,  '.t-button--next'
    element :breadcrumbs, '.l-context-bar'
  end
end
