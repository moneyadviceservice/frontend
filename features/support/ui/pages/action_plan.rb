require_relative '../page'

module UI::Pages
  class ActionPlan < UI::Page
    set_url '{/locale}/action_plans{/id}'

    element :content, '.l-main'
    element :breadcrumbs, '.l-context-bar'
  end
end
