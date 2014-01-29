module LocaleHelper
  attr_accessor :current_locale

  def language_to_locale(language)
    self.current_locale = { english: 'en', welsh: 'cy' }.fetch(language.downcase.to_sym) do
      raise "Could not convert `#{language}' to a locale"
    end
  end
end

World(LocaleHelper)
