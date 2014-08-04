require_relative '../page'

module UI::Pages
  class SignUp < UI::Page
    set_url '{/locale}/users/sign_up'

    element :email, "input[name='user[email]']"
    element :password, "input[name='user[password]']"
    element :password_confirmation, "input[name='user[password_confirmation]']"
    element :submit, "input[value='Sign up']"
  end
end
