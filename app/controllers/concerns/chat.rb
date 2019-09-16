module Chat
  extend ActiveSupport::Concern

  included do
    helper_method def chat_opening_hours
      @chat_opening_hours ||=
        ChatOpeningHoursDecorator.decorate(Rails.application.config.chat_opening_hours)
    end
    helper_method def pensions_opening_hours
      @pensions_opening_hours ||=
        ChatOpeningHoursDecorator.decorate(Rails.application.config.pensions_opening_hours)
    end
  end
end
