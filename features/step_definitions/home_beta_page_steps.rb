include ActionView::Helpers::SanitizeHelper

Given(/^I view the beta home page in (.*)$/) do |language|
  locale = language_to_locale(language)
  home_beta_page.load(locale: locale)
end

Then(/^I should be presented with popular tools and calculators$/) do
  expect(home_beta_page.popular_tools)
    .to have_content(I18n.t('home.show.tools_heading'))
end

Then(/^I should be presented with the seasonal spotlight in English$/) do
  expect(home_beta_page.seasonal_spotlight)
    .to have_content('Easy ways to catch the saving habit')
end

Then(/^I should be presented with the seasonal spotlight in Welsh$/) do
  expect(home_beta_page.seasonal_spotlight)
    .to have_content('Ffyrdd hawdd i ddal y arferiad cynilo')
end
