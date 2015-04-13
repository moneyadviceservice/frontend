class ChatOpeningHoursDecorator < Draper::Decorator
  def open?
    object.now_open?
  end

  def status
    open? ? :open : :closed
  end

  def call_to_action
    if open?
      I18n.t('contact_panels.chat.unavailable.call_to_action')
    else
      I18n.t('contact_panels.chat.offline.call_to_action')
    end
  end

  def description
    if open?
      I18n.t('contact_panels.chat.available.description')
    else
      I18n.t('contact_panels.chat.offline.description', hours: next_period_hours).html_safe
    end
  end

  def periods
    @periods ||= begin
      days.each_with_object([]) do |day, result|
        if result.last && result.last.hours == week[day]
          result.last.days << day
        else
          result << Period.new([day], week[day])
        end
        result
      end.map(&:to_s)
    end
  end

  def open_periods
    @open_periods ||= begin
      days.each_with_object([]) do |day, result|
        next if week[day].duration.zero?

        if result.last && result.last.hours == week[day]
          result.last.days << day
        else
          result << Period.new([day], week[day])
        end
        result
      end.map(&:to_s)
    end
  end

  def next_period_hours
    @next_period_hours ||= Hours.new(next_period.open, next_period.close).to_s
  end

  private

  delegate :week

  def days
    @days ||= week.keys.rotate # our week starts on a Monday
  end

  def next_period
    @next_period ||= begin
      time_next_open = Time.parse(object.calculate_deadline(0, Time.zone.now.to_s))
      day_next_open  = time_next_open.strftime('%a').downcase.to_sym

      week[day_next_open]
    end
  end

  Period = Struct.new(:days, :hours) do
    def to_s
      formatted_days = if days.size > 1
                         '%s %s %s' % [I18n.t("date.days.#{days.first}"),
                                       I18n.t('seperator'),
                                       I18n.t("date.days.#{days.last}")]
                       else
                         I18n.t("date.days.#{days.first}")
                       end

      formatted_hours = Hours.new(hours.open, hours.close).to_s

      '%s, %s' % [formatted_days, formatted_hours]
    end
  end

  Hours = Struct.new(:open, :close) do
    def to_s
      '%s&nbsp;%s&nbsp;%s' % [formatted_time(open), I18n.t('seperator'), formatted_time(close)]
    end

    private

    def formatted_time(time)
      t = Time.local(Date.today.year, Date.today.month, Date.today.day)
      t += time.seconds
      t.strftime('%-l%P')
    end
  end
end
