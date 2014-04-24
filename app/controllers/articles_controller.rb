require 'core/interactors/article_reader'

class ArticlesController < ApplicationController
  decorates_assigned :article, with: ArticleDecorator
  decorates_assigned :related_categories, with: CategoryDecorator

  def show
    @article = Core::ArticleReader.new(params[:id]).call do
      not_found
    end
    @related_categories = @article.categories
  end
end
