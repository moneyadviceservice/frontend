module Localisation
  extend ActiveSupport::Concern

  included do
    helper_method :alternative_locales
    before_action :set_locale

    unless Rails.env.development?
      rescue_from I18n::InvalidLocale, with: :not_found
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || request_locale || I18n.default_locale
  end

  def alternative_locales
    I18n.available_locales - Array(I18n.locale)
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def request_locale
    request_locales = request.env['REQUEST_PATH'].to_s.match(I18n.available_locales.join('|'))
    request_locales[0] if request_locales
  end
end
