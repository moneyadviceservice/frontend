require_relative '../page'
require_relative '../sections/category_nav'

module UI::Pages
  class ActionPlan < UI::Page
    set_url '{/locale}/action_plans{/id}'

    element :content, '.l-main'
    element :breadcrumbs, '.l-context-bar'

    section :category_nav, UI::Sections::CategoryNav, 'nav .link-list-primary'
  end
end
