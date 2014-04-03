require_relative '../page'

module UI::Pages
  class Home < UI::Page
    set_url '/{locale}'

    element :strapline, '.home-feature__content h1'
    element :feature_list, '.home-feature__list'
    element :feature_list_items, '.home-feature__list-item'
    elements :promoted_items, '.home-promoted__item'

    element :contact_heading, '.home-contact__header h2'
    element :contact_introduction, '.home-contact__header p'
    element :contact_details, '.home-contact__details'
  end
end
