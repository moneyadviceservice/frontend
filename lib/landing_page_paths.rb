module LandingPagePaths
  def self.locale_options(controller, action, locale = I18n.locale)
    I18n.available_locales.map do |l|
      [l, path_with_locale(controller, action, l)]
    end.to_h.except(locale)
  end

  def self.path_with_locale(controller, action, locale = I18n.locale)
    "/#{locale}/#{path(controller, action, locale)}"
  end

  def self.path(controller, action, locale = I18n.locale)
    I18n.t("landing_pages.paths.#{controller}.#{action}", locale: locale)
  end
end
