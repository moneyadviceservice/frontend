require_relative '../page'
require_relative '../sections/category_nav'
require_relative '../sections/feedback_panel'
require_relative '../sections/want_to_talk_panel'
require_relative '../sections/sticky_newsletter'
require_relative '../sections/survive_january'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :content, '.l-article-3col-main'
    element :related_categories, '.related-categories'
    element :breadcrumbs, '.l-context-bar'

    section :category_nav, UI::Sections::CategoryNav, 'nav .link-list-primary'
    section :feedback_panel, UI::Sections::FeedbackPanel, '.feedback-panel'

    section :want_to_talk_side_panel, UI::Sections::WantToTalkPanel, '.want-to-talk--sidebar'
    section :want_to_talk_inline_panel, UI::Sections::WantToTalkPanel, '.want-to-talk--inline'
    section :sticky_newsletter, UI::Sections::StickyNewsletter, '.news-signup-sticky'
    section :survive_january_promo, UI::Sections::SurviveJanuary, '.campaign-promo'
  end
end
