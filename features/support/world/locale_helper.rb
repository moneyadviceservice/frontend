module LocaleHelper
  def language_to_locale(language)
    { english: 'en', welsh: 'cy' }.fetch(language.downcase.to_sym) do
      raise "Could not convert `#{language}' to a locale"
    end
  end
end

World(LocaleHelper)
