class ArticlesController < ApplicationController
  decorates_assigned :article, with: ContentItemDecorator
  decorates_assigned :related_content, with: CategoryDecorator

  include Navigation

  def show
    @article = Core::ArticleReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = BreadcrumbTrail.build(@article, category_tree)
    @related_content = CategoriesWithRestrictedContents.build(@article.categories,
      RelatedContent.build(@article))

    @article.categories.each do |category|
      active_category category.id
      active_category category.parent_id if category.child?
    end
  end
end
