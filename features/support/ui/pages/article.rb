require_relative '../page'
require_relative '../sections/category_nav'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :intro, '.l-article-intro'
    element :main_content, '.l-article-main'
    element :related_categories, '.related-categories'
    element :related_content, '.related-links'
    element :breadcrumbs, '.l-context-bar'

    section :category_nav, UI::Sections::CategoryNav, '.l-category-nav'
  end
end
