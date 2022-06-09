Given(/^that I visit the internal server error page in my "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  internal_server_error_page.load(locale: locale)
end

Given(/^that I visit a non\-existent page in "([^"]*)"$/) do |language|
  locale = language_to_locale(language)
  visit "/#{locale}/tools/i_dont_exist"
end

Then(/^I should get an internal server "([^"]*)"$/) do |error_message|
  expect(page).to have_content(error_message)
end

Then(/^I should get redirected to the moneyhelper 404 page for "([^"]*)"$/) do |language|
  locale = language_to_locale(language)
  url = "https://www.moneyhelper.org.uk/#{locale}/404"
  expect(page).to have_content("If this wasn't an integration test, you'd be redirected to: #{url}")
end
