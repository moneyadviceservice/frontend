require_relative '../page'

module UI::Pages
  class MoneyManager < UI::Page
    set_url '/en/tools/money-manager/'

    element :received_first_payment_true,
            'input[name="questionnaire[received_first_payment]"][value="true"]'
    element :received_first_payment_false,
            'input[name="questionnaire[received_first_payment]"][value="false"]'
    element :single_or_in_couple_single,
            'input[name="questionnaire[single_or_in_couple]"][value="single"]'
    element :single_or_in_couple_couple,
            'input[name="questionnaire[single_or_in_couple]"][value="couple"]'
    element :submit,
            "form[action='/en/tools/money-manager'] button[type='submit']"
  end
end
