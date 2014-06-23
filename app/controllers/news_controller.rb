require 'core/interactors/news_article_reader'

class NewsController < ApplicationController
  def show
    @news_article = Core::NewsArticleReader.new(params[:id]).call do
      not_found
    end
  end
end
