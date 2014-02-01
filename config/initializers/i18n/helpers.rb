module I18n
  def self.with_locale(locale, &block)
    origin_locale = self.locale
    self.locale = locale
    return_value = yield
    self.locale = origin_locale
    return_value
  end

  def self.valid_locales
    I18n.available_locales.reject { |locale| locale == :root }
  end
end

