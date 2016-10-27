class AmpArticlesController < ActionController::Base
  include NotFound

  decorates_assigned :article, with: AmpArticleDecorator
  before_action :retrieve_article

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
