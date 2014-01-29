require_relative '../page'

module UI::Pages
  class Article < UI::Page
    set_url '{/locale}/articles{/id}'

    element :heading, 'h1'
  end
end
