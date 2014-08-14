require_relative '../page'
require_relative '../sections/category_nav'

module UI::Pages
  class TechnicalFeedback < UI::Page
    set_url '{/locale}/feedback/new'

    element :attempting, '.t-technical-feedback__attempting'
    element :occurred, '.t-technical-feedback__occurred'
    element :submit_button, '.t-technical-feedback__submit'
  end
end
