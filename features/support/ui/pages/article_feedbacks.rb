require_relative '../page'
require_relative '../sections/category_nav'

module UI::Pages
  class ArticleFeedback < UI::Page
    set_url '{/locale}/articles{/id}/feedback/new'

    element :was_page_useful, '.t-article-feedback__was-page-useful'
    element :suggestions, '.t-article-feedback__suggestions'
    element :submit_button, '.t-article-feedback__submit'
  end
end
