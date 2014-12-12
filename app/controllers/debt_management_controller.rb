class DebtManagementController < ApplicationController
  def show
    render layout: '_unconstrained'
  end

  def faq
    render layout: '_unconstrained'
  end

  def hide_contact_panels?
    true
  end
  helper_method :hide_contact_panels?
end
