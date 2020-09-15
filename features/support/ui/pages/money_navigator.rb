require_relative '../page'

module UI::Pages
  class MoneyNavigator < UI::Page
    set_url '/en/tools/money-navigator/'

    element :get_started, '.landing__actions .button--start'
  end
end
