require_relative '../page'

module UI::Pages
  class Settings < UI::Page
    set_url '{/locale}/users/edit'

    element :name, "input[name='user[first_name]']"
    element :email, "input[name='user[email]']"
    element :password, "input[name='user[password]']"
    element :password_confirm, "input[name='user[password_confirmation]']"
    element :current_password, "input[name='user[current_password]']"
    element :post_code, "input[name='user[post_code]']"
    element :newsletter_subscription, "input[name='user[newsletter_subscription]']"

    element :submit, "input[value='Update']"
  end
end
