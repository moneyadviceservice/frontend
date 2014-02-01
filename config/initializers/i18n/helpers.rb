module I18n
  def self.valid_locales
    I18n.available_locales.reject { |locale| locale == :root }
  end
end
