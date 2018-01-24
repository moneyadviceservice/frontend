class CorporateCategoriesController < CategoriesController
  decorates_assigned :category, with: CorporateCategoryDecorator
  decorates_assigned :article, with: ContentItemDecorator

  before_action :paywall_debt_advice_evaluation_toolkit

  def show
    super
    @article = corporate_article_resource
    @corporate_category = corporate_resource
    assign_active_categories(@corporate_category)
  end

  private

  def paywall_debt_advice_evaluation_toolkit
    if params[:id] == 'debt-advice-evaluation-toolkit' && session[:agreement_token].blank?
      redirect_to "/#{I18n.locale}/agreements/debt_evaluation_toolkit/new"
    end
  end

  def corporate_article_resource
    Mas::Cms::Corporate.find(default_article_id, locale: I18n.locale)
  end

  def corporate_resource
    Mas::Cms::Category.find('corporate-home', locale: I18n.locale)
  end

  def default_article_id
    category.contents.first.id
  end
end
