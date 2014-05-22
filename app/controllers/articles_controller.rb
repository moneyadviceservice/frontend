require 'core/interactors/article_reader'

class ArticlesController < ApplicationController
  before_action :initialize_breadcrumbs

  decorates_assigned :article, with: ArticleDecorator
  decorates_assigned :breadcrumbs, with: CategoryDecorator

  def show
    @article = Core::ArticleReader.new(params[:id]).call do
      not_found
    end

    build_breadcrumbs
  end

  def build_breadcrumbs
    return @breadcrumbs unless uniq_category?

    category = @article.categories.first
    @breadcrumbs = Core::CategoryParentReader.new(category).call << category
  end

  def uniq_category?
    @article.categories.size == 1
  end

  def initialize_breadcrumbs
    @breadcrumbs = []
  end
end
