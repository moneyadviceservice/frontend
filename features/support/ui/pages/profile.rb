require_relative '../page'

module UI::Pages
  class Profile < UI::Page
    set_url '{/locale}/users/profile/edit{?query*}'

    element :heading, 'h1'
    element :goal_statement, '#goal_form input[name="goal_statement"]'
    element :goal_deadline, '#goal_form input[name="goal_deadline"]'
    element :goal_save, '#goal_form input[type="submit"]'
    element :saved_tools_section, '.l-profile__your-tools'
    element :edit_profile_link, '.t-edit-profile'
    element :budget_planner_link, '.t-saved-tool'
  end
end
