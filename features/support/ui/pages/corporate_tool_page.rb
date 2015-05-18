require_relative '../page'

module UI::Pages
  class CorporateTool < UI::Page
    set_url '{/locale}/corporate/budget-planner-syndication'

    element :organisation_name, "input[name='/[organisation]']"
    element :organisation_email, "input[name='/[email]']"
    element :tool_language, "input[name='/[lang]']"
    element :tool_width_unit, "input[name='/[width-unit]']"
    element :tool_width, "input[name='/[width]']"

    element :submit, "button[type='submit']"
  end
end
