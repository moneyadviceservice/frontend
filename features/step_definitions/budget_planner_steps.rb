When(/^I view the Budget Planner in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  paths = {
    en:  "/en/tools/#{ToolMountPoint::BudgetPlanner::EN_ID}",
    cy:  "/cy/tools/#{ToolMountPoint::BudgetPlanner::CY_ID}",
  }

  visit paths[locale]
end

Then(/^I should see the Budget Planner in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  expect(current_page).to have_content(I18n.t('budget_planner.home.start.long_form.heading', locale: locale))
end

When(/^I translate the Budget Planner into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(current_page.footer_secondary.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(current_page.footer_secondary).to_not send("have_#{current_language}_link")

  current_page.footer_secondary.send("#{language.downcase}_link").click
end
