require 'core/interactors/article_reader'
require 'core/interactors/category_parents_reader'

class ArticlesController < ApplicationController
  before_action :initialize_breadcrumbs

  decorates_assigned :article, with: ArticleDecorator
  decorates_assigned :category_hierarchy, with: CategoryDecorator

  def show
    @article = Core::ArticleReader.new(params[:id]).call do
      not_found
    end

    build_category_hierarchy
  end

  def build_category_hierarchy
    return @category_hierarchy unless uniq_category?

    category = @article.categories.first
    @category_hierarchy = Core::CategoryParentsReader.new(category).call << category
  end

  def uniq_category?
    @article.categories.compact.size == 1
  end

  def initialize_breadcrumbs
    @category_hierarchy = []
  end
end
