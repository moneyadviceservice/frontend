require_relative '../page'

module UI::Pages
  class SignUp < UI::Page
    set_url '{/locale}/users/sign_up'

    element :first_name, "input[name='user[first_name]']"
    element :email, "input[name='user[email]']"
    element :password, "input[name='user[password]']"
    element :password_confirmation, "input[name='user[password_confirmation]']"
    element :post_code, "input[name='user[post_code]']"
    element :submit, "input[value='Sign up']"
  end
end
