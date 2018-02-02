class ArticlesController < ApplicationController
  decorates_assigned :article, with: ContentItemDecorator
  decorates_assigned :related_content, with: CategoryDecorator
  decorates_assigned :parent_category, with: CategoryDecorator

  include Navigation

  def show
    @article = resource

    set_breadcrumbs
    set_related_content
    assign_active_categories(*@article.categories)
    set_article_canonical_url
  end

  private

  def resource
    Mas::Cms::Article.find(params[:id], locale: params[:locale])
  end

  def set_breadcrumbs
    @breadcrumbs = BreadcrumbTrail.build(
      @article,
      category_tree(navigation_categories)
    )
  end

  def set_related_content
    @related_content = CategoriesWithRestrictedContents.build(
      @article.categories,
      RelatedContent.build(@article)
    )
  end

  def set_article_canonical_url
    @article_amp_url = article_amp_url(@article.id) if @article.supports_amp
  end

  def default_main_content_location?
    false
  end
end
