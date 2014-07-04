require 'core/interactors/news_article_reader'
require 'core/interactors/news_reader'

class NewsController < ApplicationController
  decorates_assigned :news_article, with: NewsArticleDecorator
  decorates_assigned :news, with: NewsArticleDecorator

  def index
    @news = Core::NewsReader.new.call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.home
  end

  def show
    @news_article = Core::NewsArticleReader.new(params[:id]).call do
      not_found
    end
  end
end
