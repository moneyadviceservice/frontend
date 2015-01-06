require_relative '../page'

module UI::Pages
  class Video < UI::Page
    set_url '{/locale}/videos{/id}'

    element :content, '.l-main'
    element :related_categories, '.related-categories'
  end
end
