require_relative '../page'
require_relative '../sections/promo'
require_relative '../sections/trust_banner'

module UI::Pages
  class Home < UI::Page
    set_url '/{locale}'

    section :trust_banner, UI::Sections::TrustBanner, '.trust-banner'

    sections :promos, UI::Sections::Promo, '.promo'

    element :feature_list, '.home-feature__list'
    elements :promoted_items, '.home-promoted__item'
    element :directory_items, '.directory'
  end
end
