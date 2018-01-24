require_relative '../page'
require_relative '../sections/promo'

module UI::Pages
  class HomeBeta < UI::Page
    set_url '/{locale}/home-beta'

    element :popular_tools, '.tool_promo-beta'
    element :seasonal_spotlight, '.seasonal-spotlight'
    element :most_read, '.most-read'
    element :information_guides, '.information-guides'
    element :beta_opt_out, '.opt-in'
  end
end
