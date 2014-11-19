require_relative '../page'

module UI::Pages
  class Profile < UI::Page
    set_url '{/locale}/users/profile/edit'

    element :heading, 'h1'
    element :goal_statement, '#goal_form input[name="goal_statement"]'
    element :goal_deadline, '#goal_form input[name="goal_deadline"]'
    element :goal_save, '#goal_form input[type="submit"]'
    element :saved_tools_message, '.l-profile__your-tools p'
    element :saved_tools_list, '.l-profile__your-tools ul'
  end
end
