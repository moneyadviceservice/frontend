require_relative '../page'

module UI::Pages
  class Profile < UI::Page
    set_url '{/locale}/users/profile'

    element :heading, 'h1'
  end
end
