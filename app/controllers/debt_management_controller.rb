class DebtManagementController < ApplicationController
  layout '_unconstrained'

  def show
  end

  def faq
  end

  def hide_contact_panels?
    true
  end
  helper_method :hide_contact_panels?
end
