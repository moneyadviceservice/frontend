require_relative '../page'

module UI::Pages
  class StickyNewsletter < UI::Page
    set_url '{/locale}/'

    element :subscription_email, "input[name='subscription[email]']"
  end
end
