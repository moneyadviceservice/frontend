require_relative '../page'

module UI::Pages
  class MoneyManager < UI::Page
    set_url '/en/tools/money-manager/'

    element :received_first_payment_true,
            '#questionnaire_received_first_payment_true'
    element :received_first_payment_false,
            '#questionnaire_received_first_payment_false'
    element :single_or_in_couple_single,
            '#questionnaire_single_or_in_couple_single'
    element :submit,
            "form[action='/en/tools/money-manager'] button[type='submit']"
  end
end
