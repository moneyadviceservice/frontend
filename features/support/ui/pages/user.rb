require_relative '../page'

module UI::Pages
  class User < UI::Page
    set_url '{/locale}/users{/id}/edit'
  end
end
