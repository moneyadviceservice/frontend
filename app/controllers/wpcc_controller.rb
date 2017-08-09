class WpccController < EmbeddedToolsController
  before_action :authenticate

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      Authenticable.authenticate(username, password)
    end
  end

  def category_id
    ''
  end

  helper_method :category_id
end
