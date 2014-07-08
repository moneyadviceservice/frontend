class NewsController < ApplicationController
  decorates_assigned :news_article, with: NewsArticleDecorator
  decorates_assigned :news, with: NewsArticleDecorator

  def index
    @news = Core::NewsReader.new(params[:page]).call do
      not_found
    end
  end

  def show
    @news_article = Core::NewsArticleReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.build(@news_article, category_tree)
  end
end
