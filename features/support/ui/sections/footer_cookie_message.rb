require_relative '../section'

module UI::Sections
  class FooterCookieMessage < UI::Section
    element :close_button, 'button.cookie-message__submit'
  end
end
