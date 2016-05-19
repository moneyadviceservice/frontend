class ArticlesController < ApplicationController
  decorates_assigned :article, with: ContentItemDecorator
  decorates_assigned :related_content, with: CategoryDecorator
  decorates_assigned :parent_category, with: CategoryDecorator

  include Navigation

  def show
    @article = interactor.call do |error|
      if error.redirect?
        return redirect_to error.location, status: error.status
      else
        not_found
      end
    end

    set_breadcrumbs
    set_related_content
    set_categories
    set_show_newsletter_signup
    set_parent_category
  end

  private

  def interactor
    Core::ArticleReader.new(params[:id])
  end

  def set_breadcrumbs
    @breadcrumbs = BreadcrumbTrail.build(@article, category_tree(navigation_categories))
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

  def set_parent_category
    @parent_category ||= ParentCategory.find(@article, category_tree)
  end

  def set_show_newsletter_signup
    exclude = ::NewsletterExclusions::slugs.include?(params[:id])
    welsh = I18n.locale == :cy

    @newsletter_excluded = exclude || welsh
  end

  def default_main_content_location?
    false
  end

end
