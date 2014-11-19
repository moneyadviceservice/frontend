require_relative '../page'

module UI::Pages
  class Account < UI::Page
    set_url '{/locale}/users/profile/edit'
    set_url_matcher %r((en|cy)/users/profile/edit)

    element :my_account_link, "header a:contains('My Account')"
  end
end
