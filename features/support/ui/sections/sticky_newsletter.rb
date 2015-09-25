require_relative '../section'

module UI::Sections
  class StickyNewsletter < UI::Section
    element :subscription_email, "input[name='subscription[email]']"
    element :send_me_money_advice, ".button--newsletter"
    element :close_button, '.news-signup-sticky__close'
  end
end
