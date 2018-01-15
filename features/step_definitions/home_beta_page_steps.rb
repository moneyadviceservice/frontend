include ActionView::Helpers::SanitizeHelper

Given(/^I (?:am on|visit) the beta home page$/) do
  home_beta_page.load(locale: :en)
end

Then(/^I should be presented with popular tools and calculators$/) do
  expect(home_beta_page.popular_tools)
    .to have_content(I18n.t('home.show.tools_heading'))
end