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

  def periods
    days.reduce([]) { |result, day|
      if result.last && result.last.hours == week[day]
        result.last.days << day
      else
        result << OpeningPeriod.new([day], week[day])
      end
      result
    }.map { |opening_period| opening_period.to_s }
  end

  private

  delegate :week

  def days
    week.keys.rotate # our week starts on a Monday
  end

  OpeningPeriod = Struct.new(:days, :hours) do
    def to_s
      formatted_days = if days.size > 1
                         '%s %s %s' % [I18n.t("date.days.#{days.first}"),
                                       I18n.t('seperator'),
                                       I18n.t("date.days.#{days.last}")]
                       else
                         I18n.t("date.days.#{days.first}")
                       end

      '%s, %s %s %s' % [formatted_days,
                        formatted_time(hours.open),
                        I18n.t('seperator'),
                        formatted_time(hours.close)]
    end

    private

    def formatted_time(time)
      t = Time.local(Date.today.year, Date.today.month, Date.today.day)
      t += time.seconds
      t.strftime('%-l%P')
    end
  end
end
