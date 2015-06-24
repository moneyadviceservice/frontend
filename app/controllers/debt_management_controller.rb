class DebtManagementController < ApplicationController
  layout '_unconstrained'

  include SuppressMenuButton

  def hide_contact_panels?
    true
  end
  helper_method :hide_contact_panels?
end
