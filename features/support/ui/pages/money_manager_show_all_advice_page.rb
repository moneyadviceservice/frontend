require_relative '../page'

module UI::Pages
  class MoneyManagerShowAllAdvice < UI::Page
    set_url '/en/tools/money-manager/to-read?show_all'

    elements :active_advice_list_items,
             'div.advice-list__item-content-text.is-active'
    elements :all_advice_list_items,
             'div.advice-list__item-content-text'
  end
end
