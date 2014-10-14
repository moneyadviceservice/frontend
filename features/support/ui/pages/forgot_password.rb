require_relative '../page'

module UI::Pages
  class ForgotPassword < UI::Page
    set_url '{/locale}/users/password/new'

    element :email, "input[name='user[email]']"
    element :submit, "input[value='Send me reset password instructions']"
  end
end
