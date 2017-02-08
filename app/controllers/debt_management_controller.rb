class DebtManagementController < ApplicationController
  layout '_unconstrained'

  COMPANY_LIST_ARTICLE_ID = 'debt-management-companies'

  private

  def company_list
    return @company_list if @company_list
    @company_list = Core::ArticleReader.new(COMPANY_LIST_ARTICLE_ID).call do
      not_found
    end
    @company_list = ContentItemDecorator.decorate(@company_list)
  end
  helper_method :company_list

  def hide_contact_panels?
    true
  end
  helper_method :hide_contact_panels?

end
