require 'core/interactors/article_reader'

class ArticlesController < ApplicationController
  decorates_assigned :article, with: ArticleDecorator

  def show
    @article = Core::ArticleReader.new(params[:id]).call
  end
end
