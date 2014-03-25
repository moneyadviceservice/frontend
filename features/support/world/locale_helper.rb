module LocaleHelper
  attr_accessor :current_locale
  attr_accessor :current_language

  def language_to_locale(language)
    self.current_locale = { english: 'en', welsh: 'cy' }.fetch(language.downcase.to_sym) do
      raise "Could not convert `#{language}' to a locale"
    end
  end

  def locale_to_language(locale)
    self.current_language = { en: 'english', cy: 'welsh' }.fetch(locale) do
      raise "Could not convert `#{locale}' to language"
    end
  end
end

World(LocaleHelper)
