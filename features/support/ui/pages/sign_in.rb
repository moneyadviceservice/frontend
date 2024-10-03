require_relative '../page'

module UI::Pages
  class SignIn < UI::Page
    set_url '{/locale}/users/sign_in'

    element :email, "input[name='user[email]']"
    element :password, "input[name='user[password]']"
    element :submit, '.t-submit'

    element :forgot_password, ".registration__links a"
  end
end
