require_relative '../section'

module UI::Sections
  class Chat < UI::Section
    element :chat_heading, '.t-chat-heading'
    element :chat_description, '.t-chat-description'
    element :chat_button, '.t-chat-button'
    element :chat_opening_times, '.t-chat-opening-times'
  end
end
