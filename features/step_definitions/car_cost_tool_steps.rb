When(/^I view the Car Cost Tool in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  paths = {
    en:  "/en/tools/#{ToolMountPoint::CarCostTool::EN_ID}",
    cy:  "/cy/tools/#{ToolMountPoint::CarCostTool::CY_ID}"
  }

  VCR.use_cassette('car_cost_tool/get_manufacturers') do
    visit paths[locale]
  end
end

Then(/^I should see the Car Cost Tool in (.*)$/) do |language|
  locale = language_to_locale(language).to_sym
  expect(current_page).to have_content(I18n.t('car_cost_tool.search_introduction_heading', locale: locale))
end

When(/^I translate the Car Cost Tool into (.*)$/) do |language|
  locale           = language_to_locale(language)
  current_language = locale_to_language(I18n.locale)

  expect(current_page.footer_secondary.send("#{language.downcase}_link")[:lang]).to eq(locale)
  expect(current_page.footer_secondary).to_not send("have_#{current_language}_link")

  VCR.use_cassette('car_cost_tool/get_manufacturers') do
    current_page.footer_secondary.send("#{language.downcase}_link").click
  end
end
