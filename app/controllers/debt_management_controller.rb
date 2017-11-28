class DebtManagementController < ApplicationController
  layout '_unconstrained'

  COMPANY_LIST_ARTICLE_ID = 'debt-management-companies'

  private

  def company_list
    @company_list ||= ContentItemDecorator.decorate(resource)
  end
  helper_method :company_list

  def hide_contact_panels?
    true
  end
  helper_method :hide_contact_panels?

  def resource
    Mas::Cms::Article.find(
      COMPANY_LIST_ARTICLE_ID,
      locale: I18n.locale
    )
  end
end
