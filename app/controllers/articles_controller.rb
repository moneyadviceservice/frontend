require 'core/interactors/article_reader'

class ArticlesController < ApplicationController
  decorates_assigned :article, with: ArticleDecorator
  decorates_assigned :related_categories, with: CategoryDecorator

  def show
    @article = Core::ArticleReader.new(params[:id]).call do
      not_found
    end
    @related_categories = filtered_related_categories(@article)
  end

  private

  def filtered_related_categories(article)
    article.categories.each_with_object([]) do |category, memo|
      # Remove the article from the category's contents collection
      category.contents.reject! { |a| a == article }

      # Now only include the category if there are still contents
      if category.contents.present?
        memo << category
      end
    end
  end
end
