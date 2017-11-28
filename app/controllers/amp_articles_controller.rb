class AmpArticlesController < ActionController::Base
  protect_from_forgery with: :exception

  include NotFound

  rescue_from Mas::Cms::HttpRedirect, with: :redirect_page
  rescue_from Mas::Cms::Errors::ResourceNotFound, with: :not_found

  newrelic_ignore_enduser

  decorates_assigned :article, with: AmpArticleDecorator
  before_action :retrieve_article

  def show
    redirect_to url_for(
      action: 'show',
      controller: 'articles',
      id: @article.id,
      only_path: false
    ) unless @article.supports_amp || params[:no_redirect]
  end

  private

  def retrieve_article
    @article ||= Mas::Cms::Article.find(params[:article_id], locale: I18n.locale)
  end

  def redirect_page(e)
    redirect_to e.location, status: e.http_response.status
  end
end
