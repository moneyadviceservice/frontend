class NewsController < ApplicationController
  decorates_assigned :news_article, with: NewsArticleDecorator
  decorates_assigned :news, with: NewsDecorator
  decorates_assigned :latest_news, with: NewsDecorator

  def index
    @news = Core::NewsReader.new(params).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.home
  end

  def show
    @news_article = Core::NewsArticleReader.new(params[:id]).call do |error|
      if error.redirect?
        return redirect_to error.location, status: error.status
      else
        not_found
      end
    end

    @breadcrumbs = BreadcrumbTrail.build(@news_article, category_tree)
  end
end
