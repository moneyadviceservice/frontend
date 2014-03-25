module HomeHelper
  def alternate_home_map
    I18n.available_locales.each_with_object({}) do |locale, map|
      map["#{locale}-GB"] = root_url(locale: locale)
    end
  end
end
