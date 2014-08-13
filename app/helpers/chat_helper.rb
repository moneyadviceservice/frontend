module ChatHelper
  def chat_open?
    Rails.application.config.chat_opening_hours.now_open?
  end
end
