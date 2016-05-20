require_relative '../page'
require_relative '../sections/promo'
require_relative '../sections/trust_banner'
require_relative '../sections/stripe_banner'

module UI::Pages
  class Home < UI::Page
    set_url '/{locale}'

    section :trust_banner, UI::Sections::TrustBanner, '.home-top-trust'
    section :stripe_banner, UI::Sections::StripeBanner, '.stripe-banner'

    sections :promos, UI::Sections::Promo, '.t-article-promos'
    sections :promos_no_image, UI::Sections::Promo, '.t-article-promos-no-image'

    element :feature_list, '.home-feature__list'
    elements :promoted_items, '.home-promoted__item'
    element :directory_items, '.directory'
  end
end
