require_relative '../page'

module UI::Pages
  class DebtManagementCompanies < UI::Page
    set_url '{/locale}/campaigns/debt-management/companies'

    element :heading, 'h1'
  end
end
