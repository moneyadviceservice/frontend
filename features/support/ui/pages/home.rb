require_relative '../page'

module UI::Pages
  class Home < UI::Page
    set_url '/{locale}'

    element :strapline, '.home-feature__header h1'
    element :feature_list, '.home-feature__list'

    element :contact_heading, '.home-contact__header h2'
    element :contact_introduction, '.home-contact__introduction'
    element :contact_details, '.home-contact__details'
  end
end
