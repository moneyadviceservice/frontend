require_relative '../page'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :intro, '.l-article-intro'
    element :main_content, '.l-article-main'
    element :related_categories, '.related-categories'
    element :related_content, '.related-links'
  end
end
