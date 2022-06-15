Given(/^that I visit the internal server error page in my "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  internal_server_error_page.load(locale: locale)
end

Then(/^I should get an internal server "([^"]*)"$/) do |error_message|
  expect(page).to have_content(error_message)
end
