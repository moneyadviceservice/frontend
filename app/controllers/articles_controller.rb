require 'core/interactors/article_reader'

class ArticlesController < ApplicationController
  decorates_assigned :article, with: ContentItemDecorator

  include Navigation

  def show
    @article = Core::ArticleReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.build(@article, category_tree)

    (@article.categories.map(&:id) + @article.parent_category_ids).each do |category|
      active_category category
    end
  end
end
