require_relative '../page'

module UI::Pages
  class Settings < UI::Page
    set_url '{/locale}/users/edit'
    set_url_matcher %r((en|cy)/users/edit)

    element :first_name, "input[name='user[first_name]']"
    element :email, "input[name='user[email]']"
    element :password, "input[name='user[password]']"
    element :password_confirmation, "input[name='user[password_confirmation]']"
    element :current_password, "input[name='user[current_password]']"
    element :post_code, "input[name='user[post_code]']"
    element :contact_number, "input[name='user[contact_number]']"
    element :opt_in_for_research, "input[name='user[opt_in_for_research]'][type='checkbox']"

    element :submit, "input[value='Update']"
  end
end
