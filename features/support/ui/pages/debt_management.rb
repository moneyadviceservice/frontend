require_relative '../page'

module UI::Pages
  class DebtManagement < UI::Page
    set_url '{/locale}/campaigns/debt-management'

    element :heading, 'h1'
  end
end
