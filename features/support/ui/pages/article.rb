require_relative '../page'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :content, '.l-main'
    element :related_categories, '.related-categories'
    element :related_content, '.related-links'
    element :breadcrumbs, '.l-context-bar'
  end
end
