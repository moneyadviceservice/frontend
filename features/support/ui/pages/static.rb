require_relative '../page'

module UI::Pages
  class Static < UI::Page
    set_url '{/locale}/static{/id}'

    element :content, '.l-main'
  end
end
