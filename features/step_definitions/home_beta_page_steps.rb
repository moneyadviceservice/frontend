include ActionView::Helpers::SanitizeHelper

Given(/^I view the beta home page in (.*)$/) do |language|
  locale = language_to_locale(language)
  home_beta_page.load(locale: locale)
end

Then(/^I should be presented with popular tools and calculators$/) do
  expect(home_beta_page.popular_tools)
    .to have_content(I18n.t('home.show.tools_heading'))
end

Then(/^I should be presented with the seasonal spotlight$/) do
  save_and_open_page
  expected_en = "Easy ways to catch the saving habit"
  expected_cy = "Ffyrdd hawdd i ddal y arferiad cynilo"

  expect(home_beta_page.seasonal_spotlight)
    .to have_content(eval("expected_#{I18n.locale}"))
end