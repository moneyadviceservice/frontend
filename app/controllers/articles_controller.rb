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
    set_show_campaign_promo
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
    exclusions = ::NewsletterExclusions::slugs

    exclusions.reject! do |slug|
      slug != params[:id]
    end

    @newsletter_excluded = newsletter_submitted_cookie_set? || exclusions.count > 0 || (I18n.locale == :cy ? true : false)
  end

  def set_show_campaign_promo
    @campaign_promo_excluded = I18n.locale == :cy ? true : false
  end

end
