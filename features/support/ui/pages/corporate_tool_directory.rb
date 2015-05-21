require_relative '../page'

module UI::Pages
  class CorporateToolDirectory < UI::Page
    set_url '{/locale}/corporate/syndication'

    element :popular_tools_heading, '.popular_tools_heading'
    element :all_tools_heading, '.all_tools_heading'
  end
end
