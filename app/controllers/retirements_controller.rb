class RetirementsController < ApplicationController
  layout 'layouts/_unconstrained'
  helper_method :locale_options

  EN_ACTION_IDS = {
    index: 'pensions-and-retirement',
    budgeting: 'pensions-and-retirement/budgeting'
  }

  CY_ACTION_IDS = {
    index: 'pensiynau-ac-ymddeoliad',
    budgeting: 'pensiynau-ac-ymddeoliad/cyllidebu'
  }

  def locale_options
    {
      en: "/en/#{EN_ACTION_IDS[params[:action].to_sym]}",
      cy: "/cy/#{CY_ACTION_IDS[params[:action].to_sym]}"
    }.except(I18n.locale)
  end

  def display_menu_button_in_header?
    false
  end
end
