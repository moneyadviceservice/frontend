require_relative '../page'

module UI::Pages
  class Profile < UI::Page
    set_url '{/locale}/users/profile'

    element :heading, 'h1'
    element :goal_text, '#goal_form input[name="goal_text"]'
    element :goal_date, '#goal_form input[name="goal_date"]'
    element :goal_save, '#goal_form input[type="submit"]'
  end
end
