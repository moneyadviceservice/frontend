class PacsController < EmbeddedToolsController
  def exclude_syndicated_iframe_resizer?
    true
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      Authenticable.authenticate(username, password)
    end
  end

  def authentication_required?
    Authenticable.staging? || Rails.env.production?
  end

  def category_id
    nil
  end
  helper_method :category_id
end
