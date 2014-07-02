class NewsController < ApplicationController
  decorates_assigned :news_article, with: NewsArticleDecorator

  def show
    @news_article = Core::NewsArticleReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.build(@news_article, category_tree)
  end
end
