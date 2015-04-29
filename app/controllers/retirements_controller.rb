class RetirementsController < ApplicationController
  layout 'layouts/_unconstrained'

  def alternate_locales
    []
  end

  def display_menu_button_in_header?
    false
  end
end
