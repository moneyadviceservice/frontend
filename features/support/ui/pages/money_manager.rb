require_relative '../page'

module UI::Pages
  class MoneyManager < UI::Page
    set_url '/en/tools/money-manager/{?query*}'

    element :country_select_england,
            'input[id="country_england"]'
    element :country_select_northern_ireland,
            'input[id="country_ni"]'
    element :get_started,
            "form[action='/en/tools/money-manager/questionnaire'] input[type='submit']"
  end
end
