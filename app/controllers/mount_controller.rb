class MountController < ApplicationController
  def canonical
    nil
  end
  helper_method :canonical

  protected

  def alternate_url
    new_params = params.dup
    new_params[:script_name] = "/#{alternate_locale}/#{alternate_engine_id}"
    string = url_for(new_params)
    string.split('?').first
  end

  helper_method :alternate_url

  def alternate_options
    {
      "#{params[:locale]}-GB" => request.url,
      "#{alternate_locale}-GB" => alternate_url
    }
  end

  helper_method :alternate_options

  def alternate_locale
    { en: :cy, cy: :en }.fetch(I18n.locale)
  end

  helper_method :alternate_locale

  def contact_panels_border_top?
    true
  end

  private

  def alternate_engine_id
    raise NotImplementedError
  end
end
