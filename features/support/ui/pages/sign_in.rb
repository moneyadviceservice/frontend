require_relative '../page'

module UI::Pages
  class SignIn < UI::Page
    set_url '{/locale}/users/sign_in'

    element :email, "input[name='user[email]']"
    element :password, "input[name='user[password]']"
    element :submit, "input[value='Sign in']"

    element :forgot_password, "a[href='/en/users/password/new']"
  end
end
