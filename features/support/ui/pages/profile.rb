require_relative '../page'

module UI::Pages
  class Profile < UI::Page
    set_url '{/locale}/users/profile/edit'

    element :heading, 'h1'
    element :saved_tools_message, '.l-profile__your-tools p'
    element :saved_tools_list, '.l-profile__your-tools ul'
  end
end
