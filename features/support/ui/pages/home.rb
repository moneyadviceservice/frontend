require_relative '../page'
require_relative '../sections/promo'

module UI::Pages
  class Home < UI::Page
    set_url '/{locale}'

    element :directory_items, '.directory'
    element :feature_list, '.home-feature__list'
    element :trust_banner_heading, '.t-trust-banner-heading'

    elements :promoted_items, '.home-promoted__item'

    sections :promos, UI::Sections::Promo, '.promo'
  end
end
