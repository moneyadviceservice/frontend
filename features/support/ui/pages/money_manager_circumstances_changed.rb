require_relative '../page'

module UI::Pages
  class MoneyManagerCircumstancesChanged < UI::Page
    set_url '/en/tools/money-manager/circumstances-changed'

    element :received_first_payment_true,
            '#questionnaire_received_first_payment_true'
    element :received_first_payment_false,
            '#questionnaire_received_first_payment_false'
    element :single_or_in_couple_single,
            '#questionnaire_single_or_in_couple_single'
    element :single_or_in_couple_couple,
            '#questionnaire_single_or_in_couple_couple'
  end
end
