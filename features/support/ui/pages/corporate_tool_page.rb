require_relative '../page'

module UI::Pages
  class CorporateTool < UI::Page
    set_url '{/locale}/corporate/budget-planner-syndication'

    element :organisation_name, "input[name='corporate_partner[name]']"
    element :organisation_email, "input[name='corporate_partner[email]']"
    element :tool_language, "#corporate_partner_tool_language_en"
    element :tool_width_unit, "#corporate_partner_tool_width_unit_px"
    element :tool_width, "input[name='corporate_partner[tool_width]']"

    element :submit, "input[type='submit']"
  end
end
