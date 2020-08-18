require_relative '../page'

module UI::Pages
  class MoneyNavigatorQuestionnaire < UI::Page
    set_url '/en/tools/money-navigator/questionnaire'

    element :submit, '.button--submit'

  end
end
