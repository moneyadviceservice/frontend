require_relative '../page'
require_relative '../sections/category_nav'
require_relative '../sections/feedback_panel'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :content, '.l-main'
    element :related_categories, '.related-categories'
    element :breadcrumbs, '.l-context-bar'

    section :category_nav, UI::Sections::CategoryNav, 'nav .link-list-primary'
    section :feedback_panel, UI::Sections::FeedbackPanel, '.feedback-panel'
  end
end
