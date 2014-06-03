require 'core/interactors/article_reader'
require 'core/interactors/breadcrumbs_reader'

class ArticlesController < ApplicationController
  decorates_assigned :article, with: CategoryDecorator
  decorates_assigned :breadcrumb_trails, with: BreadcrumbTrailsDecorator

  def show
    @article = Core::ArticleReader.new(params[:id]).call do
      not_found
    end

    @breadcrumb_trails = @article.categories.map do |category|
      Core::BreadcrumbsReader.new(category.id, category_tree).call
    end

    render Feature.active?(:left_hand_nav) ? :show_v2 : :show
  end
end
