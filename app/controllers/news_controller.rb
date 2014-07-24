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
    @news_article = Core::NewsArticleReader.new(params[:id]).call do
      not_found
    end

    @latest_news = Core::NewsReader.new(page_number: 1, limit: 6).call
    @breadcrumbs = BreadcrumbTrail.build(@news_article, category_tree)
  end
end
