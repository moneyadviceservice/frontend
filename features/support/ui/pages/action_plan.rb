require_relative '../page'

module UI::Pages
  class ActionPlan < UI::Page
    set_url '{/locale}/action_plans{/id}'

    element :content, '#action-plan-content'
  end
end
