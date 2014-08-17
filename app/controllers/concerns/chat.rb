module Chat
  extend ActiveSupport::Concern

  included do
    helper_method def chat_opening_hours
                    @chat_opening_hours ||=
                      ChatOpeningHoursDecorator.decorate(Rails.application.config.chat_opening_hours)
                  end
  end
end
