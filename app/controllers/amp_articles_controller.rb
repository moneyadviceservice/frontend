class AmpArticlesController < ActionController::Base
  include NotFound

  decorates_assigned :article, with: AmpArticleDecorator
  before_action :retrieve_article

  def show
    redirect_to url_for(action: 'show', controller: 'articles', id: @article.id, only_path: false) unless @article.supports_amp
  end

  private

  def retrieve_article
    @article ||= Core::ArticleReader.new(params[:article_id]).call do |error|
      if error.redirect?
        return redirect_to error.location, status: error.status
      else
        not_found
      end
    end
  end
end
