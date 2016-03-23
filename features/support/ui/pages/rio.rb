require_relative '../page'

module UI::Pages
  class Rio < UI::Page
    set_url '/{locale}/{tool_name}/{id}'
  end
end
