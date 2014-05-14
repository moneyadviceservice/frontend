require_relative '../page'

module UI::Pages
  class Home < UI::Page
    set_url '/{locale}'

    element :strapline, '.home-feature__content h1'
    element :feature_list, '.home-feature__list'
    element :feature_list_items, '.home-feature__list-item'
    elements :promoted_items, '.home-promoted__item'

    element :contact_heading, 'h2.contact__heading'
    element :contact_introduction, '.contact__text'
    element :contact_number, '.contact__number'
  end
end
