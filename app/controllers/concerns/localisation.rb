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
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def alternative_locales
    I18n.available_locales - Array(I18n.locale)
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def not_found
    head :not_found
  end
end
