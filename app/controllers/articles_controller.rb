class ArticlesController < ApplicationController
  decorates_assigned :article, with: ContentItemDecorator
  decorates_assigned :related_content, with: CategoryDecorator

  include Navigation

  def show
    @article = interactor.call do
      not_found
    end

    set_breadcrumbs
    set_related_content
    set_categories
    set_show_newsletter_signup
  end

  private

  def interactor
    Core::ArticleReader.new(params[:id])
  end

  def set_breadcrumbs
    @breadcrumbs = BreadcrumbTrail.build(@article, category_tree)
  end

  def set_related_content
    @related_content = CategoriesWithRestrictedContents.build(@article.categories,
                                                              RelatedContent.build(@article))
  end

  def set_categories
    @article.categories.each do |category|
      active_category category.id
      active_category category.parent_id if category.child?
    end
  end

  def set_show_newsletter_signup
    exclusions = ::NewsletterExclusions::slugs

    exclusions.reject! do |slug|
      slug != params[:id]
    end

    @newsletter_excluded = exclusions.count > 0 || I18n.locale == :cy ? true : false
  end
end
