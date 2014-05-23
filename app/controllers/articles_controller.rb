require 'core/interactors/article_reader'
require 'core/interactors/category_parents_reader'

class ArticlesController < ApplicationController

  decorates_assigned :article, with: ArticleDecorator
  decorates_assigned :category_hierarchy, with: CategoryDecorator

  include Navigation

  def show
    @article = Core::ArticleReader.new(params[:id]).call do
      not_found
    end

    @category_hierarchy = build_category_hierarchy

    if Feature.active?(:left_hand_nav)
      render :show_v2
    else
      (@article.categories.compact.map(&:id) + @article.parent_category_ids).each do |category|
        active_category category
      end

      render :show
    end
  end

  private

  def build_category_hierarchy
    if @article.one_parent?
      category = @article.categories.first
      Core::CategoryParentsReader.new(category).call + [category]
    else
      []
    end
  end
end
