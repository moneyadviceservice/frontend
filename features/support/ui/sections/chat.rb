require_relative '../section'

module UI::Sections
  class Chat < UI::Section
    element :description, '.t-chat-description'
    element :button, '.t-chat-button'
    element :opening_times, '.t-chat-opening-times'
    element :welsh_warning, '.t-welsh-warning'
  end
end
