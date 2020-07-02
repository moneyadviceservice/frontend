require_relative '../page'

module UI::Pages
  class MoneyNavigatorQuestionnaire < UI::Page
    set_url '/en/tools/money-navigator/questionnaire'

    element :continue, '.button--continue'
  end
end
