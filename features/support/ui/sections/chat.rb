require_relative '../section'

module UI::Sections
  class Chat < UI::Section
    element :button, '.t-chat-button'
    element :description, '.t-chat-description'
    element :javascript_warning, '.t-chat-javascript'
    element :opening_times, '.t-chat-opening-times'
    element :smallprint, '.t-welsh-smallprint'
  end
end
