require_relative '../page'
require_relative '../sections/promo'

module UI::Pages
  class HomeBeta < UI::Page
    set_url '/{locale}/home-beta'

    element :popular_tools, '.tool_promo-beta'
    element :seasonal_spotlight, '.seasonal-spotlight'
  end
end
