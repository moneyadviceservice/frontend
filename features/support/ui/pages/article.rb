require_relative '../page'
require_relative '../sections/category_nav'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :content, '.l-article-3col-main'
    element :related_categories, '.related-categories'
    element :breadcrumbs, '.l-context-bar'
    element :end_of_article_signup, '.js-end-of-article-signup'
    element :technical_feedback_link, '.t-inline-feedback__technical-feedback-link'

    section :category_nav, UI::Sections::CategoryNav, 'nav .link-list-primary'
  end
end
