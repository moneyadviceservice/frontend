require_relative '../page'

module UI::Pages
  class Tools < UI::Page
    set_url '{/locale}/tools/{/id}'
  end
  class Engine < UI::Page
    set_url '{/id}'
  end
end
