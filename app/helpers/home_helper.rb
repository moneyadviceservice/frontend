module HomeHelper
  def alternate_home_map
    alternate_locales.each_with_object({}) do |locale, map|
      map[locale] = root_url(locale: locale)
    end
  end
end
