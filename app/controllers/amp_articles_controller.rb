class AmpArticlesController < ActionController::Base
  decorates_assigned :article, with: ContentItemDecorator
  before_action :retrieve_article

  private
  # This has come from Application controller.  We need to split this stuff out into a separate mixin
  def not_found
    fail ActionController::RoutingError.new('Not Found')
  end

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
