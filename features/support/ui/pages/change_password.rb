require_relative '../page'

module UI::Pages
  class ChangePassword < UI::Page
    set_url '{/locale}/users/password/edit'

    element :password, "input[name='user[password]']"
    element :password_confirmation, "input[name='user[password_confirmation]']"
    element :submit, "input[value='Change my password']"
  end
end
