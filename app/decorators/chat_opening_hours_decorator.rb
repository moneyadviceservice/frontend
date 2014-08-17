class ChatOpeningHoursDecorator < Draper::Decorator
  def open?
    status == :open
  end

  def status
    if Feature.inactive?(:chat)
      :inactive
    elsif object.now_open?
      :open
    else
      :closed
    end
  end

  def call_to_action
    case status
      when :inactive, :open
        I18n.t('contact_panels.chat.unavailable.call_to_action')
      else
        I18n.t('contact_panels.chat.offline.call_to_action')
    end
  end

  def description
    case status
      when :inactive
        I18n.t('contact_panels.chat.coming_soon.description_html')
      when :open
        I18n.t('contact_panels.chat.available.description')
      else
        I18n.t('contact_panels.chat.offline.description')
    end
  end
end
