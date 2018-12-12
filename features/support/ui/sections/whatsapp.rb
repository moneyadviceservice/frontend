require_relative '../section'

module UI::Sections
  class Whatsapp < UI::Section
    element :button, '.t-whatsapp-button'
    element :description, '.t-whatsapp-description'
    element :javascript_warning, '.t-whatsapp-javascript'
    # element :opening_times, '.t-chat-opening-times'
    element :smallprint, '.t-welsh-smallprint'
  end
end
