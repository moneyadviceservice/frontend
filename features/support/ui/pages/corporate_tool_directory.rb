require_relative '../page'

module UI::Pages
  class CorporateToolDirectory < UI::Page
    set_url '{/locale}/corporate/syndication'

    element :popular_tools_heading, '.editorial h2:first-child'
    element :all_tools_heading, '.editorial h2:nth-child(2)'
  end
end
