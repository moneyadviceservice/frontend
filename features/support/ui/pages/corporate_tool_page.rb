require_relative '../page'

module UI::Pages
  class CorporateTool < UI::Page
    set_url '{/locale}/corporate/budget-planner-syndication'

    element :organisation_name, "input[name='partner[name]']"
    element :organisation_email, "input[name='partner[email]']"
    element :tool_language, "#partner_tool_language_en"
    element :tool_width_unit, "#partner_tool_width_unit_px"
    element :tool_width, "input[name='partner[tool_width]']"

    element :submit, "input[type='submit']"
  end
end
