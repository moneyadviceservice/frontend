Given(/^that I visit the internal server error page in my "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  internal_server_error_page.load(locale: locale)
end

Given(/^that I visit a non\-existent page in my "([^"]*)"$/) do |language|
  visit '/en/tools/i_dont_exist'
end

Then(/^I should get an internal server "([^"]*)"$/) do |error_message|
  expect(page).to have_content(error_message)
end

Then(/^I should get a page not found error with this "([^"]*)"$/) do |status_code|
  expect(current_page.status_code).to eq(status_code.to_i)
end
